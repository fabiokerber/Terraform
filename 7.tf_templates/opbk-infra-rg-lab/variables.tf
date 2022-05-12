# Lock
variable "lock_level" {
  description = "Resource lock level (CanNotDelete/ReadOnly)"
  type        = list(string)
  default     = ["CanNotDelete"]
}

variable "lock_enabled" {
  description = "Habilitar resource lock?"
  type        = bool
  default     = false
}

# Resource group
variable "rg_name" {
  description = "Nome do resource group"
  type        = string
}

# Tags
variable "environment" {
  description = "Subscription que o recurso será criado"
  type        = string
}

variable "objective" {
  description = "Objetivo do sistema/recurso"
  type        = string
}

variable "owner" {
  description = "Responsável pelo sistema/recurso"
  type        = string
}

variable "system" {
  description = "Sistema"
  type        = string
}

variable "tags_custom" {
  description = "Tags customizadas"
  type        = map(any)
  default     = {}
}
