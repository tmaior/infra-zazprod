module "secret_manager" {
  for_each = var.secrets
  source = "../../modules/secrets_manager"
  name = each.value.name
  description = each.value.description
}
