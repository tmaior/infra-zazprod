## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Definições para os security groups a serem criados | <pre>map(object({<br/>    name        = string<br/>    description = string<br/>    ingress_ports = list(object({<br/>      from_port   = number<br/>      to_port     = number<br/>      protocol    = string<br/>      cidr_blocks = list(string)<br/>    }))<br/>    egress_ports = list(object({<br/>      from_port   = number<br/>      to_port     = number<br/>      protocol    = string<br/>      cidr_blocks = list(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | IDs dos security groups criados |
| <a name="output_security_group_names"></a> [security\_group\_names](#output\_security\_group\_names) | Nomes dos security groups criados |

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.75.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Definições para os security groups a serem criados | <pre>map(object({<br/>    name        = string<br/>    description = string<br/>    ingress_ports = list(object({<br/>      description = optional(string)<br/>      from_port   = number<br/>      to_port     = number<br/>      protocol    = string<br/>      cidr_blocks = list(string)<br/>    }))<br/>    egress_ports = list(object({<br/>      from_port   = number<br/>      to_port     = number<br/>      protocol    = string<br/>      cidr_blocks = list(string)<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | IDs dos security groups criados |
| <a name="output_security_group_names"></a> [security\_group\_names](#output\_security\_group\_names) | Nomes dos security groups criados |
<!-- END_TF_DOCS -->