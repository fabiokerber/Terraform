# Variáveis do ambiente de tu

# Ambiente
environment = "tu"

# Key vault
kv_resource_group_name = "azu-rg-tu-lab"

# Acessos ao key vault
resources_access_kv = {
  "aks" = {
    # "nome_aks" = "aks_resource_group"
  }

  "apim" = {
    # "nome_apim" = "apim_resource_group"
  }

  "function" = {
    # "nome_function"  = "function_resource_group"
  }

  "vm" = {
    # "nome_vm" = "vm_resource_group"
  }

  "vmss" = {
    # "nome_vmss" = "vmss_resource_group"
  }

  "webapp" = {
    # "nome_webapp" = "webapp_resource_group"
  }

  "synapse" = {
    # "nome_synapse"        = "synapse_resource_group"
  }
}

# Secrets
secrets = {
  # "nome_secret"     = "valor_secret"
  # "vm-linux-user"     = "user"
  # "vm-linux-password" = "password"
  # "vm-dns"            = "dns"
  # "vm-ip"             = "10.10.10.10"
  # "secret1"           = "value1"
  # "secret2"           = "value2"
}