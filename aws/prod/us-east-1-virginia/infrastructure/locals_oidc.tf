############################################
# OIDC
############################################
locals {
  oidc_repositories = {
    BACKEND = {
      iam_iam_openid_connect_provider_arn = aws_iam_openid_connect_provider.oidc[0].arn
      role_suffix = "github-pipeline-walter-backend"
      policy      = "${path.module}/iam/policies/oidc/walter-backend.json"
      git_repo_urls = [
        "repo:WALTER-WRITES/walter-backend:*",
        "repo:WALTER-WRITES/walter-backend:ref:refs/heads/*"
      ]
    }
    FRONTEND = {
      iam_iam_openid_connect_provider_arn = aws_iam_openid_connect_provider.oidc[0].arn
      role_suffix = "github-pipeline-walter-frontend"
      policy      = "${path.module}/iam/policies/oidc/walter-frontend.json"
      git_repo_urls = [
        "repo:WALTER-WRITES/walter-frontend:*",
        "repo:WALTER-WRITES/walter-frontend:ref:refs/heads/*"
      ]
    }
    APP = {
      iam_iam_openid_connect_provider_arn = aws_iam_openid_connect_provider.oidc[0].arn
      role_suffix = "github-pipeline-app"
      policy      = "${path.module}/iam/policies/oidc/app.json"
      git_repo_urls = [
        "repo:WALTER-WRITES/app:*",
        "repo:WALTER-WRITES/app:ref:refs/heads/*"
      ]
    }
    HUMANIZER = {
      iam_iam_openid_connect_provider_arn = aws_iam_openid_connect_provider.oidc[0].arn
      role_suffix = "github-pipeline-wds-humanizer"
      policy      = "${path.module}/iam/policies/oidc/humanizer.json"
      git_repo_urls = [
        "repo:WALTER-WRITES/wds-humanizer:*",
        "repo:WALTER-WRITES/wds-humanizer:ref:refs/heads/*"
      ]
    }
  }
}
