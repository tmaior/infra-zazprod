variable "vpc_security_group_ids" {
  description = "Lista de IDs de grupos de segurança VPC para o RDS"
  type = list(string)
}

variable "subnet_ids" {
  description = "Lista de IDs de sub-redes para o RDS"
  type = list(string)
}

variable "cluster_identifier" {
  description = "Identificador do cluster RDS"
  type = string
}

variable "db_cluster_instance_class" {
  description = "Classe de instância do RDS"
  type = string
}

variable "engine" {
  description = "Motor do banco de dados do RDS (por exemplo, mysql, postgres)"
  type = string
}

variable "engine_version" {
  description = "Versão do motor do RDS"
  type = string
}

variable "master_username" {
  description = "Nome de usuário mestre do RDS"
  type = string
}

variable "preferred_backup_window" {
  description = "Janela de backup preferida do RDS"
  type = string
}

variable "deletion_protection" {
  description = "Flag que habilita a proteção contra exclusão do RDS"
  type = bool
}

variable "port" {
  description = "Porta do RDS"
  type = number
}

variable "kms" {
  type = object({
      description = string
    })
  default = {
    description = "KMS Key for RDS Instance"
  }
}

variable "number_of_readers" {
  type = number
  default = 0
}

variable "rds_writer" {
  type = object({
      identifier        = string
      instance_class    = string
      availability_zone = string
    })
  default = {
    identifier = "default"
    instance_class = "db.t3.medium"
    availability_zone = "us-east-2a"
  }
}

variable "rds_readers" {
  type = list(object({
      identifier        = string
      instance_class    = string
      availability_zone = string
    }))
  default = [] 
}

variable "enable_autoscaling" {
  type = bool
}

variable "autoscaling" {
  type = object({
      name               = optional(string)
      resource_id        = optional(string)
      scalable_dimension = optional(string)
      min_capacity       = optional(number)
      max_capacity       = optional(number)
      target_value       = optional(number)
      scale_in_cooldown  = optional(number)
      scale_out_cooldown = optional(number)
    })
  default = {}
}

variable "allocated_storage" {
  description = "Allocated storage for the RDS instance"
  type = number
}
