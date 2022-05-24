# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# OpenBanking - SharedServices
provider "azurerm" {
  alias           = "shared_services"
  subscription_id = "257a30cf-1d37-4197-9074-7d58f22cc134"
  features {}
}

# OpenBanking - DITI-IDENTITY
provider "azurerm" {
  alias           = "diti_identity"
  subscription_id = "e03a1d19-d0b9-43db-a417-fc1bcc958821"
  features {}
}

# DITI - GERENCIAMENTO
provider "azurerm" {
  alias           = "diti_gerenciamento"
  subscription_id = "717cce4c-28a1-4d71-ba56-17c0d44ba2ad"
  features {}
}
