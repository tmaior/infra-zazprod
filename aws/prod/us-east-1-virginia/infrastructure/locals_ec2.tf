
locals {
  EC2 = {
    BASTION = {
      role_name       = "bastion-${local.infrastructure_suffix}"
      ami                 = "ami-0df8c184d5f6ae949"
      instance_type       = "t3a.micro"
      key_name            = "bastion-${local.infrastructure_suffix}"
      subnet_id           = module.vpc.public_subnets[0]
      root_volume_size    = 100
      associate_public_ip = true
      availability_zone   = local.azs[0]
      security_group_ids  = [module.sg_bastion.id.BASTION]
      user_data           = local.bastion_user_data
      tags = {
        Name = "bastion-${local.infrastructure_suffix}"
      }
    }
  }
}

locals {
  bastion_user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent

              # MySQL
              dnf install -y mariadb105

              # JQ
              yum install jq -y

              # TELNET
              yum install telnet -y
              EOF
}