# Aks access
data "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.resources_access_kv["aks"]
  name                = each.key
  resource_group_name = each.value
}

# Se aks SystemAssigned -> adiciona o aks no key vault
# Se aks UserAssigned -> aciona o aks agent pool no key vault
resource "azurerm_key_vault_access_policy" "aks_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.group_owner_access_kv]
  for_each                = var.resources_access_kv["aks"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_kubernetes_cluster.aks[each.key].identity[0].principal_id != "" ? data.azurerm_kubernetes_cluster.aks[each.key].identity[0].principal_id : data.azurerm_kubernetes_cluster.aks[each.key].kubelet_identity[0].object_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}

# Function access
data "azurerm_function_app" "function" {
  for_each            = var.resources_access_kv["function"]
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault_access_policy" "function_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.aks_access_kv]
  for_each                = var.resources_access_kv["function"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_function_app.function[each.key].identity[0].principal_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}

# Vm access
data "azurerm_virtual_machine" "vm" {
  for_each            = var.resources_access_kv["vm"]
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault_access_policy" "vm_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.function_access_kv]
  for_each                = var.resources_access_kv["vm"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_virtual_machine.vm[each.key].identity[0].principal_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}

# Vmss access
data "azurerm_virtual_machine_scale_set" "vmss" {
  for_each            = var.resources_access_kv["vmss"]
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault_access_policy" "vmss_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.vm_access_kv]
  for_each                = var.resources_access_kv["vmss"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_virtual_machine_scale_set.vmss[each.key].identity[0].principal_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}

# webapp access
data "azurerm_app_service" "webapp" {
  for_each            = var.resources_access_kv["webapp"]
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault_access_policy" "webapp_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.vmss_access_kv]
  for_each                = var.resources_access_kv["webapp"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_app_service.webapp[each.key].identity[0].principal_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}

# Synapse access
data "azurerm_synapse_workspace" "synapse" {
  for_each            = var.resources_access_kv["synapse"]
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault_access_policy" "synapse_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.webapp_access_kv]
  for_each                = var.resources_access_kv["synapse"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_synapse_workspace.synapse[each.key].identity[0].principal_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}

# Apim access
data "azurerm_api_management" "apim" {
  for_each            = var.resources_access_kv["apim"]
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault_access_policy" "apim_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.synapse_access_kv]
  for_each                = var.resources_access_kv["apim"]
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = data.azurerm_api_management.apim[each.key].identity[0].principal_id
  key_permissions         = var.resource_key_permission
  secret_permissions      = var.resource_secret_permission
  certificate_permissions = var.resource_certificate_permission
}
