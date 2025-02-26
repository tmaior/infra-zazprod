resource "aws_lb_target_group" "service_tg_group" {
  name     = var.service.name
  vpc_id   = var.alb.vpc_id
  port     = 80
  protocol = "HTTP"

  health_check {
    matcher             = "200,301"
    path                = "/"
    interval            = 10
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener_rule" "service_listener_rule" {
  listener_arn = var.alb.listener_https_arn
  priority     = var.alb.listener_rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service_tg_group.arn
  }

  condition {
    host_header {
      values = ["${var.service.dns_domain}"]
    }
  }
}