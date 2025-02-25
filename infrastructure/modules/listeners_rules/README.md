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
| [aws_lb_listener_rule.back](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.data_importer](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.front](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_tg_arn"></a> [backend\_tg\_arn](#input\_backend\_tg\_arn) | The ARN of Backend Target Group | `string` | n/a | yes |
| <a name="input_data_import_tg_arn"></a> [data\_import\_tg\_arn](#input\_data\_import\_tg\_arn) | The ARN of data importer Target Group | `string` | n/a | yes |
| <a name="input_frontend_tg_arn"></a> [frontend\_tg\_arn](#input\_frontend\_tg\_arn) | The ARN of Frontend Target Group | `string` | n/a | yes |
| <a name="input_listerner_arn"></a> [listerner\_arn](#input\_listerner\_arn) | The ARN of Listener | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
