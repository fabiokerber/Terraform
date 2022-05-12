resource "azurerm_resource_group" "resource_group" {
  name     = local.rg_name
  location = var.rg_location

  lifecycle {
    prevent_destroy = false
  }

  tags = module.tags.tags
}
