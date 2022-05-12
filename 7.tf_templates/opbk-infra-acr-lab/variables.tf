# Lock
variable "lock_level" {
  description = "Resource lock level (CanNotDelete/ReadOnly)"
  type        = list(string)
  default     = ["CanNotDelete", "ReadOnly"]
}

variable "lock_enabled" {
  description = "Habilitar resource lock?"
  type        = bool
  default     = false
}

variable "contador" {
  description = "Contador do Azure Container Registry"
  type        = number
}

variable "acr_name" {
  description = "Nome do Azure Container Registry"
  type        = string
}

variable "acr_rg_name" {
  description = "Resource group do Azure Container Registry"
  type        = string
}

# Log analytics
variable "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  type        = bool
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

variable "repositorio" {
  description = "Repositório do código da infraestrutura"
  type        = string
  default     = ""
}

variable "backend_sa" {
  description = "Backend do tf state file"
  type        = string
  default     = ""
}

variable "backend_key" {
  description = "Nome do tf state file"
  type        = string
  default     = ""
}

variable "tags_custom" {
  description = "Tags customizadas"
  type        = map(any)
  default     = {}
}