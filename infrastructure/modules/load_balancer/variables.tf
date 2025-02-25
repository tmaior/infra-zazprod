# variables.tf

variable "project_name" {
  description = "The prefix for all resources"
  type        = string
  default     = "walterwrites"
}

variable "stage" {
  description = "The environment for all resources"
  type        = string
}

variable "subnets_id" {
  description = "value of subnets id"
  type        = list(string)
}

variable "vpc_id" {
  description = "value of vpc id"
  type        = string
}

variable "security_groups_id" {
  description = "value of security group id"
  type        = list(string)
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate"
  type        = string
  default     = null
}

variable "ssl_policy" {
  description = "The SSL policy"
  type        = string
  default     = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
}

variable "target_groups" {
  description = "Lista de ARNs dos Target Groups associados ao ALB"
  type        = list(string)
}

variable "listener_arn" {
  description = "ARN do listener HTTPS"
  type        = string
  default     = null
}

