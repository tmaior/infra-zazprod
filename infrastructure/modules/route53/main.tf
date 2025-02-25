
resource "aws_route53_zone" "primary" {
  count = var.hosted_zone_id == null ? 1 : 0
  name  = var.domain_name
}

resource "aws_route53_record" "frontend" {
  zone_id = var.hosted_zone_id != null ? var.hosted_zone_id : aws_route53_zone.primary[0].zone_id
  name    = "frontend.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.load_balancers["main"].dns_name
    zone_id                = var.load_balancers["main"].zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "backend" {
  zone_id = var.hosted_zone_id != null ? var.hosted_zone_id : aws_route53_zone.primary[0].zone_id
  name    = "api.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.load_balancers.backend.dns_name
    zone_id                = var.load_balancers.backend.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "app" {
  zone_id = var.hosted_zone_id != null ? var.hosted_zone_id : aws_route53_zone.primary[0].zone_id
  name    = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.load_balancers.app.dns_name
    zone_id                = var.load_balancers.app.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "humanizer" {
  zone_id = var.hosted_zone_id != null ? var.hosted_zone_id : aws_route53_zone.primary[0].zone_id
  name    = "humanizer.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.load_balancers.humanizer.dns_name
    zone_id                = var.load_balancers.humanizer.zone_id
    evaluate_target_health = true
  }
}