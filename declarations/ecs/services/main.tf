module "ecs_services" {
    for_each = var.ecs_services
    source = "../../../modules/ecs/services"
    service = each.value.service
    task_definition = each.value.task_definition
    alb = each.value.alb
    route53 = each.value.route53
}