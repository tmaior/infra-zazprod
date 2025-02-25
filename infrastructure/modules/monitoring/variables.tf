variable "stage" {
  description = "The stage/environment (e.g., prod, stag)"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "ec2_instance_id" {
  description = "ID of the EC2 instance"
  type        = string
}

variable "rds_instance_id" {
  description = "ID of the RDS instance"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Project     = "walterwrites"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}