provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

module "subscription" {
  source          = "github.com/Azure-Terraform/terraform-azurerm-subscription-data.git?ref=v1.0.0"
  subscription_id = data.azurerm_subscription.current.subscription_id
}

module "naming" {
  source = "github.com/Azure-Terraform/example-naming-template.git?ref=v1.0.0"
}

module "metadata" {
  source = "github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.2"

  naming_rules = module.naming.yaml

  market              = "us"
  project             = "https://github.com/LexisNexis-RBA/terraform-azure-vm-github-runner"
  location            = "eastus2"
  environment         = "sandbox"
  product_name        = "wlatlantis"
  business_unit       = "security"
  product_group       = "contoso"
  subscription_id     = module.subscription.output.subscription_id
  subscription_type   = "dev"
  resource_group_type = "shared"
}
