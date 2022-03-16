# Location
location = "brazilsouth"

# Resource Group Default
resource_name = "rg-br-sh"

# Resource Group VM
vm_resource_name = "rg-br-awx-ctos"

# Network
address_space                 = ["10.0.0.0/16", "192.168.0.0/16"]
address_prefixes              = ["10.0.2.0/24"]
vnet_name                     = "vnet-br-sh"
subnet_name                   = "subnet-br-sh"
vnet_resource_group_name      = "vnet-rg-br-sh"
public_ip_name                = "vm-public-ip-awx-ubuntu-br-sh"
allocation_method             = "Dynamic"
security_group_name           = "sg-br-sh"
network_interface_name        = "vm-interface-awx-ubuntu-br-sh"
nic_configuration_name        = "vm-nic-configuration-awx-ubuntu-br-sh"
private_ip_address_allocation = "Dynamic"

# Virtual machine
idle_timeout_in_minutes            = 30
domain_name_label                  = "labawx"
vm_name                            = "vm-awx-ubuntu-br-sh"
vm_size                            = "Standard_B2s"
vm_disk_caching                    = "ReadWrite"
vm_disk_storage_account_type       = "Standard_LRS"
vm_image_publisher                 = "Canonical"
vm_image_offer                     = "UbuntuServer"
vm_image_sku                       = "18.04-LTS"
vm_image_version                   = "18.04.202203080"
vm_computer_name                   = "vm-awx-ubuntu-br-sh"
vm_admin_username                  = "kerberos"
vm_admin_password                  = "123@mudar"
vm_disable_password_authentication = false

# Security
inbound_rules = { 101 = 80, 102 = 443 }