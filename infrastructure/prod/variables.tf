variable "public_key" {
  description = "Public key for the instance"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCx9yd+QfeonSljZqJf1Luq+6qxHIt0LOWiEmidXpmgnRZF1d63RCj6DpCrnTTi7CSuLFoCja+K/ie061vbZbLg4o3Ng7rJzftHP/gWRr4/S1pOUeHEGVH3QA1QLI5KAKlP26A85+jCkCMpjiZd0FbsHG5BOOERflrmlSFAwq5gy8krgvd6KbqqUW0gFuTnkyIU4HWqoSDKnzuXfYNNu90Vh1T9g8u519PVUqe06cJpDgReyp4WiKCqUgyeVuGu2/86up15EuDx/DbtpcpYCf75v4CRj3q6dYOxZ6u6smSj68NqCclWN1Ig1hRgHi07tWDays7ATrltAkSXj711T0ueqBPDbfSpBzQSxF2XpAclhbsMPeVf1CrMMHN51HJTuF8jywGVF1UhkdEKtBOvOeoMcYFX0W5+wHD7l5Hq9X6YipriVojn+l6rmcqDbamTm5NNRcS3k2EN46i2Zffp+dp0HaJ1+sLwMHUbcRg6MNJFmyo/yjv8hjMsXy6DdxX0qTHdieYWd2C4n+kmUzUkCjwOCyi7MU41vn4XGMJsjDJTn7lCVzbIOda7QMAQQfS2LKKzePQM55St7yJ3WLvX1BbtBwqDZGzWPdypy8b/tGM7zaJ1xZRQ+S04GMjAJg7FZ0qAVDoLTQQXhlo4Bm4DyKW0ya76g7P9FTNPBpnE/MQHmw=="
}

variable "key_name" {
  description = "The name of the key pair to create"
  type        = string
  default     = "myordering-key"
}

variable "repository_branches" {
  description = "Map of service names to their repository branches"
  type        = map(string)
  default = {
    backend  = "prod-new"
    frontend = "prod-new"
  }
}
variable "container_image" {
  description = "URL da imagem do container para o módulo service"
  type        = string
  default     = "latest"
}

variable "frontend_hash" {
  description = "Hash da imagem do frontend"
  type        = string
  default     = "latest"
}

variable "backend_hash" {
  description = "Hash da imagem do backend"
  type        = string
  default     = "latest"
}

variable "app_hash" {
  description = "Hash da imagem do app"
  type        = string
  default     = "latest"
}

variable "humanizer_hash" {
  description = "Hash da imagem do wds-humanizer"
  type        = string
  default     = "latest"
}

variable "ecs_service_names" {
  description = "Names of ECS services"
  type        = map(string)
  default = {
    "backend"  = "backend-service"
    "frontend" = "frontend-service"
  }
}

variable "service_name" {
  description = "The cluster main service name"
  type        = string
  default     = "walter"
}

variable "cloudflare_api_token" {
  description = "API token for Cloudflare"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID for Cloudflare"
  type        = string
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "scan_on_push" {
  description = "Whether to scan images on push"
  type        = bool
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type        = string
}

variable "create_route53_zone" {
  type    = bool
  default = false
}

variable "existing_zone_id" {
  type    = string
  default = null
}

variable "domain_name" {
  type = string
}

variable "hosted_zone_id" {
  description = "ID da zona hospedada no Route 53"
  type        = string
  default     = null
}