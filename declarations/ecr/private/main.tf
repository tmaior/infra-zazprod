module "ecr" {
  for_each = var.ecr_repositories
  source = "../../../modules/ecr/private"
  name = each.value.name
  tags = each.value.tags 
}
