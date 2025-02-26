locals {
  SECRETS_MANAGER = {
    BACKEND = {
      name  = "/${local.SERVICES_NAMES.BACKEND}/${local.project_env}/${local.project_name}"
      description = "${local.SERVICES_NAMES.BACKEND} Secrets Manager"
    }
    FRONTEND = {
      name  = "/${local.SERVICES_NAMES.FRONTEND}/${local.project_env}/${local.project_name}"
      description = "${local.SERVICES_NAMES.FRONTEND} Secrets Manager"
    }
    APP = {
      name  = "/${local.SERVICES_NAMES.APP}/${local.project_env}/${local.project_name}"
      description = "${local.SERVICES_NAMES.APP} Secrets Manager"
    }
    HUMANIZER = {
      name  = "/${local.SERVICES_NAMES.HUMANIZER}/${local.project_env}/${local.project_name}"
      description = "${local.SERVICES_NAMES.HUMANIZER} Secrets Manager"
    }
  }
}