output "cluster_name" {
  description = "The name of the cluster"
  value       = aws_ecs_cluster.main.name  # Alterado de cluster para main
}

output "cluster_id" {
  description = "The ID of the cluster"
  value       = aws_ecs_cluster.main.id    # Alterado de cluster para main
}

output "capacity_provider_name" {
  value = aws_ecs_capacity_provider.main.name
}





