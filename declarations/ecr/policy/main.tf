module "ecr_policy" {
  for_each = var.ecr_policies
  source = "../../../modules/ecr/policy"
  repository_name = each.value.repository_name
  policy = each.value.policy 
}
