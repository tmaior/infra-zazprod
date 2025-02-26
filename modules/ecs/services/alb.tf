resource "aws_lb_target_group" "service_tg_group" {
  name     = var.service.name
  vpc_id   = var.target_group.vpc_id
  port     = 80
  protocol = "HTTP"

  health_check {
    matcher             = var.target_group.health_check_matcher
    path                = var.target_group.health_check_path
    interval            = var.target_group.health_check_interval
    protocol            = var.target_group.health_check_protocol
    timeout             = var.target_group.health_check_timeout
    healthy_threshold   = var.target_group.health_check_healthy_threshold
    unhealthy_threshold = var.target_group.health_check_unhealthy_threshold
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