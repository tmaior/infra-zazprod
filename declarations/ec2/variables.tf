variable "ec2_configs" {
  description = "Configurações das instâncias EC2 para diferentes ambientes"
  type = map(object({
    role_name       = string
    ami                 = string
    instance_type       = string
    key_name            = string
    subnet_id           = string
    associate_public_ip = bool
    availability_zone   = string
    security_group_ids  = list(string)
    user_data           = string
    tags                = map(string)
    root_volume_size    = number
    iam_role_name_instance_profile = optional(string)
  }))
}