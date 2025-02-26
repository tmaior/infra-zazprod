############################################
# Security Group - Bastion
############################################
locals {
  SG_BASTION = {
    BASTION = {
      name        = format("bastion-%s", local.infrastructure_suffix)
      description = "Security group for Bastion, allowing SSH access from anywhere."
      vpc_id     = module.vpc.vpc_id
      ingress_ports = [
        {
          description = "SSH"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
      ]
      egress_ports = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}

############################################
# Security Group - RDS MySQL
############################################
locals {
  SG_RDS_PSQL = {
    RDS_PSQL = {
      name        = format("rds-%s", local.infrastructure_suffix)
      description = "Security group for the RDS MySQL, allowing access from the VPC."
      vpc_id     = module.vpc.vpc_id
      ingress_ports = [
        {
          description = "Porta do RDS ${local.infrastructure_suffix}"
          from_port   = local.RDS_PORTS["RDS_PSQL"]
          to_port     = local.RDS_PORTS["RDS_PSQL"]
          protocol    = "tcp"
          cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
        },
      ]
      egress_ports = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}

############################################
# Security Group - ALB
############################################
locals {
  SG_ALB = {
    ALB = {
      name        = format("alb-%s", local.infrastructure_suffix)
      description = "Security group for the Application Load Balancer, allowing HTTP and HTTPS access in the VPC."
      vpc_id     = module.vpc.vpc_id
      ingress_ports = [
        {
          description = "HTTP"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          description = "HTTPS"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
      ]
      egress_ports = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}

############################################
# Security Group - ECS Cluster
############################################

locals {
  SG_ECS_CLUSTER = {
    ECS = {
      name        = format("ecs-cluster-%s", local.infrastructure_suffix)
      description = "Security group for the ECS Cluster, allowing access from the Application Load Balancer."
      vpc_id     = module.vpc.vpc_id
      ingress_ports = [
        {
          description = "Bastion SSH"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          security_groups = [module.sg_bastion.id.BASTION]
        },
        {
         description = "Load Balancer"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          security_groups = [module.sg_alb.id.ALB]
        }
      ]
      egress_ports = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}