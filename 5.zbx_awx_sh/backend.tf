terraform {
  backend "azurerm" {
    resource_group_name  = "rg-br-tfstate"
    storage_account_name = "tfstatesh"
    container_name       = "tfstatesh-files"
    key                  = "+fZMhjxuPaicCClX/KeMXEv6Cln9T/rIttkcz/H318ZVk9wn3wvCtve+GRWUZ4FdwdJTRcdwI3V74gCJ2skoMQ=="
  }
}