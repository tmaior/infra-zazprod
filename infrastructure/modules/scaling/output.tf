output "autoscaling_group_arn" {
  description = "The ARN of the autoscaling group"
  value = length(aws_autoscaling_group.this) > 0 ? aws_autoscaling_group.this[0].arn : null
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value = length(aws_autoscaling_group.this) > 0 ? aws_autoscaling_group.this[0].name : null
}

output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.this.id
}

output "iam_role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.role.arn
}
