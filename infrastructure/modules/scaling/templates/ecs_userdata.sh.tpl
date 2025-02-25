#!/bin/bash
# Update the instance
echo "UPDATE THE INSTANCE"
sudo yum update -y
sudo yum install -y amazon-linux-extras

# Install Docker
amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
newgrp docker

# Resize EBS
resize2fs /dev/xvda
resize2fs /dev/xvdcz

# Install SSM agent
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl status amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent

# Install and start the ECS agent
sudo amazon-linux-extras disable docker
sudo amazon-linux-extras install -y ecs
aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id --region us-east-1
echo ECS_CLUSTER=${ECS_CLUSTER_NAME} >> /etc/ecs/ecs.config
echo ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true
echo ECS_LOGFILE=/log/ecs-agent.log
echo ECS_LOGLEVEL=info
echo ECS_INSTANCE_ATTRIBUTES={\"cluster_type\":\"web\"} >> /etc/ecs/ecs.config
sudo yum install -y aws-cfn-bootstrap
sudo yum update -y
sudo /opt/aws/bin/cfn-init -v --stack ${ECS_CLUSTER_NAME} --resource ECSInstanceConfiguration --region ${AWS_REGION}
sudo sed -i '/After=cloud-final.service/d' /usr/lib/systemd/system/ecs.service
sudo systemctl daemon-reload
sudo exec 2>>/var/log/ecs-agent-reload.log
set -x
sudo docker plugin install rexray/ebs REXRAY_PREEMPT=true EBS_REGION=${AWS_REGION} --grant-all-permissions
sudo systemctl restart docker
sudo systemctl restart ecs