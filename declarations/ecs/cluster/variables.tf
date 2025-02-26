
variable "ecs" {
  description = "Configuração completa do ECS para múltiplos ambientes"
  type = map(object({
    ecs = object({
        name               = string
        project_env        = string
    })
    launch_template    = object({
        instance_type      = string
        device_name        = string
        ebs_size           = number
        ebs_encrypted      = bool
        ebs_volume_type    = string
        ebs_delete_on_termination = bool
        security_groups = list(string)
        user_data          = string
        key_pair_name      = string
    })
    autoscaling        = object({
        desired_instances = number
        max_instances     = number
        min_instances     = number
        private_subnets   = list(string)
    })
  }))
  
}