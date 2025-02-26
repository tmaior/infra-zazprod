
resource "aws_iam_policy" "this" {
  name        = "oidc-policy-${var.role_suffix}" # Usa o nome da chave (mobile, web, etc.)
  description = "Policy for OIDC role ${var.role_suffix}" # Usa o nome da chave (mobile, web, etc.)

  # Pega o caminho do arquivo de policy de acordo com a chave
  policy = file(var.policy)
}


data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      # identifiers = [aws_iam_openid_connect_provider.oidc[0].arn]
      identifiers = [var.iam_iam_openid_connect_provider_arn]
    }
    condition {
      test     = "StringEquals"
      values   = [var.aud_value]
      variable = "${var.oidc_policy_condition}:aud"
    }
    condition {
      test     = "StringLike"
      values   = var.git_repo_urls
      variable = "${var.oidc_policy_condition}:sub"
    }
  }
}


resource "aws_iam_role" "oidc_ci" {
  name               = format("oidc-%s", var.role_suffix)
  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "oidc" {
  role       = aws_iam_role.oidc_ci.name
  policy_arn = aws_iam_policy.this.arn
}

