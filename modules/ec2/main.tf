resource "aws_iam_role" "role" {
  name     = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name     = format("instance-profile-%s", var.role_name)
  role     = var.iam_role_name_instance_profile == null ? aws_iam_role.role.name : var.iam_role_name_instance_profile
}

resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip
  availability_zone           = var.availability_zone
  security_groups             = var.security_group_ids
  root_block_device {
    volume_size = var.root_volume_size

  }

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  user_data = var.user_data

  tags = var.tags

  lifecycle {
    ignore_changes = [
      security_groups
    ]
  }
}