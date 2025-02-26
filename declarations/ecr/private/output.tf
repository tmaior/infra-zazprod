output "arn" {
  description = "ARNs of the created mobile secrets"
  value = {
    for key, value in module.ecr :
    key => value.arn
  }
}

output "name" {
  description = "Names of the created mobile secrets"
  value = {
    for key, value in module.ecr :
    key => value.name
  }
}

output "repository_url" {
  description = "URIs of the created ECR repositories"
    value = {
    for key, value in module.ecr :
    key => value.repository_url
  }
}