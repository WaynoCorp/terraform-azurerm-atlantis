resource "azurerm_storage_account" "sa" {
  name                = replace(var.name, "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  shared_access_key_enabled = true

  network_rules {
    default_action = "Allow"
    #virtual_network_subnet_ids = [module.virtual_network.subnets["iaas-private"].id]
    #ip_rules                   = [chomp(data.http.my_ip.body)]
    bypass = ["AzureServices"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = "atlantis-tf-state"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "share" {
  name                 = "atlantis-cert-share"
  storage_account_name = azurerm_storage_account.sa.name
}

data "azurerm_storage_account_sas" "sas" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only        = true

  resource_types {
    service   = false
    container = false
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = true
  }

  start = formatdate("YYYY-MM-DD", timestamp())
  expiry = formatdate("YYYY-MM-DD", timeadd(timestamp(), "300h"))

  permissions {
    read    = false
    write   = true
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
  }
}