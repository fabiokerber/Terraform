

# Variáveis do ambiente de tu

### Ambiente
environment = "tu"

### Cluster AKS
aks_rg_name = "azu-rg-tu-lab"

aks_system_node_pool = {
  enable_auto_scaling    = true
  enable_host_encryption = false
  enable_node_public_ip  = false
  max_pods               = 30
  name                   = "systempool"
  node_count             = 1
  max_count              = 4
  min_count              = 1
  orchestrator_version   = "1.21.7"
  os_disk_size_gb        = 128
  os_disk_type           = "Managed"
  type                   = "VirtualMachineScaleSets"
  vm_size                = "Standard_F2s_v2"
}

aks_vnet_subnet = {
  subnet_name  = "AKSTerraform"
  vnet_name    = "tu-vnet-teste-terraform"
  vnet_rg_name = "tu-vnet-rg"
}

acr = {
  acr_name    = "azuacrtulab001"
  acr_rg_name = "azu-rg-tu-lab"
}

# Node pools
aks_node_pool = {
  "nodepool1" = {
    name                   = "apppool"
    vm_size                = "Standard_F2s_v2"
    node_count             = 1
    enable_auto_scaling    = false
    enable_host_encryption = false
    enable_node_public_ip  = false
    max_pods               = 30
    max_count              = 4
    min_count              = 1
    orchestrator_version   = "1.21.7"
    os_disk_size_gb        = 30
    os_disk_type           = "Managed"
    mode                   = "User"
  },
  "nodepool2" = {
    name                   = "apppool2"
    vm_size                = "Standard_F2s_v2"
    node_count             = 1
    enable_auto_scaling    = false
    enable_host_encryption = false
    enable_node_public_ip  = false
    max_pods               = 30
    max_count              = 4
    min_count              = 1
    orchestrator_version   = "1.21.7"
    os_disk_size_gb        = 30
    os_disk_type           = "Managed"
    mode                   = "User"
  }
}

# Diagnostic Settings
diagsettings_enabled = true
