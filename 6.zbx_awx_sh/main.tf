provider "azurerm" {
  features {
  }
}

# Key Vault
resource "random_string" "password" {
  length      = 14
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}

resource "azurerm_key_vault_secret" "vm_secret" {
  name         = "${var.vm_name}-admin-password"
  value        = "${random_string.password.result}"
  key_vault_id = data.azurerm_key_vault.key-vault.id
}

# Custom image
data "azurerm_image" "search" {
  name                = var.image_name
  resource_group_name = var.image_rg
}

# Resource Groups
resource "azurerm_resource_group" "resource-group" {
  name     = var.resource_name
  location = var.location
}

resource "azurerm_resource_group" "vm_resource-group" {
  name     = var.vm_resource_name
  location = var.location
}

# Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_name
  depends_on          = [azurerm_resource_group.resource-group]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_public_ip" "public_ip" {
  name                    = var.public_ip_name
  location                = var.location
  resource_group_name     = var.vm_resource_name
  allocation_method       = var.allocation_method
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.domain_name_label
  depends_on              = [azurerm_resource_group.vm_resource-group]
}

resource "azurerm_network_interface" "nic" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.vm_resource_name

  ip_configuration {
    name                          = var.public_ip_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
  depends_on = [azurerm_resource_group.vm_resource-group]
}

# Security
resource "azurerm_network_security_group" "nsg" {
  name                = var.security_group_name
  location            = var.location
  resource_group_name = var.resource_name
  depends_on          = [azurerm_resource_group.resource-group]
}

resource "azurerm_network_security_rule" "inbound_rules" {
  for_each                    = var.inbound_rules
  resource_group_name         = var.resource_name
  name                        = "inbound_rules_${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  source_port_range           = "*"
  protocol                    = "Tcp"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = var.security_group_name
  depends_on                  = [azurerm_network_security_group.nsg]
}

resource "azurerm_subnet_network_security_group_association" "ng_association_subnet-br-sh" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on                = [azurerm_subnet.subnet]
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  size                            = var.vm_size
  resource_group_name             = var.vm_resource_name
  location                        = var.location
  computer_name                   = var.vm_computer_name
  admin_username                  = var.vm_admin_username
  admin_password                  = "${azurerm_key_vault_secret.vm_secret.value}"
  disable_password_authentication = var.vm_disable_password_authentication
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = var.vm_disk_name
    caching              = var.vm_disk_caching
    storage_account_type = var.vm_disk_storage_account_type
  }

  source_image_id = var.image_id
  depends_on      = [azurerm_network_interface.nic]
}