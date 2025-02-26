
variable "service" {
  type = object({
      name = string
      dns_domain = string
      cluster_name = string
      task_desire_count = number
      capacity_provider_name = string
      region = string
  })
}

variable "alb" {
    type = object({
        listener_https_arn = string
        listener_rule_priority = number
        dns = string
    })
}

variable "target_group" {
    type = object({
        vpc_id = string
        health_check_matcher = string
        health_check_path = string
        health_check_interval = number
        health_check_protocol = string
        health_check_timeout = number
        health_check_healthy_threshold = number
        health_check_unhealthy_threshold = number
    })
}

variable "route53" {
    type = object({
        hostedzone_id = string
    })
}

variable "task_definition" {
    type = object({
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
  
}