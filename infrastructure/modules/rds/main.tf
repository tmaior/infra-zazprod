#===============================================================================
# SUBNET GROUP
#===============================================================================
resource "aws_db_subnet_group" "this" {
 name       = "${var.db_instance_identifier}-subnet-group"
 subnet_ids = var.subnet_ids
 
 tags = merge({
   Name = "${var.db_instance_identifier}-subnet-group"
 }, var.tags)
}

#===============================================================================
# RDS INSTANCE
#===============================================================================
resource "aws_db_instance" "this" {
 identifier = var.db_instance_identifier
 
 allocated_storage = var.db_allocated_storage
 engine           = var.db_engine
 engine_version   = var.db_engine_version
 instance_class   = var.db_instance_class
 
 db_name  = var.db_name
 username = var.db_username
 password = var.db_password
 
 db_subnet_group_name   = aws_db_subnet_group.this.name
 vpc_security_group_ids = var.security_group_ids
 
 publicly_accessible = false
 skip_final_snapshot = true
 
 tags = merge({
   Name = var.db_instance_identifier
 }, var.tags)
}