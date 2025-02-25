#===============================================================================
# VARIABLES
#===============================================================================
variable "cloudflare_zone_id" {
  description = "The zone ID for Cloudflare domain"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token With permissions for the specific zone"
  type        = string
  sensitive   = true
}

variable "alb_dns_name" {
  description = "DNS name of Application Load Balancer"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}