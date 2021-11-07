resource "azurerm_resource_group" "rg" {
  location = "useast"
  name     = ""
}

module "atlantis" {
  source = "../"

  enabled               = true
  subscription_id       = data.azurerm_subscription.current.id
  name                  = "waylewatlantis"
  github_user           = "waylew-lexis"
  github_token          = var.gh_token
  github_webhook_secret = var.gh_webhook_secret
  resource_group_name   = module.resource_group.name
  location              = module.resource_group.location
  github_repo_allowlist = "github.com/LexisNexis-RBA/terraform-azurerm-atlantis"

  allowed_ips = [format("%s/32", chomp(data.http.my_ip.body))]

  alert_emails = ["wayne.lewalski@lexisnexisrisk.com"]

  tags = module.metadata.tags
}

## for testing, store variables in an uncommitted terraform.tfvars file
variable "gh_token" {
  description = "The github personal or app token."
  type        = string
  sensitive   = true
}

variable "gh_webhook_secret" {
  description = "The repository webhook secret."
  type        = string
  sensitive   = true
}

variable "tfe_token" {
  description = "The Terraform Enterprise / Cloud team or personal api token"
  type        = string
  sensitive   = true
  default     = null
}

output "mod_outputs" {
  value = module.atlantis
}
