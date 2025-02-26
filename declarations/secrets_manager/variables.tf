variable "secrets" {
  type = map(object({
    name = string
    description = optional(string, "Descrição padrão para a secret")
  }))
  description = "Map of mobile secrets with their corresponding names and tags"
}