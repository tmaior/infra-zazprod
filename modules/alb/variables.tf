variable "name" {
  description = "The name of the ALB"
}

variable "security_group_ids" {
  description = "The security group IDs to attach to the ALB"
}

variable "public_subnets" {
  description = "The public subnet IDs to attach to the ALB"
  type = list(string)
}

variable "certificate_arn" {
  description = "The domain of the certificate"
}
