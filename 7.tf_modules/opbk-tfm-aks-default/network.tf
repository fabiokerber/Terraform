data "azurerm_subscription" "current" {}

data "azurerm_subnet" "subnet" {
  count                = var.aks_vnet_subnet.subnet_name != "" && var.aks_vnet_subnet.vnet_name != "" && var.aks_vnet_subnet.vnet_rg_name != "" ? 1 : 0
  name                 = var.aks_vnet_subnet.subnet_name
  virtual_network_name = var.aks_vnet_subnet.vnet_name
  resource_group_name  = var.aks_vnet_subnet.vnet_rg_name
}

data "azurerm_virtual_network" "vnet" {
  count               = var.aks_vnet_subnet.subnet_name != "" && var.aks_vnet_subnet.vnet_name != "" && var.aks_vnet_subnet.vnet_rg_name != "" ? 1 : 0
  name                = var.aks_vnet_subnet.vnet_name
  resource_group_name = var.aks_vnet_subnet.vnet_rg_name
}

data "azurerm_virtual_network" "linktoidnprod" {
  name                = "identity-nprod-vnet"
  resource_group_name = "identitynprod-vnet-rg"
  provider            = azurerm.diti_identity
}

data "azurerm_virtual_network" "linktoidprod" {
  name                = "identity-prod-vnet"
  resource_group_name = "identityprod-vnet-rg"
  provider            = azurerm.diti_identity
}

resource "azurerm_resource_group" "iac_rg" {
  name     = local.iac_rg_name
  location = var.aks_location
  tags     = module.tags.tags
}

resource "azurerm_user_assigned_identity" "pvtdnszone" {
  name                = local.pvtdnszone_name
  resource_group_name = azurerm_resource_group.iac_rg.name
  location            = azurerm_resource_group.iac_rg.location
  tags                = module.tags.tags
}

resource "azurerm_role_assignment" "pvtdnszone" {
  scope                = azurerm_resource_group.iac_rg.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.pvtdnszone.principal_id
}

resource "azurerm_role_assignment" "vnet" {
  scope                = data.azurerm_virtual_network.vnet[0].id
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.pvtdnszone.principal_id
}

resource "azurerm_role_assignment" "sub" {
  scope                = local.sub_name
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.pvtdnszone.principal_id
}

resource "azurerm_role_assignment" "aks_user_assigned" {
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  scope                = local.aks_user_assigned
  role_definition_name = "Contributor"
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = local.private_dns_zone_name
  #name                = "${random_uuid.private_dns_zone_name.result}.privatelink.brazilsouth.azmk8s.io"
  resource_group_name = azurerm_resource_group.iac_rg.name
  tags                = module.tags.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnetlinknprod" {
  name                  = "linktoidnprod"
  resource_group_name   = azurerm_resource_group.iac_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.linktoidnprod.id
  tags                  = module.tags.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnetlinkprod" {
  name                  = "linktoidprod"
  resource_group_name   = azurerm_resource_group.iac_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.linktoidprod.id
  tags                  = module.tags.tags
}
