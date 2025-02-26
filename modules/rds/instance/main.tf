
resource "aws_kms_key" "rds_instance" {
  enable_key_rotation = true

  tags = {
    Name = "kms-rds-${var.instance_identifier}"
  }
}

resource "aws_kms_alias" "rds_instance" {

  name          = "alias/rds/${var.instance_identifier}"
  target_key_id = aws_kms_key.rds_instance.key_id
}

resource "aws_iam_role" "rds_monitoring_role" {
  # for_each = var.rds_instance_configs
  name     = "rds-instance-monitoring-role-${var.instance_identifier}"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "monitoring.rds.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "rds-instance-monitoring-role-${var.instance_identifier}"
  }
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  # for_each   = var.rds_instance_configs
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_db_subnet_group" "rds_instance" {
  # for_each   = var.rds_instance_configs
  name       = "rds-subnet-group-${var.instance_identifier}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group-${var.instance_identifier}"
  }
}

resource "aws_db_instance" "rds_instance" {
  identifier                  = var.instance_identifier
  instance_class              = var.instance_class
  engine                      = var.engine
  engine_version              = var.engine_version
  port                        = var.port
  allocated_storage           = var.allocated_storage
  db_subnet_group_name        = aws_db_subnet_group.rds_instance.name
  vpc_security_group_ids      = var.vpc_security_group_ids
  storage_encrypted           = true
  kms_key_id                  = aws_kms_key.rds_instance.arn
  skip_final_snapshot         = true
  username                    = var.username
  manage_master_user_password = true
  monitoring_interval         = 60
  monitoring_role_arn         = aws_iam_role.rds_monitoring_role.arn
  publicly_accessible         = false
  deletion_protection         = var.deletion_protection

  tags = {
    Name = var.instance_identifier
  }
}
