
############################################
# OIDC
############################################
resource "aws_iam_openid_connect_provider" "oidc" {
  count = 1
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
}

module "oidc" {
  source          = "../../../../declarations/oidc"
  oidc_repositories = local.oidc_repositories
}

############################################
# VPC
############################################
module "vpc" {
  source                = "../../../../modules/vpc"
  infrastructure_suffix = local.infrastructure_suffix
  azs                   = local.azs
  cidr                  = "10.0.0.0/16"
  public_subnet_tags    = local.VPC.public_subnet_tags
  private_subnet_tags   = local.VPC.private_subnet_tags

}

###########################################
# ECR
###########################################
module "ecr" {
  source           = "../../../../declarations/ecr/private"
  ecr_repositories = local.ECR_REPOSITORYS

}

###########################################
# Security Groups
###########################################
module "sg_bastion" {
  source          = "../../../../declarations/security_group"
  security_groups = local.SG_BASTION

  depends_on = [module.vpc]
}

module "sg_rds_psql" {
  source          = "../../../../declarations/security_group"
  security_groups = local.SG_RDS_PSQL

  depends_on = [module.vpc]
}

module "sg_alb" {
  source          = "../../../../declarations/security_group"
  security_groups = local.SG_ALB

  depends_on = [module.vpc]
}

module "sg_ecs" {
  source          = "../../../../declarations/security_group"
  security_groups = local.SG_ECS_CLUSTER

  depends_on = [module.vpc]
}


###########################################
# EC2
###########################################
module "ec2" {
  source      = "../../../../declarations/ec2"
  ec2_configs = local.EC2

  depends_on = [module.sg_bastion, module.vpc]
}

###########################################
# RDS Instance
###########################################
module "rds_instance" {
  source              = "../../../../declarations/rds/instance"
  rds_instance_configs = local.RDS_INSTANCE_CONFIGS

  depends_on = [module.vpc]
}

###########################################
# ALB
###########################################
module "alb" {
  source = "../../../../declarations/alb"
  alb    = local.ALB

  depends_on = [module.sg_alb, module.vpc]
}

###########################################
# ECS
###########################################
module "ecs" {
  source      = "../../../../declarations/ecs/cluster"
  ecs = local.ECS_CLUSTER

  depends_on = [module.sg_ecs, module.vpc]
}

###########################################
# Secrets Manager
###########################################
module "secrets_manager" {
  source  = "../../../../declarations/secrets_manager"
  secrets = local.SECRETS_MANAGER
}