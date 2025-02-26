
locals {
  max_subnet_length = max(
    local.len_private_subnets,
    local.len_public_subnets,
  )
  vpc_id = aws_vpc.vpc.id

  vpc_infrastructure_suffix = format("vpc-%s", var.infrastructure_suffix)

  len_public_subnets                  = max(length(var.public_subnets))
  public_subnet_infrastructure_suffix = format("subnet-%s", var.public_subnet_suffix)

  len_private_subnets                  = max(length(var.private_subnets))
  private_subnet_infrastructure_suffix = format("subnet-%s", var.private_subnet_suffix)

  len_isolated_private_subnets                  = max(length(var.isolated_private_subnets))
  isolated_private_subnet_infrastructure_suffix = format("subnet-%s", var.isolated_private_subnet_suffix)

  internet_gateway_suffix = format("igw-%s", var.infrastructure_suffix)
  nat_gateway_suffix      = format("nat-%s", var.infrastructure_suffix)
  elastic_ip_suffix       = format("eip-%s", var.infrastructure_suffix)

  all_subnets = [for index in range(9) : cidrsubnet(var.cidr, 4, index)]

  # Aloca sub-redes para cada categoria
  public_subnets           = slice(local.all_subnets, 0, 3) # Índices 0, 1, 2
  private_subnets          = slice(local.all_subnets, 3, 6) # Índices 3, 4, 5
  isolated_private_subnets = slice(local.all_subnets, 6, 9) # Índices 6, 7, 8

}
################################################################################
# VPC
################################################################################
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name = local.vpc_infrastructure_suffix
    },
    var.tags,
  )
}

################################################################################
# Publiс Subnets
################################################################################

locals {
  create_public_subnets = local.len_public_subnets > 0
}

resource "aws_subnet" "public" {
  count = (var.create_public_subnets == true && local.create_public_subnets) && (!var.one_nat_gateway_per_az || local.len_public_subnets >= length(var.azs)) ? local.len_public_subnets : 0

  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  # cidr_block           = element(concat(var.public_subnets, [""]), count.index)
  cidr_block = element(local.public_subnets, count.index)
  vpc_id     = local.vpc_id

  tags = merge(
    {
      Name = try(
        var.public_subnet_names[count.index],
        format("${local.public_subnet_infrastructure_suffix}-%s-${var.infrastructure_suffix}", element(var.azs, count.index))
      )
      Tier = "public"
    },
    var.public_subnet_tags,
    lookup(var.public_subnet_tags_per_az, element(var.azs, count.index), {})
  )
}

locals {
  num_public_route_tables = var.create_multiple_public_route_tables ? local.len_public_subnets : 1
}

resource "aws_route_table" "public" {
  count = (var.create_public_subnets == true && local.create_public_subnets) ? local.num_public_route_tables : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = var.create_multiple_public_route_tables ? format(
        "${local.public_subnet_infrastructure_suffix}-${var.infrastructure_suffix}",
        element(var.azs, count.index),
      ) : "${local.public_subnet_infrastructure_suffix}-${var.infrastructure_suffix}"
    },
    var.public_route_table_tags,
  )
}

resource "aws_route_table_association" "public" {
  count = (var.create_public_subnets == true && local.create_public_subnets) ? local.len_public_subnets : 0

  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = element(aws_route_table.public[*].id, var.create_multiple_public_route_tables ? count.index : 0)
}

resource "aws_route" "public_internet_gateway" {
  count = (var.create_public_subnets == true && local.create_public_subnets) && var.create_igw ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id

  timeouts {
    create = "5m"
  }
}

################################################################################
# Private Subnets
################################################################################

locals {
  create_private_subnets          = local.len_private_subnets > 0
  create_isolated_private_subnets = local.len_isolated_private_subnets > 0
}

