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

# Key vault
variable "kv_resource_group_name" {
  description = "Resource group do key vault"
  type        = string
}

variable "kv_namespace" {
  description = "Namespace do Key Vault"
  type        = string
}

variable "kv_camada" {
  description = "Camada do Key Vault"
  type        = string
}

variable "kv_contador" {
  description = "Contador do Key Vault"
  type        = number
}

variable "secrets" {
  description = "secrets"
  type        = map(any)
}

variable "resources_access_kv" {
  description = "Recursos com acesso ao key vault"
  type        = map(map(string))
}

variable "group_owner_access_kv" {
  description = "Group owner do Key vault em tu e ti"
  type        = list(any)
}

# Log analytics
variable "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  type        = bool
}

# Tags
variable "environment" {
  description = "Subscrição onde o recurso será criado"
  type        = string
}

variable "system" {
  description = "Sistema"
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

variable "tags_custom" {
  description = "Tags customizadas"
  type        = map(any)
  default     = {}
}