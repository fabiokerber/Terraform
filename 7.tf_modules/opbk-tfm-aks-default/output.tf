# Azure Container Registry
output "aks_contador" {
  description = "Contador do aks"
  value       = var.aks_contador
}

output "aks_name" {
  description = "Nome do aks"
  value       = azurerm_kubernetes_cluster.cluster.name
}

output "aks_rg_name" {
  value       = var.aks_rg_name
  description = "Resource group do Cluster AKS"

}

output "aks_location" {
  description = "Localização da Azure Cluster AKS"
  value       = var.aks_location
}

output "aks_sku_name" {
  description = "Sku do Cluster AKS"
  value       = var.sku_name
}

output "aks_kubernetes_version" {
  description = "Versão kubernetes do aks"
  value       = var.aks_kubernetes_version
}

output "aks_network_profile" {
  description = "Aks network profile"
  value       = var.aks_network_profile
}

output "aks_system_node_pool" {
  description = "Propriedades do aks system node pool"
  value       = var.aks_system_node_pool
}

output "aks_oms_agent" {
  description = "Habilita agente para Log Analytics no Cluster AKS"
  value       = var.aks_oms_agent
}

output "pod_security_policy" {
  description = "Habilita políticas de segurança de pod padrão no Cluster AKS"
  value       = var.pod_security_policy
}

output "aks_node_pool" {
  description = "Propriedades do aks node pool"
  value       = var.aks_node_pool
}

# vnet e subnet
output "aks_vnet_subnet" {
  description = "Vnet e subnet do aks"
  value       = var.aks_vnet_subnet
}

# Diagnostic Settings 
output "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  value       = var.diagsettings_enabled
}

output "diagsettings_retention_days" {
  description = "Número dias de retenção no diagnostic settings"
  value       = var.diagsettings_retention_days
}

output "log_analytics_workspace" {
  description = "Log analytics workspace"
  value       = var.log_analytics_workspace
}

# ACR
output "acr" {
  description = "Azure Container Registry"
  value       = var.acr
}
