data "aws_vpc" "vpc" {
  tags = {
    Name = format("vpc-%s", local.infrastructure_suffix)
  }
}

data "aws_lb" "alb" {
  name = format("alb-%s", local.infrastructure_suffix)
}

data "aws_lb_listener" "https_listener" {
  load_balancer_arn = data.aws_lb.alb.arn
  port              = 443
}

data "aws_route53_zone" "walterwrites-ai" {
  name         = local.domain
  private_zone = false            
}

data "aws_caller_identity" "current" {}

data "aws_subnets" "private" {
  tags = {
    Tier = "private"
  }
}

data "aws_security_group" "ecs_cluster_sg" {
  filter {
    name   = "group-name"
    values = ["${format("ecs-cluster-%s", local.infrastructure_suffix)}"]
  }
}