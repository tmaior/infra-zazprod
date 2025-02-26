variable "name" {
  type = string
  description = "ECR repository name"
}


variable "tags" {
  type = object({})
  description = "ECR repository tag"
  default = {
    "Terraform" = "true"
  }
}