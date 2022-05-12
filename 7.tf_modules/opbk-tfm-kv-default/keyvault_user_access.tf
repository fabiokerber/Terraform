data "azurerm_client_config" "current" {}

# Security team group access
data "azuread_group" "group_owner" {
  count            = length(local.group_owner)
  display_name     = element(local.group_owner, count.index)
  security_enabled = true
}

resource "azurerm_key_vault_access_policy" "group_owner_kv" {
  count                   = length(local.group_owner)
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = element(data.azuread_group.group_owner.*.object_id, count.index)
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}

# Users access
data "azuread_user" "user_owner" {
  count               = length(var.owner_access_kv)
  user_principal_name = element(var.owner_access_kv, count.index)
}

resource "azurerm_key_vault_access_policy" "owner_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.group_owner_kv]
  count                   = contains(["tu", "ti", "do"], var.environment) ? length(var.owner_access_kv) : 0
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = element(data.azuread_user.user_owner.*.object_id, count.index)
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}

# Group access
data "azuread_group" "group_owner_access_kv" {
  count            = length(var.group_owner_access_kv)
  display_name     = element(var.group_owner_access_kv, count.index)
  security_enabled = true
}

resource "azurerm_key_vault_access_policy" "group_owner_access_kv" {
  depends_on              = [azurerm_key_vault_access_policy.owner_access_kv]
  count                   = contains(["tu", "ti", "do"], var.environment) ? length(var.group_owner_access_kv) : 0
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = element(data.azuread_group.group_owner_access_kv.*.object_id, count.index)
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}