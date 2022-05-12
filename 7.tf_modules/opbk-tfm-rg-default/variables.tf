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

variable "rg_location" {
  description = "Localização onde será criado o resource group"
  type        = string
  default     = "brazilsouth"
}

variable "rg_name" {
  description = "Nome do resource group"
  type        = string
}
