
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
            listener_https_arn = string
            listener_rule_priority = number
            dns = string
        })
        target_group = object({
            vpc_id = string
            health_check_matcher = optional(string, "200,301")
            health_check_path = optional(string, "/")
            health_check_interval = optional(number, 10)
            health_check_protocol = optional(string, "HTTP")
            health_check_timeout = optional(number, 5)
            health_check_healthy_threshold = optional(number, 3)
            health_check_unhealthy_threshold = optional(number, 3)
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

  # health_check {
  #   matcher             = "200,301"
  #   path                = "/"
  #   interval            = 10
  #   protocol            = "HTTP"
  #   timeout             = 5
  #   healthy_threshold   = 3
  #   unhealthy_threshold = 3
  # }