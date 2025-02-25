output "hosted_zone_id" {
  value = var.create_route53_zone ? aws_route53_zone.primary[0].zone_id : var.hosted_zone_id
}
