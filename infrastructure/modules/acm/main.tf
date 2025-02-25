# ../modules/acm/main.tf
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  
  lifecycle {
    create_before_destroy = true
  }
}

# Condicionais para criar validação somente quando houver zona
locals {
  zone_exists = var.hosted_zone_id != null && var.hosted_zone_id != ""
  domain_validation = local.zone_exists ? aws_acm_certificate.cert.domain_validation_options : []
}

resource "aws_route53_record" "cert_validation" {
  for_each = local.zone_exists ? {
    for dvo in local.domain_validation : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}
  
  zone_id         = var.hosted_zone_id
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "cert" {
  count                   = local.zone_exists ? 1 : 0
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = local.zone_exists ? [for record in aws_route53_record.cert_validation : record.fqdn] : []
}

data "aws_acm_certificate" "cert" {
  domain   = "walterwrites.ai"
  statuses = ["ISSUED"]
}
