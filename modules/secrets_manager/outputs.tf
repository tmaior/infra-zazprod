output "arn" {
  description = "ARN of the created secrets"
  value = aws_secretsmanager_secret.this.arn
}

output "name" {
  description = "Name of the created secrets"
  value = aws_secretsmanager_secret.this.name
}