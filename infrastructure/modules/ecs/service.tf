locals {
  services = {
    "wds-humanizer" = {
      port           = 8001
      cpu            = 1024
      memory         = 2048
      desired_count  = 2
      image          = "${var.ecr_repository_url}/wds-humanizer"
      hash           = "latest"
    }
    "walter-app" = {
      port           = 3001
      cpu            = 1024
      memory         = 2048
      desired_count  = 2
      image          = "${var.ecr_repository_url}/walter-app"
      hash           = "latest"
    }
    "walter-backend" = {
      port           = 8000
      cpu            = 2048
      memory         = 3500
      desired_count  = 6
      image          = "${var.ecr_repository_url}/walter-backend"
      hash           = "latest"
    }
    "walter-frontend" = {
      port           = 3000
      cpu            = 512
      memory         = 512
      desired_count  = 1
      image          = "${var.ecr_repository_url}/walter-frontend"
      hash           = "latest"
    }
  }
}

resource "aws_ecs_task_definition" "services" {
 for_each = local.services
 family = "walter-${each.key}"
 network_mode = "bridge"
 cpu = each.value.cpu
 memory = each.value.memory
 execution_role_arn = aws_iam_role.task_exec.arn
 task_role_arn = aws_iam_role.task_exec.arn

 container_definitions = jsonencode([{
   name = each.key
   image = "${each.value.image}:${each.value.hash}"
   portMappings = [{
     containerPort = each.value.port
     hostPort = 0
   }]
   logConfiguration = {
     logDriver = "awslogs"
     options = {
       awslogs-group = aws_cloudwatch_log_group.this[0].name
       awslogs-region = data.aws_region.current.name
       awslogs-stream-prefix = "ecs-${each.key}"
     }
   }
 }])
}

resource "aws_ecs_service" "services" {
  for_each          = local.services
  name              = "${each.key}-service"
  cluster           = aws_ecs_cluster.main.id
  task_definition   = aws_ecs_task_definition.services[each.key].arn
  desired_count     = each.value.desired_count
  launch_type       = "EC2"
  health_check_grace_period_seconds = 300

  # Associando os serviços aos seus respectivos Target Groups
  dynamic "load_balancer" {
    for_each = {
      "wds-humanizer"   = var.target_groups["wds-humanizer"]
      "walter-app"      = var.target_groups["walter-app"]
      "walter-backend"  = var.target_groups["walter-backend"]
      "walter-frontend" = var.target_groups["walter-frontend"]
    }
    content {
      target_group_arn = load_balancer.value
      container_name   = each.key
      container_port   = each.value.port
    }
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 100
}

resource "aws_security_group" "ecs" {
  count       = 1
  name        = "${local.project_name}-ecs-sg"
  description = "Security group for ECS services"
  vpc_id      = var.vpc_id
}
 