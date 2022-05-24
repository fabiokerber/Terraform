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

variable "contador" {
  description = "Contador do recurso"
  type        = number
  default     = 1
  validation {
    condition     = var.contador > 0
    error_message = "Contador deve ser maior que 0."
  }
}

variable "acr_admin_enabled" {
  description = "acr_admin_enabled"
  type        = bool
  default     = false
}

variable "acr_name" {
  description = "Nome do Azure Container Registry"
  type        = string
}

variable "acr_rg_name" {
  description = "Resource group do Azure Container Registry"
  type        = string
}

variable "acr_location" {
  description = "Localização da Azure Container Registry"
  default     = "brazilsouth"
  type        = string
}

variable "acr_sku_name" {
  description = "Sku do Azure Container Registry"
  default     = "Premium"
  type        = string
}

# Private endpoint tu, ti, th e pr
variable "subresource_name" {
  description = "Tip do recurso para criação de private endpoint"
  type        = string
  default     = "registry"
}

# Log analytics
variable "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  type        = bool
  default     = false
}

variable "diagsettings_logs_category" {
  description = "Categoria de logs do diagnostic settings"
  type        = map(any)
  default = {
    ContainerRegistryLoginEvents      = true
    ContainerRegistryRepositoryEvents = true
  }
}

variable "diagsettings_metric_category" {
  description = "Categoria de métricas do diagnostic settings"
  type        = map(any)
  default = {
    AllMetrics = true
  }
}

variable "diagsettings_retention_days" {
  description = "Nro dias retenção Diagnostic settings"
  type        = number
  default     = 30
}

variable "log_analytics_workspace" {
  description = "Log analytics workspace"
  type = map(object({
    workspace_name    = string
    workspace_rg_name = string
  }))
  default = {
    "tu" = {
      workspace_name    = "la-br-tu-openbanking-infra"
      workspace_rg_name = "defaultresourcegroup-eus"
    }
    "ti" = {
      workspace_name    = "la-br-ti-openbanking-infra"
      workspace_rg_name = "defaultresourcegroup-eus"
    }
    "th" = {
      workspace_name    = "la-br-th-openbanking-infra"
      workspace_rg_name = "defaultresourcegroup-eus"
    }
    "pr" = {
      workspace_name    = "la-br-pr-openbanking-infra"
      workspace_rg_name = "defaultresourcegroup-eus"
    }
    "do" = {
      workspace_name    = "azu-log-do-pltfrma-001"
      workspace_rg_name = "azu-rg-do-pltfrma"
    }
  }
}
