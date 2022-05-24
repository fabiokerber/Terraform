resource "azurerm_container_registry" "acr" {
  name                          = local.acr_name
  location                      = var.acr_location
  resource_group_name           = var.acr_rg_name
  sku                           = var.acr_sku_name
  admin_enabled                 = var.acr_admin_enabled
  public_network_access_enabled = false
  tags                          = module.tags.tags
}