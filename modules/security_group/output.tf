# Outputs para os security groups
output "id" {
  description = "IDs dos security groups criados"
  value       = aws_security_group.sg.id
}

output "name" {
  description = "Nomes dos security groups criados"
  value       = aws_security_group.sg.name
}
