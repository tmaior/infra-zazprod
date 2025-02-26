variable "name" {
  type = string
  description = "ECS Cluster name"
}

variable "project_env" {
  type = string
  description = "Project environment"
}

variable "autoscaling" {
    type = object({
        desired_instances = number
        max_instances = number
        min_instances = number
        private_subnets = list(string)
    })
    description = "Auto Scaling Configuration"
}

variable "launch_template" {
    type = object({
        instance_type = string
        device_name = string
        ebs_size = number
        ebs_encrypted = bool
        ebs_volume_type = string
        ebs_delete_on_termination = bool
        security_groups = list(string)
        user_data = string
        key_pair_name = string
    })
    description = "Launch Template Configuration"
}