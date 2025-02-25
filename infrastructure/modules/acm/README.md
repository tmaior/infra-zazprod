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
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/acm_certificate) | resource |
| [aws_lb_listener_certificate.https](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/resources/lb_listener_certificate) | resource |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/acm_certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domains"></a> [domains](#input\_domains) | The domain that can be used in certificate, accepts wildcards | `list(string)` | `null` | no |
| <a name="input_exists"></a> [exists](#input\_exists) | Must be true if the certificate already exist in the system | `bool` | `false` | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | The HTTPS listener arn | `string` | n/a | yes |
| <a name="input_most_recent"></a> [most\_recent](#input\_most\_recent) | Fetch the most recent certificate | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the certificate. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the certificate. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
