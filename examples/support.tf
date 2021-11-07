provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}