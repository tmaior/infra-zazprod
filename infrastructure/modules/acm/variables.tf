variable "domains" {
  type        = list(string)
  description = "The domain that can be used in certificate, accepts wildcards"
  default = null
}

variable "exists" {
  type = bool
  description = "Must be true if the certificate already exist in the system"
  default = false
}

variable "listener_arn" {
  description = "ARN do listener HTTPS"
  type        = string
  default     = null
}

variable "most_recent" {
  type = bool
  default = false
  description = "Fetch the most recent certificate"
}

variable "stage" {
  description = "Deployment stage"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "primary_domain" {
  description = "Primary domain for the certificate"
  type        = string
}

variable "alternative_domains" {
  description = "Alternative domains for the certificate"
  type        = list(string)
  default     = []
}

variable "hosted_zone_id" {
  description = "Route53 Hosted Zone ID for DNS validation"
  type        = string
  default     = ""
  
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "domain_name" {
  description = "Domain name for the ACM certificate"
  type        = string
}

