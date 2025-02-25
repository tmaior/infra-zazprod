
output "ecs_cpu_alarm_name" {
  description = "The name of the ECS CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_utilization.alarm_name
}

output "ec2_cpu_alarm_name" {
  description = "The name of the EC2 CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.ec2_cpu_utilization.alarm_name
}

output "rds_cpu_alarm_name" {
  description = "The name of the RDS CPU utilization alarm"
  value       = aws_cloudwatch_metric_alarm.rds_cpu_utilization.alarm_name
}
