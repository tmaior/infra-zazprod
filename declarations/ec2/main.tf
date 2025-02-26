module "ec2" {
  for_each = var.ec2_configs
  source = "../../modules/ec2"
  role_name = each.value.role_name
  ami = each.value.ami
  instance_type = each.value.instance_type
  key_name = each.value.key_name
  subnet_id = each.value.subnet_id
  associate_public_ip = each.value.associate_public_ip
  availability_zone = each.value.availability_zone
  security_group_ids = each.value.security_group_ids
  user_data = each.value.user_data
  tags = each.value.tags
  root_volume_size = each.value.root_volume_size
  iam_role_name_instance_profile = each.value.iam_role_name_instance_profile
}
