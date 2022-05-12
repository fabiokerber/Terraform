# Lock
output "lock_level" {
  description = "Resource lock level (CanNotDelete/ReadOnly)"
  value       = var.lock_level
}

output "lock_enabled" {
  description = "Habilitar resource lock?"
  value       = var.lock_enabled
}

# Azure Container Registry
output "contador" {
  description = "Contador do Recurso"
  value       = var.contador
}

output "acr_name" {
  value       = local.acr_name
  description = "Nome do Azure Container Registry"
}

output "acr_rg_name" {
  value       = var.acr_rg_name
  description = "Resource group do Azure Container Registry"
}

output "acr_location" {
  description = "Localização da Azure Container Registry"
  value       = var.acr_location
}

output "acr_sku_name" {
  description = "Sku do Azure Container Registry"
  value       = var.acr_sku_name
}

output "acr_admin_enabled" {
  description = "Azure Container Registry admin enabled"
  value       = var.acr_admin_enabled
}

#Diagnostic Settings 
output "diagsettings_enabled" {
  description = "Diagnostic settings habilitado?"
  value       = var.diagsettings_enabled
}

output "diagsettings_retention_days" {
  description = "Nro dias retenção Diagnostic settings"
  value       = var.diagsettings_retention_days
}

output "log_analytics_workspace" {
  description = "Log analytics workspace"
  value       = var.log_analytics_workspace
}
