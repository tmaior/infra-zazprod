variable "log_group_name" {
  description = "The name of the log group"
  type        = string
}

variable "log_group_retention_days" {
  description = "The number of days to retain the log events in the log group"
  type        = number
}