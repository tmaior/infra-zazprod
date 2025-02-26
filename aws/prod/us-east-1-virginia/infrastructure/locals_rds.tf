# # ###########################################
# # RDS
# # ############################################

locals {
  RDS_PORTS = {
    RDS_PSQL       = 5432
  }
}


locals {
  RDS_INSTANCE_CONFIGS = {
    RDS_PSQL = {
      vpc_security_group_ids = [module.sg_rds_psql.id.RDS_PSQL]
      instance_identifier    = "${local.infrastructure_suffix}"
      subnet_ids             = module.vpc.isolated_private_subnets
      instance_class         = "db.t3.small"
      engine                 = "postgres"
      engine_version         = "15.7"
      allocated_storage      = 50
      username               = "${local.project_env}_admin"
      port                   = local.RDS_PORTS.RDS_PSQL
      kms = {
        description = "PSQL KMS Key for RDS Encryption"
      }
      deletion_protection = true
    }
  }
}


# locals {
#   RDS_NUMBER_OF_READERS = {
#     RDS_PSQL       = 0
#   }

#   RDS_CLUSTER_CONFIGS = {
#     RDS_PSQL = {
#       rds_cluster = {
#         cluster_identifier      = local.infrastructure_suffix
#         vpc_security_group_ids  = [module.sg_rds_psql.id.RDS_PSQL]
#         subnet_ids              = module.vpc.isolated_private_subnets
#         engine                  = "mysql"
#         engine_version          = "8.0"
#         allocated_storage       = 50
#         db_cluster_instance_class = "db.t3.small"
#         master_username         = "${local.project_env}_admin"
#         preferred_backup_window = "03:09-03:39"
#         deletion_protection     = true
#         port                    = local.RDS_PORTS.RDS_PSQL
#       }

#       kms = {
#         description = "${local.infrastructure_suffix} KMS Key for RDS Encryption"
#       }

#       rds_writer = {
#         identifier        = "writer-${local.infrastructure_suffix}"
#         instance_class    = "db.t3.small"
#         availability_zone = local.azs[0]
#       }

#       number_of_readers = local.RDS_NUMBER_OF_READERS.RDS_PSQL

#       rds_readers = flatten([
#         for i in range(local.RDS_NUMBER_OF_READERS.RDS_PSQL) : {
#           identifier        = "reader-${i}-${local.infrastructure_suffix}"
#           instance_class    = "db.t3.small"
#           availability_zone = local.azs[i % length(local.azs)] # Variar zonas de disponibilidade
#         }
#       ])

#       enable_autoscaling = false
#       autoscaling = {
#         name               = ""
#         resource_id        = ""
#         scalable_dimension = ""
#         min_capacity       = 0
#         max_capacity       = 0
#         target_value       = 0
#         scale_in_cooldown  = 0
#         scale_out_cooldown = 0
#       }
#     }
#   }
# }