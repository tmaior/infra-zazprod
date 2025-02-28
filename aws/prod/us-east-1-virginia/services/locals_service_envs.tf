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

####################################################
# APP
####################################################
data "aws_secretsmanager_secret" "app_secrets" {
  name = "/${local.SERVICES_NAMES.APP}/${local.project_env}/${local.project_name}"
}

data "aws_secretsmanager_secret_version" "app_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.app_secrets.id
}

locals {
  APP_SECRET_DATA = jsondecode(data.aws_secretsmanager_secret_version.app_secrets_version.secret_string)

  APP_SECRETS = [
    for key in keys(local.APP_SECRET_DATA) : {
      name      = key
      valueFrom = "${data.aws_secretsmanager_secret.app_secrets.arn}:${key}::"
    }
  ]
}


####################################################
# FRONTEND
####################################################
data "aws_secretsmanager_secret" "frontend_secrets" {
  name = "/${local.SERVICES_NAMES.FRONTEND}/${local.project_env}/${local.project_name}"
}

data "aws_secretsmanager_secret_version" "frontend_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.frontend_secrets.id
}

locals {
  FRONTEND_SECRET_DATA = jsondecode(data.aws_secretsmanager_secret_version.frontend_secrets_version.secret_string)

  FRONTEND_SECRETS = [
    for key in keys(local.FRONTEND_SECRET_DATA) : {
      name      = key
      valueFrom = "${data.aws_secretsmanager_secret.frontend_secrets.arn}:${key}::"
    }
  ]
}