data "azurerm_subnet" "vnet_pvtend_opbk" {
  count                = var.environment != "do" ? 1 : 0
  provider             = azurerm.shared_services
  name                 = var.sa_vnet_pvtend[var.environment].name
  virtual_network_name = var.sa_vnet_pvtend[var.environment].virtual_network_name
  resource_group_name  = var.sa_vnet_pvtend[var.environment].resource_group_name
}

data "azurerm_subnet" "vnet_pvtend_pltfrma" {
  count                = var.environment == "do" ? 1 : 0
  name                 = var.sa_vnet_pvtend[var.environment].name
  virtual_network_name = var.sa_vnet_pvtend[var.environment].virtual_network_name
  resource_group_name  = var.sa_vnet_pvtend[var.environment].resource_group_name
}

data "azurerm_subnet" "vnet_jumpserver" {
  provider             = azurerm.diti_gerenciamento
  name                 = var.sa_vnet_jumpserver.name
  virtual_network_name = var.sa_vnet_jumpserver.virtual_network_name
  resource_group_name  = var.sa_vnet_jumpserver.resource_group_name
}
