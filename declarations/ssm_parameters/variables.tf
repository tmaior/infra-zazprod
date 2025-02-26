variable "ssm_parameters" {
  type = map(object({
    name = string
    description = string
    secret_type = string
    value = string
  }))
}