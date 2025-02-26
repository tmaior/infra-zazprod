resource "aws_ecs_capacity_provider" "ecs" {
  name = format("%s-ecs-capacity-provider", var.name)

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
  }

  tags = {
    Name        = format("%s-ecs-capacity-provider", var.name)
    Environment = var.project_env
    Terraform   = "true"
  }

    depends_on = [ aws_autoscaling_group.ecs, aws_ecs_cluster.ecs ]
}

resource "aws_ecs_cluster_capacity_providers" "capacity_provider" {
  cluster_name       = aws_ecs_cluster.ecs.name
  capacity_providers = [aws_ecs_capacity_provider.ecs.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs.name
    base              = 1
    weight            = 1
  }

  depends_on = [ aws_ecs_cluster.ecs, aws_ecs_capacity_provider.ecs ]
}