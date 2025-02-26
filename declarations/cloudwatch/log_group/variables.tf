variable "cloudwatch_log_group" {
  description = "Configuration for the CloudWatch log group"
  type = map(object({
    log_group_name = string
    log_group_retention_days = number
  }))
}