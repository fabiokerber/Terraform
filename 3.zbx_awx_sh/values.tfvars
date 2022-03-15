location      = "brazilsouth"
resource_name = "rg-br-tu-awx-redhat"

# Network
vnet_name                     = "tu-vnet"
subnet_name                   = "AwxSubnet"
vnet_resource_group_name      = "tu-vnet-rg"
public_ip_name                = "vm-linux-public-ip-redhat"
allocation_method             = "Dynamic"
security_group_name           = "sg-vm-linux-redhat"
network_interface_name        = "interface-vm-linux-redhat"
nic_configuration_name        = "vm-linux-nic-configuration-redhat"
private_ip_address_allocation = "Dynamic"