variable "rds_cluster" {
  description = "Configuração completa do RDS para múltiplos ambientes"
  type = map(object({
    rds_cluster = object({
      vpc_security_group_ids = list(string)
      subnet_ids             = list(string)
      cluster_identifier     = string
      engine                 = string
      engine_version         = string
      master_username        = string
      allocated_storage      = number
      db_cluster_instance_class = string
      port                    = number
      preferred_backup_window = optional(string, "03:09-03:39")
      deletion_protection     = optional(bool, true)
      number_of_readers = optional(number, 0)
      enable_autoscaling = optional(bool, false)
    })
    kms = object({
      description = optional(string)
    })
    rds_writer = object({
      identifier        = string
      instance_class    = string
      availability_zone = string
    })
    rds_readers = list(object({
      identifier        = string
      instance_class    = string
      availability_zone = string
    }))
    autoscaling = optional(object({
      name               = optional(string)
      resource_id        = optional(string)
      scalable_dimension = optional(string)
      min_capacity       = optional(number)
      max_capacity       = optional(number)
      target_value       = optional(number)
      scale_in_cooldown  = optional(number)
      scale_out_cooldown = optional(number)
    }), {})
  }))
}
