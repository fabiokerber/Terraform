# Location
location = "brazilsouth"

# Resource Group Default
resource_name = "rg-br-sh"

# Resource Group VM
vm_resource_name = "rg-vm-awx-br-sh"

# Key Vault
kv_name = "key-vault-br-sh"
kv_rg   = "rg-key-vault-br-sh"

# Network
address_space                 = ["192.168.0.0/16"]
address_prefixes              = ["192.168.10.0/24"]
vnet_name                     = "vnet-br-sh"
subnet_name                   = "subnet-br-sh"
vnet_resource_group_name      = "vnet-rg-br-sh"
public_ip_name                = "vm-public-ip-awx-br-sh"
allocation_method             = "Dynamic"
security_group_name           = "sg-br-sh"
network_interface_name        = "vm-interface-awx-br-sh"
nic_configuration_name        = "vm-nic-configuration-awx-br-sh"
private_ip_address_allocation = "Dynamic"

# Virtual machine
idle_timeout_in_minutes            = 30
domain_name_label                  = "vmawxbrsh"
vm_name                            = "vm-awx-br-sh"
vm_size                            = "Standard_B2s"
vm_disk_caching                    = "ReadWrite"
vm_disk_name                       = "vm-disk-awx-br-sh"
vm_disk_storage_account_type       = "Standard_LRS"
vm_computer_name                   = "vm-awx-br-sh"
vm_admin_username                  = "azureuser"
vm_admin_password                  = "vm-linux-password"
vm_disable_password_authentication = false

# Custom image
image_rg   = "rg-img-br-sh"
image_name = "vm-img-20220328154216-awx-br-sh"
image_id   = "/subscriptions/ee6222a2-c6ac-48ae-b6ad-b7fef2589b74/resourceGroups/rg-img-br-sh/providers/Microsoft.Compute/images/vm-img-20220328154216-awx-br-sh"

# Security
inbound_rules = { 101 = 80, 102 = 443, 103 = 22 }