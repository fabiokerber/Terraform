provider "azurerm" {
  features {
  }
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
resource "azurerm_linux_virtual_machine" "awx" {
  name                            = var.vm_name
  size                            = var.vm_size
  resource_group_name             = var.vm_resource_name
  location                        = var.location
  computer_name                   = var.vm_computer_name
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = var.vm_disable_password_authentication
  network_interface_ids           = [azurerm_network_interface.nic.id]

  os_disk {
    name                 = var.vm_disk_name
    caching              = var.vm_disk_caching
    storage_account_type = var.vm_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
  depends_on = [azurerm_network_interface.nic]
}

# Storage Account
resource "azurerm_storage_account" "awx" {
  name                     = var.sa_name
  resource_group_name      = var.vm_resource_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  allow_blob_public_access = var.allow_blob_public_access
  depends_on               = [azurerm_resource_group.resource-group]
}

resource "azurerm_storage_container" "awx" {
  name                  = var.sc_name
  storage_account_name  = var.sa_name
  container_access_type = var.container_access_type
  depends_on            = [azurerm_storage_account.awx]
}

resource "azurerm_storage_blob" "awx" {
  name                   = var.sb_name
  storage_account_name   = var.sa_name
  storage_container_name = var.sc_name
  type                   = "Block"
  source                 = "script/awx.sh"
  depends_on             = [azurerm_storage_container.awx]
}

# Post-Install
resource "azurerm_virtual_machine_extension" "awx" {
  name                 = var.vm_name
  virtual_machine_id   = azurerm_linux_virtual_machine.awx.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "fileUris": ["https://saawx.blob.core.windows.net/scawx/awx.sh"],
        "commandToExecute": "sh awx.sh"
    }
SETTINGS

  depends_on = [azurerm_storage_blob.awx]
}