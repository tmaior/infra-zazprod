module "security_group" {
  for_each = var.security_groups
  source = "../../modules/security_group"
  name = each.value.name
  description = each.value.description
  vpc_id = each.value.vpc_id
  egress_ports = each.value.egress_ports
  ingress_ports = each.value.ingress_ports
}
