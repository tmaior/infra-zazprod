resource "aws_kms_key" "ecs" {
  description             = format("%s/ecs/kms", var.name)
  deletion_window_in_days = 7
}

resource "aws_cloudwatch_log_group" "ecs" {
  name = format("/aws/ecs/%s", var.name)
}

resource "aws_ecs_cluster" "ecs" {
  name = var.name

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ecs.arn
      logging    = try("OVERRIDE", "DEFAULT")

      log_configuration {
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs.name
      }
    }
  }

  tags = {
    Name        = var.name
    Environment = var.project_env
    Terraform   = "true"
  }
}


