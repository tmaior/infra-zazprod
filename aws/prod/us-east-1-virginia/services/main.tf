###########################################
# CloudWatch Log Group
###########################################
module "cloudwatch_log_group" {
  source = "../../../../declarations/cloudwatch/log_group"
  cloudwatch_log_group = local.CLOUDWATCH_LOG_GROUP
}


###########################################
# Service
###########################################
module "service" {
  source = "../../../../declarations/ecs/services"
  ecs_services = local.ECS_SERVICES

  depends_on = [module.cloudwatch_log_group]
}

