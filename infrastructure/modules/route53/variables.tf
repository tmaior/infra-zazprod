variable "domain_name" {
  description = "O domínio principal para a aplicação"
  type        = string
}


variable "hosted_zone_id" {
  description = "ID da zona hospedada no Route 53"
  type        = string
  default     = ""
}


variable "load_balancers" {
  description = "Map of load balancer configurations"
  type = map(object({
    dns_name = string
    zone_id = string
  }))
}

variable "create_route53_zone" {
  description = "Determina se deve criar uma nova zona Route53"
  type        = bool
  default     = false
}

variable "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  type        = string
}

variable "load_balancer_zone_id" {
  description = "Zone ID of the load balancer"
  type        = string
}

