variable "ecr_policies" {
  type = map(object({
    repository_name = string
    policy = string
  }))
  description = "Map of ECR repositories with their corresponding names and tags"
}
