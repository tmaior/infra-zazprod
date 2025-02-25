#===============================================================================
# INSTANCE PROFILE
#===============================================================================
resource "aws_iam_role" "role" {
 name               = format("aws_ltr-%s", split("-", uuid())[0])
 path               = "/"
 assume_role_policy = data.aws_iam_policy_document.assume_role.json

 lifecycle {
   ignore_changes = [
     name
   ]
 }
}

resource "aws_iam_instance_profile" "ecs_profile" {
 name = format("aws_ipr_role-%s", split("-", uuid())[0])
 role = aws_iam_role.role.name

 lifecycle {
   ignore_changes = [
     name
   ]
 }
}

data "aws_iam_policy_document" "assume_role" {
 statement {
   effect = "Allow"

   principals {
     type        = "Service"
     identifiers = ["ec2.amazonaws.com", "ecs.amazonaws.com"]
   }
   actions = ["sts:AssumeRole"]
 }
}

data "aws_iam_policy_document" "workloads" {
 statement {
   sid    = "RoleForECSWorkloads"
   effect = "Allow"
   actions = [
     "ssmmessages:*",
     "cloudwatch:*",
     "ds:*",
     "logs:*", 
     "ssm:*",
     "ec2messages:*",
     "application-autoscaling:DeleteScalingPolicy",
     "application-autoscaling:*",
     "appmesh:*",
     "autoscaling:*",
     "cloudformation:*",
     "cloudwatch:*",
     "codedeploy:*",
     "ec2:*",
     "ecs:*",
     "elasticfilesystem:*",
     "elasticloadbalancing:*",
     "events:*",
     "iam:*",
     "lambda:ListFunctions",
     "logs:*",
     "route53:*",
     "servicediscovery:*",
     "sns:*"
   ]
   resources = ["*"]
 }
}

resource "aws_iam_role_policy_attachment" "ecs_node_role_policy" {
 role       = aws_iam_role.role.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy" "attach_role_policy" {
 policy = data.aws_iam_policy_document.workloads.json
 role   = aws_iam_role.role.name
}

resource "aws_autoscaling_group" "this" {
  count                     = length(var.vpc_zone_identifier) > 0 ? 1 : 0
  name                      = var.project_name
  max_size                  = 4
  min_size                  = 4
  desired_capacity          = 4
  health_check_grace_period = 10
  health_check_type         = "EC2"

  protect_from_scale_in = true


  vpc_zone_identifier = var.vpc_zone_identifier
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  } 
}

resource "aws_launch_template" "this" {
  name_prefix   = "ecs-launch-template"
  instance_type = "t3a.medium"

  image_id = data.aws_ami.amazon_linux.id

}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = var.aws_ami_ids_name
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}