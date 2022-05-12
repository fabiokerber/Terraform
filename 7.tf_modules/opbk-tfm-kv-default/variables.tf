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

variable "kv_location" {
  description = "Localização do key vault"
  type        = string
  default     = "brazilsouth"
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
  default     = 1
  validation {
    condition     = var.kv_contador > 0
    error_message = "Contador deve ser maior que 0."
  }
}

variable "sku_name" {
  description = "sku_name"
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "soft_delete_retention_days"
  type        = string
  default     = 30
}

variable "purge_protection_enabled" {
  description = "Enable purge protection on tu, ti, th e do?"
  type        = string
  default     = false
}

variable "purge_protection_pr_enabled" {
  description = "Enable purge protection on pr?"
  type        = string
  default     = true
}

variable "group_owner" {
  description = "Grupos com acesso ao key vault"
  type        = list(any)
  default     = ["GD4253_DS_AZ", "GD4250_SEGURANCA_IMP_AZ", "GD4250_SEGURANCA_ACESSOS_AZ"]
}

variable "owner_access_kv" {
  description = "Owner do Key vault em tu e ti"
  type        = list(string)
  default     = []
}

variable "group_owner_access_kv" {
  description = "Group owner do Key vault em tu e ti"
  type        = list(string)
  default     = []
}

variable "key_permissions" {
  description = "Permissões de keys"
  type        = list(any)
  default     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge"]
}

variable "secret_permissions" {
  description = "Permissões de secrets"
  type        = list(any)
  default     = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
}

variable "certificate_permissions" {
  description = "Permissões de certificados"
  type        = list(any)
  default     = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"]
}

variable "sp_secret_permissions" {
  description = "Permissões do service principal que é responsável pela gestão das secrets"
  type        = list(string)
  default     = ["Get", "Set", "Delete", "Recover", "Purge"]
}

# Azure resource access kv
# variable "aks_access_kv" {
#   description = "Aks com permissão de acessar o keyvault"
#   type        = map(any)
# }

# variable "apim_access_kv" {
#   description = "Apim com permissão de acessar o keyvault"
#   type        = map(any)
# }

variable "resources_access_kv" {
  description = "Recursos com acesso ao key vault"
  type        = map(map(string))
}

variable "resource_key_permission" {
  description = "Permissão para os recursos acessarem keys"
  type        = list(string)
  default     = ["Get"]
}

variable "resource_secret_permission" {
  description = "Permissãp para os recursos acessarem secrets"
  type        = list(string)
  default     = ["Get"]
}

variable "resource_certificate_permission" {
  description = "Permissão para os recursos acessarem certificados"
  type        = list(string)
  default     = ["Get"]
}

# Secrets
variable "secrets" {
  description = "secrets"
  type        = map(any)
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
    AuditEvent                   = true
    AzurePolicyEvaluationDetails = false
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

# Virtual networks
variable "kv_default_action" {
  description = "default_action"
  type        = string
  default     = "Deny"
}

variable "sa_vnet_pvtend" {
  description = "SA virtual network"
  type = map(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
  }))
  default = {
    "tu" = {
      name                 = "tu-pvtend-subnet"
      virtual_network_name = "pvtend-vnet"
      resource_group_name  = "pvtend-vnet-rg"
    }
    "ti" = {
      name                 = "ti-pvtend-subnet"
      virtual_network_name = "pvtend-vnet"
      resource_group_name  = "pvtend-vnet-rg"
    }
    "th" = {
      name                 = "th-pvtend-subnet"
      virtual_network_name = "pvtend-vnet"
      resource_group_name  = "pvtend-vnet-rg"
    }
    "pr" = {
      name                 = "pr-pvtend-subnet"
      virtual_network_name = "pvtend-vnet"
      resource_group_name  = "pvtend-vnet-rg"
    }
    "do" = {
      name                 = "devops-pvtend"
      virtual_network_name = "devops-vnet"
      resource_group_name  = "azu-rg-do-vnet-devops"
    }
  }
}

variable "sa_vnet_jumpserver" {
  description = "Virtual network jump server"
  type = object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
  })
  default = {
    name                 = "jumper-subnet"
    virtual_network_name = "GERENCIAMENTO-VNET"
    resource_group_name  = "GERENCIAMENTO-VNET-RG"
  }
}

# Private endpoint
variable "subresource_name" {
  description = "Tip do recurso para criação de private endpoint"
  type        = string
  default     = "vault"
}
