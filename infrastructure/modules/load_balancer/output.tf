# outputs.tf

output "dns_name" {
  value = aws_lb.main.dns_name  # não aws_lb.this
}

output "listener_arn" {
  description = "ARN do listener HTTPS"
  value       = aws_lb_listener.https.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.main.arn  # não aws_lb_target_group.http
}

output "target_groups" {
  value = {
    backend = aws_lb_target_group.backend.arn
    frontend = aws_lb_target_group.frontend.arn
    walter_app = aws_lb_target_group.walter_app.arn
    wds_humanizer = aws_lb_target_group.wds_humanizer.arn
  }
}

output "load_balancers" {
  value = {
    main = {
      dns_name = aws_lb.main.dns_name
      zone_id = aws_lb.main.zone_id
    }
  }
}


output "backend_tg_arn" {
  value = aws_lb_target_group.backend.arn
}

output "frontend_tg_arn" {
  value = aws_lb_target_group.frontend.arn
}

output "walter_app_tg_arn" {
  value = aws_lb_target_group.walter_app.arn
}

output "humanizer_tg_arn" {
  value = aws_lb_target_group.wds_humanizer.arn
}

output "zone_id" {
  description = "Zone ID do Load Balancer"
  value       = aws_lb.main.zone_id
}

