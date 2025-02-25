# Locals existentes
locals {
  vpc_cidr_block = "10.180.0.0/16"
  stage          = "PROD"
  project_name   = "walterwrites"
  frontend_name  = "frontend"
  backend_name   = "backend"
  cluster_name   = lower(format("%s-%s", local.stage, local.project_name))
  azs            = data.aws_availability_zones.available.zone_ids
}

# Data sources
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

# IAM Role necessário
resource "aws_iam_role" "ecs_execution_role" {
  name = "${local.project_name}-${local.stage}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "cloudflare" {
  source = "../modules/cloudflare"

  cloudflare_api_token = var.cloudflare_api_token
  cloudflare_zone_id   = var.cloudflare_zone_id
  alb_dns_name         = module.load_balancer.dns_name
}

# VPC
module "vpc" {
  source          = "../modules/vpc"
  cidr_block      = local.vpc_cidr_block
  stage           = local.stage
  project_name    = local.project_name
  public_subnets  = [cidrsubnet(local.vpc_cidr_block, 8, 10), cidrsubnet(local.vpc_cidr_block, 8, 20)]
  private_subnets = [cidrsubnet(local.vpc_cidr_block, 8, 100), cidrsubnet(local.vpc_cidr_block, 8, 200)]
  azs             = local.azs
}

# Firewall
module "firewall" {
  source         = "../modules/firewall"
  project_name   = local.project_name
  stage          = local.stage
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}

# RDS
module "rds" {
  source = "../modules/rds"

  db_instance_identifier = lower(format("%s-%s-database", local.stage, local.project_name))
  subnet_ids             = module.vpc.private_subnet_ids
  security_group_ids     = [module.firewall.documentdb_sg_id]

  db_allocated_storage = 20
  db_engine            = "postgres"
  db_engine_version    = "15"
  db_instance_class    = "db.t3.small"

  db_name     = "walterai_stable"
  db_username = "postgres"
  db_password = "Ezops2025"

  depends_on = [
    module.vpc,
    module.firewall
  ]
}

# Scaling
module "scaling" {
  source       = "../modules/scaling"
  project_name = local.project_name
  stage        = local.stage
  cluster_name = local.cluster_name

  max_size                  = 4
  min_size                  = 4
  desired_capacity          = 4
  health_check_grace_period = 10
  health_check_type         = "EC2"

  public_key       = var.public_key
  instance_type    = "t3a.medium"
  aws_ami_ids_name = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  key_name         = "${local.project_name}-${lower(local.stage)}"

  vpc_zone_identifier = length(module.vpc.private_subnet_ids) > 0 ? module.vpc.private_subnet_ids : module.vpc.public_subnet_ids
  security_groups     = [module.firewall.ecs_sg_id]

  depends_on = [
    module.vpc,
    module.firewall
  ]
}

# ECS
module "ecs" {
  source             = "../modules/ecs"
  cluster_name       = "walter-cluster"
  existing_asg_arn   = module.scaling.autoscaling_group_arn
  depends_on         = [module.scaling]
  subnet_ids         = module.vpc.private_subnet_ids
  ecr_repository_url = module.ecr.ecr_repository_url
  vpc_id             = module.vpc.vpc_id

  target_groups = {
    "wds-humanizer"   = module.load_balancer.target_groups.wds_humanizer
    "walter-app"      = module.load_balancer.target_groups.walter_app
    "walter-backend"  = module.load_balancer.target_groups.backend
    "walter-frontend" = module.load_balancer.target_groups.frontend
  }

}

# ECR 
module "ecr" {
  source               = "../modules/ecr"
  repository_name      = var.ecr_repository_name
  scan_on_push         = var.scan_on_push
  image_tag_mutability = var.image_tag_mutability
}


# Load Balancer

module "load_balancer" {
  source = "../modules/load_balancer"
  stage = "PROD"
  vpc_id = module.vpc.vpc_id
  subnets_id = module.vpc.private_subnet_ids // Correto: singular
  security_groups_id = [module.firewall.service_sg_id]
  certificate_arn = module.acm.certificate_arn
  target_groups = []
}

module "https_listener_rules" {
  source = "../modules/listeners_rules"
  https_listener_arn = "arn:aws:elasticloadbalancing:us-east-1:654654523718:listener/app/prod-walterwrites-alb/61833fb25a4c03d5/387e304099fd2b06"
  backend_tg_arn = module.load_balancer.backend_tg_arn
  frontend_tg_arn = module.load_balancer.frontend_tg_arn
  app_tg_arn = module.load_balancer.walter_app_tg_arn
  humanizer_tg_arn = module.load_balancer.humanizer_tg_arn
}

module "route53" {
  source         = "../modules/route53"

  
  domain_name    = "walterwrites.ai"
  hosted_zone_id = var.hosted_zone_id

  load_balancer_dns_name = module.load_balancer.dns_name
  load_balancer_zone_id  = module.load_balancer.zone_id

  load_balancers = {
    main = {
      dns_name = module.load_balancer.dns_name
      zone_id  = module.load_balancer.zone_id
    }
    frontend = {
      dns_name = module.load_balancer.dns_name
      zone_id  = module.load_balancer.zone_id
    }
    backend = {
      dns_name = module.load_balancer.dns_name
      zone_id  = module.load_balancer.zone_id
    }
    app = {
      dns_name = module.load_balancer.dns_name
      zone_id  = module.load_balancer.zone_id
    }
    humanizer = {
      dns_name = module.load_balancer.dns_name
      zone_id  = module.load_balancer.zone_id
    }
  }  
}

module "acm" {
  source  = "../modules/acm"

  stage   = "prod"
  project_name = "walterwrites"
  primary_domain = "walterwrites.ai"
  domain_name = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  listener_arn = module.load_balancer.listener_arn

}






