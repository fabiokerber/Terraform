# Aks
variable "aks_contador" {
  description = "Contador do aks"
  type        = number
  default     = 1
  validation {
    condition     = var.aks_contador > 0
    error_message = "Contador deve ser maior que 0."
  }
}

variable "aks_name" {
  description = "Nome do aks"
  type        = string
}

variable "aks_rg_name" {
  description = "Resource group do Cluster AKS"
  type        = string
}
variable "aks_location" {
  description = "Localização do Cluster AKS"
  type        = string
  default     = "brazilsouth"
}

variable "sku_name" {
  description = "Sku do Cluster AKS"
  type        = string
  default     = "Free"
}

variable "aks_kubernetes_version" {
  description = "Versão kubernetes do aks"
  type        = string
  default     = "1.22.6"
}

variable "aks_network_profile" {
  description = "Aks network profile"
  type = object({
    network_plugin     = string
    network_policy     = string
    load_balancer_sku  = string
    dns_service_ip     = string
    service_cidr       = string
    docker_bridge_cidr = string
    outbound_type      = string
  })
  default = {
    dns_service_ip     = "192.2.0.10"
    docker_bridge_cidr = "172.1.0.1/16"
    load_balancer_sku  = "standard"
    network_plugin     = "azure"
    network_policy     = "azure"
    outbound_type      = "userDefinedRouting"
    service_cidr       = "192.2.0.0/22"
  }
}

variable "aks_system_node_pool" {
  description = "Propriedades do aks system node pool"
  type = object({
    enable_auto_scaling    = bool
    enable_host_encryption = bool
    enable_node_public_ip  = bool
    max_pods               = number
    name                   = string
    node_count             = number
    max_count              = number
    min_count              = number
    orchestrator_version   = string
    os_disk_size_gb        = number
    os_disk_type           = string
    type                   = string
    vm_size                = string
  })
  default = {
    enable_auto_scaling    = false
    enable_host_encryption = false
    enable_node_public_ip  = false
    max_pods               = 30
    name                   = "systempool"
    node_count             = 1
    max_count              = 4
    min_count              = 1
    orchestrator_version   = "1.22.6"
    os_disk_size_gb        = 128
    os_disk_type           = "Managed"
    type                   = "VirtualMachineScaleSets"
    vm_size                = "Standard_F2s_v2"
  }
}

variable "aks_vnet_subnet" {
  description = "Vnet e subnet do aks"
  type = object({
    subnet_name  = string
    vnet_name    = string
    vnet_rg_name = string
  })
  default = {
    subnet_name  = "AKSTerraform"
    vnet_name    = "tu-vnet-teste-terraform"
    vnet_rg_name = "tu-vnet-rg"
  }
}

variable "aks_rbac_control" {
  description = "Habilita funcionalidade de RBAC (Role Based Access Control) no Cluster AKS"
  type        = bool
  default     = true
}

variable "aks_azure_policy" {
  description = "Habilita recurso da Azure Policy no Addon Profile do Cluster AKS"
  type        = bool
  default     = true
}

variable "aks_oms_agent" {
  description = "Habilita agente para Log Analytics no Cluster AKS"
  type        = bool
  default     = true
}

variable "identity_type" {
  description = "Tipo de identidade usada para adminstração do Cluster AKS (SystemAssigned|Service Principal)"
  default     = "SystemAssigned"
  type        = string
}

variable "pod_security_policy" {
  description = "Habilita políticas de segurança de pod padrão no Cluster AKS"
  type        = bool
  default     = false
}

variable "aks_private_cluster" {
  description = "Habilita funcionalidade de Private Cluster no Cluster AKS"
  type        = bool
  default     = true
}

# Node pools
variable "aks_node_pool" {
  description = "Propriedades do aks node pool"
  type = map(object({
    name                   = string
    vm_size                = string
    node_count             = number
    enable_auto_scaling    = bool
    enable_host_encryption = bool
    enable_node_public_ip  = bool
    max_pods               = number
    max_count              = number
    min_count              = number
    orchestrator_version   = string
    os_disk_size_gb        = number
    os_disk_type           = string
    mode                   = string
  }))
}

# Log analytics
variable "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  type        = bool
}

variable "diagsettings_log_category" {
  description = "Categoria de logs do diagnostic settings"
  type        = map(any)
  default = {
    kube-apiserver           = true
    kube-audit               = true
    kube-audit-admin         = false
    kube-controller-manager  = true
    "kube-scheduler"         = true
    cluster-autoscaler       = true
    guard                    = false
    cloud-controller-manager = false
    csi-azuredisk-controller = false
    csi-azurefile-controller = false
    csi-snapshot-controller  = false
  }
}

variable "diagsettings_metric_category" {
  description = "Categoria de logs do diagnostic settings"
  type        = map(any)
  default = {
    AllMetrics = true
  }
}

variable "diagsettings_retention_days" {
  description = "Número dias de retenção no diagnostic settings"
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

# Azure Container Registry
variable "acr" {
  description = "Azure Container Registry"
  type = object({
    acr_name    = string
    acr_rg_name = string
  })
  default = {
    acr_name    = ""
    acr_rg_name = ""
  }
}

variable "acr_role_definition_name" {
  description = "Acr role definition name"
  type        = string
  default     = "AcrPull"
}
