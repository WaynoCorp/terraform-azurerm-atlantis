resource "azurerm_container_group" "aci" {
  count = 0

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = var.is_public ? "Public" : "Private"
  dns_name_label      = var.is_public ? var.dns_name_label : null
  network_profile_id  = var.is_public ? null : var.network_profile_id
  os_type             = "linux"
  restart_policy      = "OnFailure"

  container {
    name   = "ngrok"
    cpu    = var.container_cpu
    image  = "wernight/ngrok:latest"
    memory = var.container_memory

    environment_variables = {
      NGROK_PROTOCOL : "http"
      NGROK_PORT : "localhost:4141"
      NGROK_AUTH : "20QNrZujJUt6Q4DDLSxmDiBtbRH_ueWVLgeWBditTufqVbte"
    }
    ports {
      port     = 4040
      protocol = "TCP"
    }
  }

  container {
    name   = "atlantis"
    image  = "runatlantis/atlantis:latest"
    cpu    = var.container_cpu
    memory = var.container_memory

    environment_variables = {
      ATLANTIS_GH_USER                = var.github_user
      ATLANTIS_REPO_ALLOWLIST         = var.github_repo_allowlist
      ATLANTIS_WEB_BASIC_AUTH         = true
      ATLANTIS_WEB_USERNAME           = var.github_user
      ATLANTIS_WRITE_GIT_CREDS        = true
      ATLANTIS_REPO_CONFIG_JSON       = local.repos_config
      ARM_USE_MSI                     = true
      ARM_ACCESS_KEY                  = azurerm_storage_account.sa.primary_access_key
      ARM_SKIP_CREDENTIALS_VALIDATION = true
      ARM_SKIP_PROVIDER_REGISTRATION  = true
      ARM_SUBSCRIPTION_ID             = var.subscription_id
    }

    secure_environment_variables = {
      ATLANTIS_WEB_PASSWORD      = var.github_token
      ATLANTIS_GH_TOKEN          = var.github_token
      ATLANTIS_GH_WEBHOOK_SECRET = var.github_webhook_secret
      ATLANTIS_TFE_TOKEN         = var.tfe_token
    }

    ports {
      port     = 4141
      protocol = "TCP"
    }

    volume {
      mount_path           = "/mnt/atlantis-certs"
      name                 = azurerm_storage_account.sa.name
      storage_account_key  = azurerm_storage_account.sa.primary_access_key
      storage_account_name = azurerm_storage_account.sa.name
      share_name           = azurerm_storage_share.share.name
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [azurerm_storage_account.sa]
}
