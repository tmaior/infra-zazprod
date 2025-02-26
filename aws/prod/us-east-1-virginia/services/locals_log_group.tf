locals {
    CLOUDWATCH_LOG_GROUP = {
        BACKEND = {
            log_group_name = format("/ecs/%s/service/%s-%s", local.infrastructure_suffix, local.SERVICES_NAMES.BACKEND, local.infrastructure_suffix)
            log_group_retention_days = 7
        }
        FRONTEND = {
            log_group_name = format("/ecs/%s/service/%s-%s", local.infrastructure_suffix, local.SERVICES_NAMES.FRONTEND, local.infrastructure_suffix)
            log_group_retention_days = 7
        }
        APP = {
            log_group_name = format("/ecs/%s/service/%s-%s", local.infrastructure_suffix, local.SERVICES_NAMES.APP, local.infrastructure_suffix)
            log_group_retention_days = 7
        }
        HUMANIZER = {
            log_group_name = format("/ecs/%s/service/%s-%s", local.infrastructure_suffix, local.SERVICES_NAMES.HUMANIZER, local.infrastructure_suffix)
            log_group_retention_days = 7
        }
    }
}