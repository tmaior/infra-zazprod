resource "aws_ecs_service" "service" {
  name            = var.service.name
  cluster         = var.service.cluster_name
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.service.task_desire_count

  capacity_provider_strategy {
    capacity_provider = var.service.capacity_provider_name
    weight            = 1
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.service_tg_group.arn
    container_name   = var.task_definition.container_name
    container_port   = var.task_definition.container_port
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
      ]
  }
}
