# Variáveis do ambiente de do

### Ambiente
environment = "do"

### Cluster AKS
aks_rg_name = "azu-rg-do-pltfrma"

aks_system_node_pool = {
  enable_auto_scaling    = false
  enable_host_encryption = false
  enable_node_public_ip  = false
  max_pods               = 30
  name                   = "systempool"
  node_count             = 1
  max_count              = 4
  min_count              = 1
  orchestrator_version   = "1.22.6"
  os_disk_size_gb        = 128
  os_disk_type           = "Managed"
  type                   = "VirtualMachineScaleSets"
  vm_size                = "Standard_F2s_v2"
}

aks_vnet_subnet = {
  subnet_name  = "AKSTerraform"
  vnet_name    = "do-vnet-teste-terraform"
  vnet_rg_name = "do-vnet-rg"
}

acr = {
  acr_name    = "acrbrdoopenbanking"
  acr_rg_name = "rg-br-do-k8s"
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
    orchestrator_version   = "1.22.6"
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
    orchestrator_version   = "1.22.6"
    os_disk_size_gb        = 30
    os_disk_type           = "Managed"
    mode                   = "User"
  }
}

# Diagnostic Settings
diagsettings_enabled = true