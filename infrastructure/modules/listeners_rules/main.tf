resource "aws_lb_target_group" "backend" {
  name        = "prod-walterwrites-backend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0ca6a1fee11b317af"
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
}

resource "aws_lb_target_group" "frontend" {
  name        = "prod-walterwrites-frontend-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0ca6a1fee11b317af"
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
}

resource "aws_lb_target_group" "walter_app" {
  name        = "prod-walterwrites-walter-app-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0ca6a1fee11b317af"
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
}

resource "aws_lb_target_group" "wds_humanizer" {
  name        = "prod-walterwrites-humanizer-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0ca6a1fee11b317af"
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
}

resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = var.https_listener_arn
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
  listener_arn = var.https_listener_arn
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
}

resource "aws_lb_listener_rule" "app_rule" {
  listener_arn = var.https_listener_arn
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
  listener_arn = var.https_listener_arn
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
