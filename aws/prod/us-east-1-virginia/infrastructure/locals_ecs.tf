locals {
  ECS_CLUSTER = {
    PROD = {
        ecs = {
            name = local.infrastructure_suffix
            project_env = local.project_env
        }
        launch_template = {
            instance_type = "t3a.medium"
            device_name = "/dev/xvda"
            ebs_size = 50
            ebs_encrypted = true
            ebs_volume_type = "gp3"
            ebs_delete_on_termination = true
            security_groups = [module.sg_ecs.id.ECS]
            user_data = local.ecs_user_data
            key_pair_name = local.infrastructure_suffix
        }
        autoscaling = {
            desired_instances = 2
            max_instances = 4
            min_instances = 2
            private_subnets = module.vpc.private_subnets
        }
    }
  }
}

locals {
  ecs_user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y amazon-ssm-agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent

              #====== Resize EBS
              growpart /dev/xvda 1
              resize2fs /dev/xvda1

              echo ECS_CLUSTER=${local.infrastructure_suffix} >> /etc/ecs/ecs.config

              # Configurar Docker para usar overlay2
              echo '{ "storage-driver": "overlay2" }' > /etc/docker/daemon.json

              # Reiniciar Docker para aplicar mudanças
              systemctl restart docker

              # JQ
              yum install jq -y

              # TELNET
              yum install telnet -y
  EOF
}


# locals {
#   ecs_user_data = <<-EOF
#               #!/bin/bash
#               dnf update -y
#               dnf install -y amazon-ssm-agent
#               systemctl enable amazon-ssm-agent
#               systemctl start amazon-ssm-agent

#               #====== Resize EBS
#               resize2fs /dev/xvda

#               echo ECS_CLUSTER=${local.infrastructure_suffix} >> /etc/ecs/ecs.config

#               # JQ
#               yum install jq -y

#               # TELNET
#               yum install telnet -y
#               EOF
# }