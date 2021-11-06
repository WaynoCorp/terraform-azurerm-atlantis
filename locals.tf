locals {
  name = lower(var.name)

  repos_config = file("${path.module}/repos.json")

  env_variables = {
    ATLANTIS_PORT              = 4141
    ATLANTIS_WEB_PASSWORD      = var.github_token
    ATLANTIS_GH_TOKEN          = var.github_token
    ATLANTIS_GH_WEBHOOK_SECRET = var.github_webhook_secret
    ATLANTIS_TFE_TOKEN         = var.tfe_token

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

    ## AZURE
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://index.docker.io"
    WEBSITES_PORT                       = 4141
    AZURE_MONITOR_INSTRUMENTATION_KEY   = azurerm_application_insights.app_insights.instrumentation_key
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES = 3
  }

  git_ips = concat(data.github_ip_ranges.git.hooks_ipv4, var.allowed_ips)

  ip_white_list = [
    for cidr in local.git_ips : {
      name                      = replace("ip_${cidr}","/",".")
      ip_address                = cidr
      priority                  = join("", [100, index(local.git_ips, cidr)])
      action                    = "Allow"
      headers                   = []
      virtual_network_subnet_id = null
      service_tag               = null
  }]
}

