data "azurerm_key_vault" "key-vault" {
  name                = var.kv_name
  resource_group_name = var.kv_rg
}