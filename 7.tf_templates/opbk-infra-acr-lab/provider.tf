# Configure the Microsoft Azure Provider
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
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