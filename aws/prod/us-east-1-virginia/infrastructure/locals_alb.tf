locals {
    ALB = {
        alb = {
            name = local.infrastructure_suffix
            security_group_ids = [module.sg_alb.id.ALB]
            public_subnets = module.vpc.public_subnets
            certificate_arn = data.aws_acm_certificate.walterwrites-ai.arn
        }
    }
}

data "aws_acm_certificate" "walterwrites-ai" {
  domain   = local.domain
  statuses = ["ISSUED"]
}