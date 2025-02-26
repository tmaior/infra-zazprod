module "rds_instance" {
  for_each = var.rds_instance_configs
  source = "../../../modules/rds/instance"

  vpc_security_group_ids = each.value.vpc_security_group_ids
  subnet_ids             = each.value.subnet_ids
  instance_identifier    = each.value.instance_identifier
  instance_class         = each.value.instance_class
  engine                 = each.value.engine
  engine_version         = each.value.engine_version
  port                   = each.value.port
  allocated_storage      = each.value.allocated_storage
  username               = each.value.username
  kms_description        = each.value.kms.description
  deletion_protection    = each.value.deletion_protection
}
