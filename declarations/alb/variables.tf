
variable "alb" {
  description = "Configurações do Application Load Balancer"
  type = map(object({
    name               = string
    security_group_ids = list(string)
    public_subnets      = list(string)
    certificate_arn = string
  }))
  
}