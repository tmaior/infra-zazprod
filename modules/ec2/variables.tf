variable "role_name" {
  description = "Nome da role SSM"
  type        = string
}

variable "ami" {
  description = "ID da AMI"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH"
  type        = string
}

variable "subnet_id" {
  description = "ID da Subnet"
  type        = string
}

variable "associate_public_ip" {
  description = "Associar IP público"
  type        = bool
}

variable "availability_zone" {
  description = "Zona de disponibilidade"
  type        = string
}

variable "security_group_ids" {
  description = "IDs dos grupos de segurança"
  type        = list(string)
}

variable "user_data" {
  description = "Dados de usuário"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}

variable "root_volume_size" {
  description = "Tamanho do volume root"
  type        = number
}

variable "iam_role_name_instance_profile" {
  description = "Nome da role IAM"
  type        = string
  default = null
}