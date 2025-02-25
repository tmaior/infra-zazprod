
variable "frontend_tg_arn" {
  description = "The ARN of Frontend Target Group"
  type = string
}

variable "backend_tg_arn" {
  description = "The ARN of Backend Target Group"
  type = string
}

variable "app_tg_arn" {
  description = "ARN do target group do serviço app"
  type        = string
  default     = ""
}

variable "humanizer_tg_arn" {
  description = "ARN do target group do serviço wds-humanizer"
  type        = string
  default     = ""
}

variable "https_listener_arn" {
  type = string
  description = "ARN do listener HTTPS"
}



/*variable "cronjob_tg_arn" {
   type = string
   description = "The ARN of cronjob Target Group"
 }*/




