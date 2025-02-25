variable "project_name" {
  type        = string
  description = "The prefix for all resources"
}

variable "stage" {
  type        = string
  description = "The environment for all resources"
}

#===============================================================================
# LAUNCH TEMPLATE
#===============================================================================
variable "public_key" {
  type        = string
  description = "The public key to install on the instance."
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to create."
}

variable "security_groups" {
  type        = list(string)
  description = "value of the security group to associate with launched instances."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start."
  default     = "t3.micro"
}

#===============================================================================
# AUTOSCALING GROUP
#===============================================================================
variable "vpc_zone_identifier" {
  type        = list(string)
  description = "A list of subnet IDs to launch resources in."
  default     = []
}

variable "max_size" {
  type        = number
  description = "The maximum size of the Auto Scaling group."
}

variable "min_size" {
  type        = number
  description = "The minimum size of the Auto Scaling group."
}

variable "health_check_grace_period" {
  type        = number
  description = "The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service."
}

variable "health_check_type" {
  type        = string
  description = "The service to use for the health checks."
  default     = "EC2"
}

variable "desired_capacity" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group."
}

variable "aws_ami_ids_name" {
  type        = list(string)
  description = "The name of the AMI (provided during image creation)."
  default     = ["amzn-ami-*-amazon-ecs-optimized"]
}
