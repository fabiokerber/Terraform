# Aks
variable "aks_contador" {
  description = "Contador do aks"
  type        = number
}

variable "aks_name" {
  description = "Nome do aks"
  type        = string
}

variable "aks_rg_name" {
  description = "Resource group do Cluster AKS"
  type        = string
}

variable "aks_kubernetes_version" {
  description = "Versão kubernetes do aks"
  type        = string
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
}

# Diagnostic settings
variable "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  type        = bool
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

# Vnet
variable "aks_vnet_subnet" {
  description = "Vnet e subnet do aks"
  type = object({
    subnet_name  = string
    vnet_name    = string
    vnet_rg_name = string
  })
}

# Azure Container Registry
variable "acr" {
  description = "Azure Container Registry"
  type = object({
    acr_name    = string
    acr_rg_name = string
  })
}

# tags
variable "environment" {
  description = "Subscrição onde o recurso será criado"
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
}