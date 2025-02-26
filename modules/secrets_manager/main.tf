resource "aws_secretsmanager_secret" "this" {
  recovery_window_in_days = 0
  name                    = var.name
  description             = var.description

  tags = {
    "Terraform" = "true"
  }
}