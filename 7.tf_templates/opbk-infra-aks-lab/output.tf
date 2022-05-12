output "aks_rg_name" {
  description = "Resource group do Cluster AKS"
  value       = module.aks.aks_rg_name
}

output "aks_location" {
  description = "Localização do Cluster AKS"
  value       = module.aks.aks_location
}

output "aks_name" {
  description = "Nome do Cluster AKS"
  value       = module.aks.aks_name
}

output "aks_kubernetes_version" {
  description = "Versão kubernetes do aks"
  value       = var.aks_kubernetes_version
}

output "node_count" {
  description = "Quantidade máxima de pod alocadas no default nodepool"
  value       = module.aks.aks_system_node_pool.node_count
}

output "orchestrator_version" {
  description = "Versão do Kubernetes do default nodepool"
  value       = module.aks.aks_system_node_pool.orchestrator_version
}

output "os_disk_size_gb" {
  description = "Tamanho do disco o Systema Operacional do default nodepool"
  value       = module.aks.aks_system_node_pool.os_disk_size_gb
}
output "vm_size" {
  description = "Tamanhos das máquinas virtuais na Azure usadas pelo default nodepool(https://docs.microsoft.com/pt-br/azure/virtual-machines/sizes)"
  value       = module.aks.aks_system_node_pool.vm_size
}

output "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  value       = var.diagsettings_enabled
}
