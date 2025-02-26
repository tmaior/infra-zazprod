resource "aws_kms_key" "rds" {
  # for_each    = var_configs
  description = var.kms.description

  enable_key_rotation     = true
  rotation_period_in_days = 90

  tags = {
    Name = "kms-${var.cluster_identifier}"
  }
}

resource "aws_kms_alias" "rds" {
  name          = "alias/rds/${var.cluster_identifier}"
  target_key_id = aws_kms_key.rds.key_id
}

# Criação da IAM Role para Enhanced Monitoring no RDS
resource "aws_iam_role" "rds_monitoring_role" {
  name     = format("%s-rds-monitoring-role", var.cluster_identifier)

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
    Name = format("rds-monitoring-role-%s", var.cluster_identifier)
  }
}

# Política Gerenciada para Enhanced Monitoring do RDS
resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_rds_cluster" "clusters" {
  cluster_identifier            = var.cluster_identifier
  engine                        = var.engine
  engine_version                = var.engine_version
  master_username               = var.master_username
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.rds.key_id
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  allocated_storage = var.allocated_storage
  db_cluster_instance_class  = var.db_cluster_instance_class
  storage_encrypted       = true
  skip_final_snapshot     = true
  preferred_backup_window = var.preferred_backup_window
  deletion_protection     = var.deletion_protection
  port                    = var.port

  tags = {
    Name = "${var.cluster_identifier}"
  }
}

# Subnet Group para o RDS Cluster (único, utilizado por todos os clusters)
resource "aws_db_subnet_group" "rds" {
  name       = "rds-subnet-group-${var.cluster_identifier}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group-${var.cluster_identifier}"
  }
}

resource "aws_rds_cluster_instance" "writers" {

  identifier          = var.rds_writer.identifier
  cluster_identifier  = aws_rds_cluster.clusters.id
  instance_class      = var.rds_writer.instance_class
  engine              = var.engine
  engine_version      = var.engine_version
  publicly_accessible = false
  availability_zone   = var.rds_writer.availability_zone

  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  tags = {
    Name = var.rds_writer.identifier
  }
}

# locals {
#   all_readers = flatten([
#     for name, config in var_configs : [
#       for idx, reader in config.rds_readers : {
#         name              = name
#         idx               = idx
#         identifier        = reader.identifier
#         instance_class    = reader.instance_class
#         availability_zone = reader.availability_zone
#         engine            = config.rds_cluster.engine
#         engine_version    = config.rds_cluster.engine_version
#         cluster_id        = aws_rds_cluster.clusters[name].id
#       }
#     ]
#   ])
# }

resource "aws_rds_cluster_instance" "readers" {
  for_each = {for key,value in var.rds_readers : key => value }

  identifier          = each.value.identifier
  cluster_identifier  = each.value.cluster_id
  instance_class      = each.value.instance_class
  engine              = each.value.engine
  engine_version      = each.value.engine_version
  publicly_accessible = false
  availability_zone   = each.value.availability_zone

  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  depends_on = [aws_rds_cluster_instance.writers]

  tags = {
    Name = each.value.identifier
  }
}

# Auto Scaling para cada configuração
resource "aws_appautoscaling_target" "rds_target" {
  count = var.enable_autoscaling ? 1 : 0

  # for_each = { for key, config in var_configs : key => config if config.enable_autoscaling }

  service_namespace  = "rds"
  resource_id        = var.autoscaling.resource_id # Usando o resource_id do autoscaling na variável
  scalable_dimension = var.autoscaling.scalable_dimension
  min_capacity       = var.autoscaling.min_capacity
  max_capacity       = var.autoscaling.max_capacity

  depends_on = [aws_rds_cluster.clusters]
}

resource "aws_appautoscaling_policy" "rds_scaling_policy" {
  count = var.enable_autoscaling ? 1 : 0

  name               = var.autoscaling.name # Usando o nome da política do autoscaling na variável
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.rds_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.rds_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.rds_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.autoscaling.target_value
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }

    scale_in_cooldown  = var.autoscaling.scale_in_cooldown
    scale_out_cooldown = var.autoscaling.scale_out_cooldown
  }
}
