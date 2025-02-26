module "alb" {
  for_each           = var.alb
  source             = "../../modules/alb"
  name               = each.value.name
  security_group_ids = each.value.security_group_ids
  public_subnets      = each.value.public_subnets
  certificate_arn = each.value.certificate_arn

}
