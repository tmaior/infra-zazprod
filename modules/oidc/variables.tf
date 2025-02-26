
variable "role_suffix" {
  type = string
}

variable "oidc_url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

variable "aud_value" {
  type    = string
  default = "sts.amazonaws.com"
  description = "Audience value for GitHub OIDC authentication"
}

variable "oidc_policy_condition" {
  type    = string
  default = "token.actions.githubusercontent.com"
  description = "Base condition for GitHub OIDC policy"
}

variable "git_repo_urls" {
  type    = list(string)
  description = "List of GitHub repository sub claims allowed for OIDC authentication"
}

variable "policy" {
  type = string
}

variable "iam_iam_openid_connect_provider_arn" {
  type = string
}
