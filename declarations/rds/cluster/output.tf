output "cluster_name" {
  value = { for key, value in module.rds_cluster : key => value.cluster_name }
}

output "endpoint" {
  value = { for key, value in module.rds_cluster : key => value.endpoint }
}