resource "azurerm_app_service_plan" "plan" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  per_site_scaling = true

  tags = var.tags
}

resource "azurerm_app_service" "app" {
  count = var.enabled ? 1 : 0

  name                = local.name
  location            = azurerm_app_service_plan.plan.location
  resource_group_name = azurerm_app_service_plan.plan.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id
  https_only          = true

  site_config {
    linux_fx_version            = "DOCKER|runatlantis/atlantis"
    health_check_path           = "/healthz"
    always_on                   = false
    http2_enabled               = true
    websockets_enabled          = false
    ftps_state                  = "Disabled"
    ip_restriction              = local.ip_white_list
    scm_use_main_ip_restriction = true
    scm_type                    = "GitHub"
  }

  logs {
    detailed_error_messages_enabled = true
    application_logs {
      file_system_level = "Warning"
      azure_blob_storage {
        level             = "Warning"
        retention_in_days = 30
        sas_url           = azurerm_storage_account.sa.primary_blob_endpoint
      }
    }

    http_logs {
      azure_blob_storage {
        retention_in_days = 30
        sas_url           = azurerm_storage_account.sa.primary_blob_endpoint
      }
    }
  }

  app_settings = local.env_variables

  storage_account {
    access_key   = azurerm_storage_account.sa.primary_access_key
    account_name = azurerm_storage_account.sa.name
    name         = "certs"
    share_name   = azurerm_storage_share.share.name
    type         = "AzureFiles"
    mount_path = "/mnt/atlantis-certs"
  }

  identity {
    type = "SystemAssigned"
  }

  backup {
    name                = "daily"
    storage_account_url = "https://${azurerm_storage_account.sa.name}.blob.core.windows.net/${azurerm_storage_container.container.name}${data.azurerm_storage_account_sas.sas.sas}&sr=b"

    schedule {
      frequency_interval = "30"
      frequency_unit     = "Day"
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [site_config]
  }
}


resource "azurerm_application_insights" "app_insights" {
  name                 = local.name
  location             = var.location
  resource_group_name  = var.resource_group_name
  application_type     = "other"
  disable_ip_masking   = true
  retention_in_days    = 30
  daily_data_cap_in_gb = 1

  tags = var.tags
}