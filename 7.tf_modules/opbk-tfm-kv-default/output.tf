# Lock
output "lock_level" {
  description = "Resource lock level (CanNotDelete/ReadOnly)"
  value       = var.lock_level
}

output "lock_enabled" {
  description = "Habilitar resource lock?"
  value       = var.lock_enabled
}

# Key vault
output "kv_resource_group_name" {
  description = "Resource group do Key Vault"
  value       = var.kv_resource_group_name
}

output "kv_location" {
  description = "Localização do key vault"
  value       = var.kv_location
}

output "kv_namespace" {
  description = "Namespace do Key Vault"
  value       = var.kv_namespace
}

output "kv_camada" {
  description = "Camada do Key Vault"
  value       = var.kv_camada
}

output "kv_contador" {
  description = "Contador do Key Vault"
  value       = var.kv_contador
}

output "kv_name" {
  description = "Nome do Key Vault"
  value       = local.kv_name
}

# output "aks_access_kv" {
#   description = "Aks com acesso ao Key vault"
#   value       = var.aks_access_kv
# }

# output "apim_access_kv" {
#   description = "API Management com acesso ao Key vault"
#   value       = var.apim_access_kv
# }

output "resources_access_kv" {
  description = "Recursos com acesso ao key vault"
  value       = var.resources_access_kv
}

output "owner_access_kv" {
  description = "Owner do Key vault em tu e ti"
  value       = var.owner_access_kv
}

output "group_owner_access_kv" {
  description = "Group owner do Key vault em tu e ti"
  value       = var.group_owner_access_kv
}

output "secrets" {
  description = "Secrets do key vault"
  value       = var.secrets
  sensitive   = true
}

output "secrets_name" {
  description = "Nome das secrets do key vault"
  value       = [for secret in azurerm_key_vault_secret.keyvault_secrets : secret.name]
}

# Diagnostic settings
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
