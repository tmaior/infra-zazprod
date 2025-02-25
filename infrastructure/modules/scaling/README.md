<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.48.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.scaling_policy](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/autoscaling_policy) | resource |
| [aws_iam_instance_profile.ecs_profile](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.attach_role_policy](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.ecs_node_role_policy](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_key_pair.key_name](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/key_pair) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/launch_template) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.workloads](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ami_ids_name"></a> [aws\_ami\_ids\_name](#input\_aws\_ami\_ids\_name) | The name of the AMI (provided during image creation). | `list(string)` | <pre>[<br>  "amzn-ami-*-amazon-ecs-optimized"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster. | `string` | n/a | yes |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group. | `number` | n/a | yes |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before checking the health status of an EC2 instance that has come into service. | `number` | n/a | yes |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | The service to use for the health checks. | `string` | `"EC2"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start. | `string` | `"t3.micro"` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the Auto Scaling group. | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the Auto Scaling group. | `number` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The prefix for all resources | `string` | n/a | yes |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key to install on the instance. | `string` | n/a | yes |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | value of the security group to associate with launched instances. | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | The environment for all resources | `string` | n/a | yes |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | The ARN of the autoscaling group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
