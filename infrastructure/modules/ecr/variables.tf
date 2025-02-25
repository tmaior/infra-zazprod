#===============================================================================
# GENERAL
#===============================================================================
variable "repository_name" {
  description = "ECR repository name"
  type        = string  
  default     = "walterwrites-image-repository"
}
variable "scan_on_push" {
  description = "Images scanning enabling while pushing updates"
  type        = bool 
  default     = true 
}
variable "image_tag_mutability" {
  description = "Defines if image tags are gonna be MUTABLE or IMMUTABLE"
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    
  } 
}
