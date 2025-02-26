resource "aws_route53_record" "service" {
  zone_id = var.route53.hostedzone_id
  name    = var.service.dns_domain
  type    = "CNAME"
  ttl     = 300
  records = [var.alb.dns]
}