resource "aws_cloudwatch_log_group" "service_log_group" {
  name = var.log_group_name
  retention_in_days = var.log_group_retention_days
}