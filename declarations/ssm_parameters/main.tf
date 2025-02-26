module "ssm_parameters" {
  for_each = var.ssm_parameters
  source = "../../modules/ssm_parameters"
  name = each.value.name
  description = each.value.description
  secret_type = each.value.secret_type
  value = each.value.value
}
