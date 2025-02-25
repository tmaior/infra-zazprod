output "arn" {
  value = var.exists ? data.aws_acm_certificate.cert.arn : aws_acm_certificate.cert.arn
}


output "id" {
  value = var.exists ? data.aws_acm_certificate.cert.id : aws_acm_certificate.cert.id
}
output "certificate_arn" {
  description = "ARN of the created ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "certificate_validation_method" {
  description = "Validation method used for the certificate"
  value       = aws_acm_certificate.cert.validation_method
}
