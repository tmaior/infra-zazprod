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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.http](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | The ARN of the SSL certificate | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The prefix for all resources | `string` | n/a | yes |
| <a name="input_security_groups_id"></a> [security\_groups\_id](#input\_security\_groups\_id) | value of security group id | `list(string)` | n/a | yes |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | The SSL policy | `string` | `"ELBSecurityPolicy-TLS-1-2-Ext-2018-06"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | The environment for all resources | `string` | n/a | yes |
| <a name="input_subnets_id"></a> [subnets\_id](#input\_subnets\_id) | value of subnets id | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | value of vpc id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_listerner_http_arn"></a> [listerner\_http\_arn](#output\_listerner\_http\_arn) | The ARN of the HTTP listener |
| <a name="output_listerner_https_arn"></a> [listerner\_https\_arn](#output\_listerner\_https\_arn) | The ARN of the HTTPS listener |
| <a name="output_name"></a> [name](#output\_name) | The name of the load balancer |
| <a name="output_target_group"></a> [target\_group](#output\_target\_group) | The ARN of the target group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
