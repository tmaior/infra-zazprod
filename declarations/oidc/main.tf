module "oidc" {
  for_each = var.oidc_repositories
  source = "../../modules/oidc"
  aud_value = each.value.aud_value
  oidc_url = each.value.oidc_url
  role_suffix = each.value.role_suffix
  policy = each.value.policy
  git_repo_urls = each.value.git_repo_urls
  oidc_policy_condition = each.value.oidc_policy_condition
  iam_iam_openid_connect_provider_arn = each.value.iam_iam_openid_connect_provider_arn
}
