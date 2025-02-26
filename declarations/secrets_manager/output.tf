output "arn" {
  description = "ARNs of the created mobile secrets"
  value = {
    for key, secret in module.secret_manager :
    key => secret.arn
  }
}

output "name" {
  description = "Names of the created mobile secrets"
  value = {
    for key, secret in module.secret_manager :
    key => secret.name
  }
}