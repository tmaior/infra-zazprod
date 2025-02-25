#===============================================================================
# CLOUDFLARE PROVIDER
#===============================================================================
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

#===============================================================================
# DNS RECORDS
#===============================================================================
resource "cloudflare_record" "walterwrites_dns" {
  zone_id         = var.cloudflare_zone_id
  name            = "ecs"
  type            = "CNAME"
  content         = var.alb_dns_name
  allow_overwrite = true
}

#===============================================================================
# SSL/TLS SETTINGS
#===============================================================================
resource "cloudflare_zone_settings_override" "ssl_tls_settings" {
  zone_id = var.cloudflare_zone_id
  
  settings {
    ssl = "full"
  }
}