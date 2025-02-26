variable "vpc_security_group_ids" {
  description = "Lista de IDs de grupos de segurança VPC para a instância RDS"
  type = list(string)
}

variable "subnet_ids" {
  description = "Lista de IDs de sub-redes para a instância RDS"
  type = list(string)
}

variable "instance_identifier" {
  description = "Identificador da instância RDS"
  type = string
}

variable "instance_class" {
  description = "Classe da instância RDS"
  type = string
}

variable "engine" {
  description = "Motor do banco de dados da instância RDS (por exemplo, mysql, postgres)"
  type = string
}

variable "engine_version" {
  description = "Versão do motor da instância RDS"
  type = string
}

variable "port" {
  description = "Porta da instância RDS"
  type = number
}

variable "allocated_storage" {
  description = "Armazenamento alocado para a instância RDS"
  type = number
}

variable "username" {
  description = "Nome de usuário para a instância RDS"
  type = string
}

variable "kms_description" {
  description = "Descrição do KMS para a instância RDS"
  type = string
}

variable "deletion_protection" {
  description = "Flag que habilita a proteção contra exclusão da instância RDS"
  type = bool
}
