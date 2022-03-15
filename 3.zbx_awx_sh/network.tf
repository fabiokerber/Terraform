data "azurerm_subnet" "subnet" {
  # the subnet is imported only enable_vnet_integration is true
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_resource_group_name
}

# Create network interface
resource "azurerm_network_interface" "network-interface" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource-group.name

  ip_configuration {
    name                          = var.nic_configuration_name # "vm-linux-nic-configuration"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
  }