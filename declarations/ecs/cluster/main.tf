
module "ecs" {
    for_each = var.ecs
    source = "../../../modules/ecs/cluster"
    name = each.value.ecs.name
    project_env = each.value.ecs.project_env
    launch_template = each.value.launch_template
    autoscaling = each.value.autoscaling
}