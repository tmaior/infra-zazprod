variable "oidc_repositories" {
  type = map(object({
    role_suffix = string
    oidc_url  = optional(string, "https://token.actions.githubusercontent.com")
    aud_value   = optional(string,"sts.amazonaws.com")
    policy      = string
    git_repo_urls = list(string)
    oidc_policy_condition = optional(string, "token.actions.githubusercontent.com")
    iam_iam_openid_connect_provider_arn = string
  }))
}
