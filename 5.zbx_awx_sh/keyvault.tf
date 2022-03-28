data "azurerm_key_vault" "key-vault" {
  name                = var.kv_name
  resource_group_name = var.kv_rg
}

data "azurerm_key_vault_secret" "local-admin-password" {
  name         = var.vm_admin_password
  key_vault_id = data.azurerm_key_vault.key-vault.id
}