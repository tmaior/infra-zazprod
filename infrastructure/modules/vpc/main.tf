locals {
  project_name = lower(format("%s-%s", var.stage, var.project_name))
  len_public_subnets = length(var.public_subnets)
  len_private_subnets = length(var.private_subnets)

  common_tags = {
    Project     = var.project_name
    Environment = var.stage
    ManagedBy   = "Terraform"
  }
}

#===============================================================================
# VPC GENERAL
#===============================================================================
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = format("%s-vpc", local.project_name)
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = format("%s-ig-vpc", local.project_name)
  })
}

#===============================================================================
# PUBLIC SUBNET
#===============================================================================
resource "aws_subnet" "public" {
  count                   = local.len_public_subnets
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone_id    = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = format("%s-public-subnet-%02d", local.project_name, count.index + 1)
    Type = "Public"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(local.common_tags, {
    Name = format("%s-public-route-table", local.project_name)
  })

  lifecycle {
    ignore_changes = [route]
  }
}

resource "aws_route_table_association" "public" {
  count          = local.len_public_subnets
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

#===============================================================================
# PRIVATE SUBNET
#===============================================================================
resource "aws_subnet" "private" {
  count               = local.len_private_subnets
  vpc_id              = aws_vpc.this.id
  cidr_block          = element(var.private_subnets, count.index)
  availability_zone_id = element(var.azs, count.index)

  tags = merge(local.common_tags, {
    Name = format("%s-private-subnet-%02d", local.project_name, count.index + 1)
    Type = "Private"
  })
}

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.gw]
  domain     = "vpc"

  tags = merge(local.common_tags, {
    Name = format("%s-eip-nat", local.project_name)
  })
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id

  tags = merge(local.common_tags, {
    Name = format("%s-nat", local.project_name)
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(local.common_tags, {
    Name = format("%s-private-route-table", local.project_name)
  })

  lifecycle {
    ignore_changes = [route]
  }
}

resource "aws_route_table_association" "private" {
  count          = local.len_private_subnets
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}