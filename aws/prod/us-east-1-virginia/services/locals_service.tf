locals {
    ECS_SERVICES = {
        BACKEND = {
            service = {
                name = format("%s-%s", local.SERVICES_NAMES.BACKEND, local.infrastructure_suffix)
                dns_domain = "api-ezops.walterwrites.ai"
                cluster_name = local.infrastructure_suffix
                task_desire_count = 1
                capacity_provider_name = "${local.infrastructure_suffix}-ecs-capacity-provider"
                region = local.region
                network_configuration_subnets = data.aws_subnets.private.ids
                network_configuration_security_groups = [data.aws_security_group.ecs_cluster_sg.id]
            }
            alb = {
                vpc_id = data.aws_vpc.vpc.id
                listener_https_arn = data.aws_lb_listener.https_listener.arn
                listener_rule_priority = 1
                dns = data.aws_lb.alb.dns_name
            }
            route53 = {
                hostedzone_id = data.aws_route53_zone.walterwrites-ai.zone_id
            }
            task_definition = {
                secrets = local.BACKEND_SECRETS
                repository_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.SERVICES_NAMES.BACKEND}/${local.project_env}/${local.project_name}:latest"
                container_name = format("%s-%s", local.SERVICES_NAMES.BACKEND ,local.infrastructure_suffix)
                container_port = 8000
                container_cpu = 1024
                container_memory = 1024
                log_group_name = local.CLOUDWATCH_LOG_GROUP.BACKEND.log_group_name
            }
        }
        FRONTEND = {
            service = {
                name = format("%s-%s", local.SERVICES_NAMES.FRONTEND, local.infrastructure_suffix)
                dns_domain = "frontend-ezops.walterwrites.ai"
                cluster_name = local.infrastructure_suffix
                task_desire_count = 1
                capacity_provider_name = "${local.infrastructure_suffix}-ecs-capacity-provider"
                region = local.region
            }
            alb = {
                vpc_id = data.aws_vpc.vpc.id
                listener_https_arn = data.aws_lb_listener.https_listener.arn
                listener_rule_priority = 2
                dns = data.aws_lb.alb.dns_name
            }
            route53 = {
                hostedzone_id = data.aws_route53_zone.walterwrites-ai.zone_id
            }
            task_definition = {
                secrets = local.FRONTEND_SECRETS
                repository_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.SERVICES_NAMES.FRONTEND}/${local.project_env}/${local.project_name}:latest"
                container_name = format("%s-%s", local.SERVICES_NAMES.FRONTEND ,local.infrastructure_suffix)
                container_port = 3000
                container_cpu = 512
                container_memory = 512
                log_group_name = local.CLOUDWATCH_LOG_GROUP.FRONTEND.log_group_name
            }
        }
        APP = {
            service = {
                name = format("%s-%s", local.SERVICES_NAMES.APP, local.infrastructure_suffix)
                dns_domain = "app-ezops.walterwrites.ai"
                cluster_name = local.infrastructure_suffix
                task_desire_count = 1
                capacity_provider_name = "${local.infrastructure_suffix}-ecs-capacity-provider"
                region = local.region
            }
            alb = {
                vpc_id = data.aws_vpc.vpc.id
                listener_https_arn = data.aws_lb_listener.https_listener.arn
                listener_rule_priority = 3
                dns = data.aws_lb.alb.dns_name
            }
            route53 = {
                hostedzone_id = data.aws_route53_zone.walterwrites-ai.zone_id
            }
            task_definition = {
                secrets = local.APP_SECRETS
                repository_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.SERVICES_NAMES.APP}/${local.project_env}/${local.project_name}:latest"
                container_name = format("%s-%s", local.SERVICES_NAMES.APP ,local.infrastructure_suffix)
                container_port = 3001
                container_cpu = 512
                container_memory = 512
                log_group_name = local.CLOUDWATCH_LOG_GROUP.APP.log_group_name
            }
        }
        HUMANIZER = {
            service = {
                name = format("%s-%s", local.SERVICES_NAMES.HUMANIZER, local.infrastructure_suffix)
                dns_domain = "humanizer-ezops.walterwrites.ai"
                cluster_name = local.infrastructure_suffix
                task_desire_count = 1
                capacity_provider_name = "${local.infrastructure_suffix}-ecs-capacity-provider"
                region = local.region
            }
            alb = {
                vpc_id = data.aws_vpc.vpc.id
                listener_https_arn = data.aws_lb_listener.https_listener.arn
                listener_rule_priority = 4
                dns = data.aws_lb.alb.dns_name
            }
            route53 = {
                hostedzone_id = data.aws_route53_zone.walterwrites-ai.zone_id
            }
            task_definition = {
                secrets = local.HUMANIZER_SECRETS
                repository_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.SERVICES_NAMES.HUMANIZER}/${local.project_env}/${local.project_name}:latest"
                container_name = format("%s-%s", local.SERVICES_NAMES.HUMANIZER ,local.infrastructure_suffix)
                container_port = 8001
                container_cpu = 512
                container_memory = 512
                log_group_name = local.CLOUDWATCH_LOG_GROUP.HUMANIZER.log_group_name
            }
        }
    }
}