resource "aws_subnet" "isolated_private" {
  count = (var.create_isolated_private_subnets == true && local.create_isolated_private_subnets) ? local.len_isolated_private_subnets : 0

  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  vpc_id               = local.vpc_id
  cidr_block           = element(local.isolated_private_subnets, count.index)

  tags = merge(
    {
      Name = try(
        var.isolated_private_subnet_names[count.index],
        format("${local.isolated_private_subnet_infrastructure_suffix}-%s-${var.infrastructure_suffix}", element(var.azs, count.index))
      )
      Tier = "isolated-private",

    },
    var.isolated_private_subnet_tags,
    lookup(var.isolated_private_subnet_tags_per_az, element(var.azs, count.index), {})
  )
}

resource "aws_subnet" "private" {
  count = (var.create_private_subnets == true && local.create_private_subnets) ? local.len_private_subnets : 0

  availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  vpc_id               = local.vpc_id
  cidr_block           = element(local.private_subnets, count.index)

  tags = merge(
    {
      Name = try(
        var.private_subnet_names[count.index],
        format("${local.private_subnet_infrastructure_suffix}-%s-${var.infrastructure_suffix}", element(var.azs, count.index))
      )
      Tier = "private"
    },
    var.private_subnet_tags,
    lookup(var.private_subnet_tags_per_az, element(var.azs, count.index), {})
  )
}

# There are as many routing tables as the number of NAT gateways
resource "aws_route_table" "private" {
  count = (var.create_private_subnets == true && local.create_private_subnets) && local.max_subnet_length > 0 ? local.nat_gateway_count : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      "Name" = var.single_nat_gateway ? "${local.private_subnet_infrastructure_suffix}-${var.infrastructure_suffix}" : format(
        "${local.private_subnet_infrastructure_suffix}-%s-${var.infrastructure_suffix}",
        element(var.azs, count.index),
      )
    },
    var.private_route_table_tags,
  )
}

resource "aws_route_table_association" "private" {
  count = (var.create_private_subnets == true && local.create_private_subnets) ? local.len_private_subnets : 0

  subnet_id = element(aws_subnet.private[*].id, count.index)
  route_table_id = element(
    aws_route_table.private[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )
}
resource "aws_route_table_association" "isolated_private" {
  count = (var.create_isolated_private_subnets == true && local.create_isolated_private_subnets) ? local.len_isolated_private_subnets : 0

  subnet_id = element(aws_subnet.isolated_private[*].id, count.index)
  route_table_id = element(
    aws_route_table.private[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "igw" {
  count = (var.create_public_subnets == true && local.create_public_subnets) && var.create_igw ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    { "Name" = "${local.internet_gateway_suffix}" },
    var.igw_tags,
  )
}

################################################################################
# NAT Gateway
################################################################################

locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.azs) : local.max_subnet_length
  nat_gateway_ips   = var.reuse_nat_ips ? var.external_nat_ip_ids : aws_eip.eip[*].id
}

resource "aws_eip" "eip" {
  count = (var.create_private_subnets == true && var.enable_nat_gateway) && !var.reuse_nat_ips ? local.nat_gateway_count : 0

  domain = "vpc"

  tags = merge(
    {
      "Name" = format(
        "${local.elastic_ip_suffix}-%s",
        element(var.azs, var.single_nat_gateway ? 0 : count.index),
      )
    },
    var.nat_eip_tags,
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  count = (var.create_private_subnets == true && var.enable_nat_gateway) ? local.nat_gateway_count : 0

  allocation_id = element(
    local.nat_gateway_ips,
    var.single_nat_gateway ? 0 : count.index,
  )
  subnet_id = element(
    aws_subnet.public[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )

  tags = merge(
    {
      "Name" = format(
        "${local.nat_gateway_suffix}-%s",
        element(var.azs, var.single_nat_gateway ? 0 : count.index),
      )
    },
    var.nat_gateway_tags,
  )

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "private_nat_gateway" {
  count = (var.create_private_subnets == true && var.enable_nat_gateway) ? local.nat_gateway_count : 0

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = var.nat_gateway_destination_cidr_block
  nat_gateway_id         = element(aws_nat_gateway.nat[*].id, count.index)

  timeouts {
    create = "5m"
  }
}


