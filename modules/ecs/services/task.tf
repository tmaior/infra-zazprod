
resource "aws_iam_role" "service_execution_role" {
  name = "${var.service.name}-execution-role"
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
}

resource "aws_iam_policy" "service_execution_policy" {
  name        = "${var.service.name}-execution-policy"
  description = "Allows ECS tasks to pull images and retrieve secrets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "service_execution_role_attach" {
  role       = aws_iam_role.service_execution_role.name
  policy_arn = aws_iam_policy.service_execution_policy.arn
}

resource "aws_ecs_task_definition" "task_definition" {
  family = var.service.name
  task_role_arn = aws_iam_role.service_execution_role.arn
  execution_role_arn = aws_iam_role.service_execution_role.arn
  network_mode = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions = jsonencode([
    {
      name      = var.task_definition.container_name
      image     = "${var.task_definition.repository_url}"
      network_mode = "awsvpc"
      essential = true
      cpu       = var.task_definition.container_cpu
      memory    = var.task_definition.container_memory
      secrets = var.task_definition.secrets
      portMappings = [
        {
          containerPort = var.task_definition.container_port
          hostPort      = 0
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options    = {
          "awslogs-group"         = "${var.task_definition.log_group_name}"
          "awslogs-region"        = "${var.service.region}"
          "awslogs-stream-prefix" = "/ecs"
        }
      }
    }
  ])
}
