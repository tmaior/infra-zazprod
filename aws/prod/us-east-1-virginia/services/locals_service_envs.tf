####################################################
# BACKEND
####################################################
data "aws_secretsmanager_secret" "backend_secrets" {
  name = "/${local.SERVICES_NAMES.BACKEND}/${local.project_env}/${local.project_name}"
}

data "aws_secretsmanager_secret_version" "backend_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.backend_secrets.id
}

locals {
  BACKEND_SECRET_DATA = jsondecode(data.aws_secretsmanager_secret_version.backend_secrets_version.secret_string)

  BACKEND_SECRETS = [
    for key in keys(local.BACKEND_SECRET_DATA) : {
      name      = key
      valueFrom = "${data.aws_secretsmanager_secret.backend_secrets.arn}:${key}::"
    }
  ]
}

####################################################
# HUMANIZER
####################################################
data "aws_secretsmanager_secret" "humanizer_secrets" {
  name = "/${local.SERVICES_NAMES.HUMANIZER}/${local.project_env}/${local.project_name}"
}

data "aws_secretsmanager_secret_version" "humanizer_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.humanizer_secrets.id
}

locals {
  HUMANIZER_SECRET_DATA = jsondecode(data.aws_secretsmanager_secret_version.humanizer_secrets_version.secret_string)

  HUMANIZER_SECRETS = [
    for key in keys(local.HUMANIZER_SECRET_DATA) : {
      name      = key
      valueFrom = "${data.aws_secretsmanager_secret.humanizer_secrets.arn}:${key}::"
    }
  ]
}


locals {
    APP_SECRETS = []
}

locals {
    FRONTEND_SECRETS = []
}