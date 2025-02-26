# Outputs para os security groups
output "id" {
  description = "IDs dos security groups criados"
  value       = { for key, sg in module.security_group : key => sg.id }
}

output "name" {
  description = "Nomes dos security groups criados"
  value       = { for key, sg in module.security_group : key => sg.name }
}
