locals {
  project_name = lower(format("%s-%s", var.stage, var.project_name))
}

resource "aws_lb" "main" {
  name               = "${local.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups_id
  subnets            = var.subnets_id
  tags = {
    Name = "${local.project_name}-alb"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${local.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/health"
    port                = "80"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Remova o listener HTTP para evitar conflito com o redirect
# resource "aws_lb_listener" "http" {
#   count = 0
#   load_balancer_arn = aws_lb.main.arn
#   port = "80"
#   protocol = "HTTP"
#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.main.arn
#   }
# }

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:654654523718:certificate/ce586be9-fce9-4421-b0f7-dc9f91f5194a"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "backend" {
  name        = "${local.project_name}-backend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/api/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "frontend" {
  name        = "${local.project_name}-frontend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "walter_app" {
  name        = "${local.project_name}-walter-app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "wds_humanizer" {
  name        = "${local.project_name}-humanizer-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# Adicione as regras de listener para cada target group
resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
  
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

resource "aws_lb_listener_rule" "frontend_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 200
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
  
  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  # Esta condição deve vir depois da regra do backend
  # para permitir que /api/* seja roteado para o backend
}

resource "aws_lb_listener_rule" "app_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 300
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.walter_app.arn
  }
  
  condition {
    path_pattern {
      values = ["/app/*"]
    }
  }
}

resource "aws_lb_listener_rule" "humanizer_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 400
  
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wds_humanizer.arn
  }
  
  condition {
    path_pattern {
      values = ["/humanizer/*"]
    }
  }
}