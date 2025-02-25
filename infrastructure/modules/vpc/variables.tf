variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "stage" {
  description = "The stage of the project"
  type        = string
}

variable "public_subnets" {
  description = "The public subnets of the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "The private subnets of the VPC"
  type        = list(string)
}

variable "azs" {
  description = "The availability zones of the VPC"
  type        = list(string)
}



