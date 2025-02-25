<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.48.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion_sg"></a> [bastion\_sg](#module\_bastion\_sg) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_documentdb_sg"></a> [documentdb\_sg](#module\_documentdb\_sg) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_ecs_sg"></a> [ecs\_sg](#module\_ecs\_sg) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_load_balancer_sg"></a> [load\_balancer\_sg](#module\_load\_balancer\_sg) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_service_sg"></a> [service\_sg](#module\_service\_sg) | terraform-aws-modules/security-group/aws | 5.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_commom_tags"></a> [commom\_tags](#input\_commom\_tags) | The common tags for all resources | `map(string)` | <pre>{<br>  "Environment": "dev",<br>  "Terraform": "true"<br>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The prefix for all resources | `string` | `"test"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | The environment for all resources | `string` | `"dev"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_sg_arn"></a> [bastion\_sg\_arn](#output\_bastion\_sg\_arn) | Bastion security group ARN |
| <a name="output_bastion_sg_id"></a> [bastion\_sg\_id](#output\_bastion\_sg\_id) | Bastion security group ID |
| <a name="output_bastion_sg_name"></a> [bastion\_sg\_name](#output\_bastion\_sg\_name) | Bastion security group name |
| <a name="output_documentdb_sg_arn"></a> [documentdb\_sg\_arn](#output\_documentdb\_sg\_arn) | DocumentDB security group ARN |
| <a name="output_documentdb_sg_id"></a> [documentdb\_sg\_id](#output\_documentdb\_sg\_id) | DocumentDB security group ID |
| <a name="output_documentdb_sg_name"></a> [documentdb\_sg\_name](#output\_documentdb\_sg\_name) | DocumentDB security group name |
| <a name="output_ecs_sg_arn"></a> [ecs\_sg\_arn](#output\_ecs\_sg\_arn) | ECS security group ARN |
| <a name="output_ecs_sg_id"></a> [ecs\_sg\_id](#output\_ecs\_sg\_id) | ECS security group ID |
| <a name="output_ecs_sg_name"></a> [ecs\_sg\_name](#output\_ecs\_sg\_name) | ECS security group name |
| <a name="output_load_balancer_sg_arn"></a> [load\_balancer\_sg\_arn](#output\_load\_balancer\_sg\_arn) | Load balancer security group ARN |
| <a name="output_load_balancer_sg_id"></a> [load\_balancer\_sg\_id](#output\_load\_balancer\_sg\_id) | Load balancer security group ID |
| <a name="output_load_balancer_sg_name"></a> [load\_balancer\_sg\_name](#output\_load\_balancer\_sg\_name) | Load balancer security group name |
| <a name="output_service_sg_arn"></a> [service\_sg\_arn](#output\_service\_sg\_arn) | ECS security group ARN |
| <a name="output_service_sg_id"></a> [service\_sg\_id](#output\_service\_sg\_id) | ECS security group ID |
| <a name="output_service_sg_name"></a> [service\_sg\_name](#output\_service\_sg\_name) | ECS security group name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
