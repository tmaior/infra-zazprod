module "log_group" {
    for_each = var.cloudwatch_log_group
    source = "../../../modules/cloudwatch/log_group"
    log_group_name = each.value.log_group_name
    log_group_retention_days = each.value.log_group_retention_days
}