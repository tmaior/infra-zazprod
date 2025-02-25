locals {
  project_name = lower(format("%s-%s", var.stage, var.project_name))
}


#===============================================================================
# LOAD BALANCER SECURITY GROUP
#===============================================================================
module "load_balancer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = format("%s-lb-sg", local.project_name)
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_with_cidr_blocks = [
    {
      description = "Allow all egress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.commom_tags
}

#===============================================================================
# BASTION SECURITY GROUP
#===============================================================================
module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = format("%s-bastion-sg", local.project_name)
  description = "Security group for BASTION"
  vpc_id      = var.vpc_id

  # ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      description = "Allow SSH ingress traffic from bastion host"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.commom_tags
}

#===============================================================================
# ECS SECURITY GROUP
#===============================================================================
module "ecs_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                = format("%s-ecs-sg", local.project_name)
  description         = "Security group for ECS"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = [var.vpc_cidr_block]

  ingress_with_cidr_blocks = [
    {
      description = "Allow SSH ingress traffic from bastion host"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },

    {
      description = ""
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description              = "Allow ingress traffic from ALB on HTTP on ephemeral ports"
      from_port                = 32768 #1024
      to_port                  = 65535
      protocol                 = "tcp"
      source_security_group_id = module.load_balancer_sg.security_group_id
    },
  ]


  egress_with_cidr_blocks = [
    {
      description = "Allow all egress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.commom_tags
}
#===============================================================================
# SERVICE SECURITY GROUP
#===============================================================================
module "service_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                = format("%s-service-sg", local.project_name)
  description         = "Security group for ECS Service"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = [var.vpc_cidr_block]

  ingress_with_source_security_group_id = [
    {
      description              = "Allow ingress 80 port"
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = module.load_balancer_sg.security_group_id
    },

    {
      description              = "Allow ingress traffic from ALB on HTTP on ephemeral ports"
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      source_security_group_id = module.load_balancer_sg.security_group_id
    },
    {
      description              = "Allow SSH ingress traffic from bastion host"
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      source_security_group_id = module.bastion_sg.security_group_id
    }
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.commom_tags
}


module "documentdb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                = format("%s-documentdb-sg", local.project_name)
  description         = "Security group for DocumentdB Service"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = [var.vpc_cidr_block]

  ingress_with_cidr_blocks = [
    {
      description              = "Allow ingress Mongo port"
      from_port                = 27017
      to_port                  = 27017
      protocol                 = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      description = "Allow all egress traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = var.commom_tags
}
