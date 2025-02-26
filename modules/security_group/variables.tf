variable "vpc_id" {
  type = string
}

variable "name" {
  description = "Nome do security group"
  type        = string
}

variable "description" {
  description = "Descrição do security group"
  type        = string
  default     = "Default security group description"
}

variable "ingress_ports" {
  description = "Ingress ports configuration"
  type = list(object({
    description     = optional(string)
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), null)
    security_groups = optional(list(string), null)
  }))
  default = []
}

variable "egress_ports" {
  description = "Egress ports configuration"
  type = list(object({
    description     = optional(string)
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string), null)
    security_groups = optional(list(string), null)
  }))
  default = []
}
