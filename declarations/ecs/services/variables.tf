
variable "ecs_services" {
    description = "Configuration for the ECS service"
    type = map(object ({
        service = object({
            name = string
            region = string
            dns_domain = string
            cluster_name = string
            task_desire_count = number
            capacity_provider_name = string
        })
        alb = object({
            vpc_id = string
            listener_https_arn = string
            listener_rule_priority = number
            dns = string
        })
        route53 = object({
            hostedzone_id = string
        })
        task_definition = object({
            repository_url = string
            container_name = string
            secrets = list(object({
                name = string
                valueFrom = string
            }))
            container_port = number
            container_cpu = number
            container_memory = number
            log_group_name = string
      })
    }))
    
}