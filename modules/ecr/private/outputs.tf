output "arn" {
  description = "ARNs of the created ECR repositories"
  value = aws_ecr_repository.repositories.arn
}

output "name" {
  description = "Names of the created ECR repositories"
  value = aws_ecr_repository.repositories.name
}

output "repository_url" {
  description = "URIs of the created ECR repositories"
  value = aws_ecr_repository.repositories.repository_url
}