output "cluster_name" {
  value = aws_rds_cluster.clusters.cluster_identifier
}

output "endpoint" {
  value = aws_rds_cluster.clusters.endpoint
}