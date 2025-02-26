
data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

resource "aws_launch_template" "ecs" {
  name_prefix   = format("%s-ecs-launch-template", var.name) 
  image_id      = data.aws_ami.ecs_ami.id
  instance_type = var.launch_template.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs.name
  }

  block_device_mappings {
    device_name = var.launch_template.device_name

    ebs {
      volume_size           = var.launch_template.ebs_size
      encrypted             = var.launch_template.ebs_encrypted
      volume_type           = var.launch_template.ebs_volume_type
      delete_on_termination = var.launch_template.ebs_delete_on_termination
    }
  }

  vpc_security_group_ids = var.launch_template.security_groups

  user_data = base64encode(var.launch_template.user_data)
#   user_data = base64encode("#!/bin/bash\n echo ECS_CLUSTER=${var.launch_template.environment}-${var.launch_template.project_name} >> /etc/ecs/ecs.config")

  key_name = var.launch_template.key_pair_name

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = format("%s-ecs-launch-template", var.name)
    Environment = var.project_env
    Terraform   = "true"
  }

  depends_on = [aws_iam_instance_profile.ecs]
}

resource "aws_autoscaling_group" "ecs" {
  name              = format("%s-ecs-auto-scaling", var.name)
  desired_capacity  = var.autoscaling.desired_instances
  health_check_type = "EC2"
  max_size          = var.autoscaling.max_instances
  min_size          = var.autoscaling.min_instances

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = format("%s-ecs-instance", var.name)
  }

  termination_policies = ["Default"]

  vpc_zone_identifier = var.autoscaling.private_subnets

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      tag,
      desired_capacity
    ]
  }
}
