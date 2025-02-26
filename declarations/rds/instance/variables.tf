variable "rds_instance_configs" {
  description = "Configurações para cada instância RDS"
  type = map(object({
    vpc_security_group_ids = list(string)
    subnet_ids             = list(string)
    instance_identifier    = string
    instance_class         = string
    engine                 = string
    engine_version         = string
    port                   = number
    allocated_storage      = number
    username               = string
    deletion_protection = bool
    kms = object({
      description = string
    })
  }))
}