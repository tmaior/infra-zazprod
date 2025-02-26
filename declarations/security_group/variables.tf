variable "security_groups" {
  description = "Definições para os security groups a serem criados"
  type = map(object({
    name        = string
    description = string
    vpc_id     = string
    ingress_ports = list(object({
      description     = optional(string)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), null)
      security_groups = optional(list(string), null)
    }))
    egress_ports = list(object({
      description     = optional(string)
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), null)
      security_groups = optional(list(string), null)
    }))
  }))
  default = {}
}
