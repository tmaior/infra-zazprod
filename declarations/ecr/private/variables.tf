variable "ecr_repositories" {
  type = map(object({
    name = string
    tags = optional(map(string), {
      "Terraform" = "true"
    })
  }))
  description = "Map of ECR repositories with their corresponding names and tags"
}
