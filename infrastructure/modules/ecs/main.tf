locals {
 project_name = var.cluster_name
 execute_command_configuration = {
   logging = "OVERRIDE"
   log_configuration = {
     cloud_watch_log_group_name = try(aws_cloudwatch_log_group.this[0].name, null)
   }
 }
}

#===============================================================================
# CLOUDWATCH LOG GROUP
#===============================================================================
resource "aws_cloudwatch_log_group" "this" {
 count = var.create && var.create_cloudwatch_log_group ? 1 : 0

 name              = "/aws/ecs/${local.project_name}"
 retention_in_days = var.cloudwatch_log_group_retention_in_days
 kms_key_id        = var.cloudwatch_log_group_kms_key_id

 tags = merge(var.tags, {
   CreatedBy = "Terraform"
 })
}

#===============================================================================
# ECS CLUSTER
#===============================================================================
resource "aws_ecs_cluster" "main" {
 name = local.project_name

 configuration {
   execute_command_configuration {
     logging = try(local.execute_command_configuration.logging, "DEFAULT")

     log_configuration {
       cloud_watch_log_group_name = try(local.execute_command_configuration.log_configuration.cloud_watch_log_group_name, null)
     }
   }
 }

 setting {
   name  = "containerInsights"
   value = "enabled"
 }

 tags = {
   Name        = "walter-cluster"
   Project     = "walterwrites"
   Environment = "migration"
   CreatedBy   = "Terraform"
 }
}


#===============================================================================
# IAM Role TASK EXECUTION
#===============================================================================
data "aws_partition" "current" {}

locals {
 task_exec_iam_role_name = try(coalesce(var.task_exec_iam_role_name, aws_ecs_cluster.main.name), "")

 create_task_exec_iam_role = var.create && var.create_task_exec_iam_role
 create_task_exec_policy   = local.create_task_exec_iam_role && var.create_task_exec_policy
}

data "aws_iam_policy_document" "task_exec" {
 count = 1

 statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "task_exec" {
 name = "${local.project_name}-task-exec-role"
 
 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Principal = {
         Service = "ecs-tasks.amazonaws.com"
       }
     }
   ]
 })

 path        = var.task_exec_iam_role_path
 description = coalesce(var.task_exec_iam_role_description, "Task execution role for ${local.project_name}")
 permissions_boundary  = var.task_exec_iam_role_permissions_boundary
 force_detach_policies = true

 tags = merge(var.tags, var.task_exec_iam_role_tags)
}

resource "aws_iam_role_policy_attachment" "task_exec_default" {
 role       = aws_iam_role.task_exec.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "task_exec_additional" {
 for_each = { for k, v in var.task_exec_iam_role_policies : k => v }

 role       = aws_iam_role.task_exec.name
 policy_arn = each.value
}

resource "aws_iam_policy" "task_exec" {
 count = local.create_task_exec_policy ? 1 : 0

 name        = var.task_exec_iam_role_use_project_name ? null : local.task_exec_iam_role_name
 name_prefix = var.task_exec_iam_role_use_project_name ? "${local.task_exec_iam_role_name}-" : null
 description = coalesce(var.task_exec_iam_role_description, "Task execution role IAM policy")
 policy      = data.aws_iam_policy_document.task_exec[0].json

 tags = merge(var.tags, var.task_exec_iam_role_tags)
}

resource "aws_iam_role_policy_attachment" "task_exec" {
 count = local.create_task_exec_policy ? 1 : 0

 role       = aws_iam_role.task_exec.name
 policy_arn = aws_iam_policy.task_exec[0].arn
}



#===============================================================================
# CAPACITY PROVIDER
#===============================================================================


# Capacity Provider para o Cluster
resource "aws_ecs_capacity_provider" "main" {
  name = "${local.project_name}-capacity-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = var.existing_asg_arn  # ARN do seu Auto Scaling Group existente

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }

    managed_termination_protection = "ENABLED"
  }

  tags = {
    Name        = "walter-capacity-provider"
    Project     = "walterwrites"
    Environment = "migration"
    CreatedBy   = "Terraform"
  }
}

# Associação do Capacity Provider com o Cluster
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = [aws_ecs_capacity_provider.main.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.main.name
  }
}

resource "aws_lb_target_group" "backend" {
  name     = "${local.project_name}-backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id 


}

resource "aws_lb_target_group" "frontend" {
  name     = "${local.project_name}-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id  

}


data "aws_region" "current" {}