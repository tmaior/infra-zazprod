############################################
# ECR
############################################
locals {
    ECR_REPOSITORYS = {
        BACKEND = {
            name = "${local.SERVICES_NAMES.BACKEND}/${local.project_env}/${local.project_name}"
            tags = {
                Name        = "${local.SERVICES_NAMES.BACKEND}/${local.project_env}/${local.project_name}"
                Environment = local.project_env
                RegionName = local.project_name
                Terraform   = "true"
            }
        }
        FRONTEND = {
            name = "${local.SERVICES_NAMES.FRONTEND}/${local.project_env}/${local.project_name}"
            tags = {
                Name        = "${local.SERVICES_NAMES.FRONTEND}/${local.project_env}/${local.project_name}"
                Environment = local.project_env
                RegionName = local.project_name
                Terraform   = "true"
            }
        }
        APP = {
            name = "${local.SERVICES_NAMES.APP}/${local.project_env}/${local.project_name}"
            tags = {
                Name        = "${local.SERVICES_NAMES.APP}/${local.project_env}/${local.project_name}"
                Environment = local.project_env
                RegionName = local.project_name
                Terraform   = "true"
            }
        }
        HUMANIZER = {
            name = "${local.SERVICES_NAMES.HUMANIZER}/${local.project_env}/${local.project_name}"
            tags = {
                Name        = "${local.SERVICES_NAMES.HUMANIZER}/${local.project_env}/${local.project_name}"
                Environment = local.project_env
                RegionName = local.project_name
                Terraform   = "true"
            }
        }
    }
}