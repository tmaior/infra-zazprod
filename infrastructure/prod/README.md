<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.48.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.48.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_add_certificates"></a> [add\_certificates](#module\_add\_certificates) | ./certificates/add_cert | n/a |
| <a name="module_codepipeline_backend"></a> [codepipeline\_backend](#module\_codepipeline\_backend) | ../modules/codepipeline | n/a |
| <a name="module_codepipeline_data_importer"></a> [codepipeline\_data\_importer](#module\_codepipeline\_data\_importer) | ../modules/codepipeline | n/a |
| <a name="module_codepipeline_frontend"></a> [codepipeline\_frontend](#module\_codepipeline\_frontend) | ../modules/codepipeline | n/a |
| <a name="module_documentdb"></a> [documentdb](#module\_documentdb) | ../modules/documentdb | n/a |
| <a name="module_documentdb_staging"></a> [documentdb\_staging](#module\_documentdb\_staging) | ../modules/documentdb | n/a |
| <a name="module_ecr_backend"></a> [ecr\_backend](#module\_ecr\_backend) | ../modules/ecr | n/a |
| <a name="module_ecr_data_importer"></a> [ecr\_data\_importer](#module\_ecr\_data\_importer) | ../modules/ecr | n/a |
| <a name="module_ecr_frontend"></a> [ecr\_frontend](#module\_ecr\_frontend) | ../modules/ecr | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../modules/ecs | n/a |
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ../modules/firewall | n/a |
| <a name="module_https_listener_rules"></a> [https\_listener\_rules](#module\_https\_listener\_rules) | ../modules/listeners_rules | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ../modules/load_balancer | n/a |
| <a name="module_scaling"></a> [scaling](#module\_scaling) | ../modules/scaling | n/a |
| <a name="module_service"></a> [service](#module\_service) | ../modules/service | n/a |
| <a name="module_service_data_importer"></a> [service\_data\_importer](#module\_service\_data\_importer) | ../modules/service | n/a |
| <a name="module_service_frontend"></a> [service\_frontend](#module\_service\_frontend) | ../modules/service | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/5.48.0/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | Public key for the instance | `string` | `"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCx9yd+QfeonSljZqJf1Luq+6qxHIt0LOWiEmidXpmgnRZF1d63RCj6DpCrnTTi7CSuLFoCja+K/ie061vbZbLg4o3Ng7rJzftHP/gWRr4/S1pOUeHEGVH3QA1QLI5KAKlP26A85+jCkCMpjiZd0FbsHG5BOOERflrmlSFAwq5gy8krgvd6KbqqUW0gFuTnkyIU4HWqoSDKnzuXfYNNu90Vh1T9g8u519PVUqe06cJpDgReyp4WiKCqUgyeVuGu2/86up15EuDx/DbtpcpYCf75v4CRj3q6dYOxZ6u6smSj68NqCclWN1Ig1hRgHi07tWDays7ATrltAkSXj711T0ueqBPDbfSpBzQSxF2XpAclhbsMPeVf1CrMMHN51HJTuF8jywGVF1UhkdEKtBOvOeoMcYFX0W5+wHD7l5Hq9X6YipriVojn+l6rmcqDbamTm5NNRcS3k2EN46i2Zffp+dp0HaJ1+sLwMHUbcRg6MNJFmyo/yjv8hjMsXy6DdxX0qTHdieYWd2C4n+kmUzUkCjwOCyi7MU41vn4XGMJsjDJTn7lCVzbIOda7QMAQQfS2LKKzePQM55St7yJ3WLvX1BbtBwqDZGzWPdypy8b/tGM7zaJ1xZRQ+S04GMjAJg7FZ0qAVDoLTQQXhlo4Bm4DyKW0ya76g7P9FTNPBpnE/MQHmw=="` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
