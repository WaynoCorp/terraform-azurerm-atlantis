output "app_principal_id" {
  value = one(azurerm_app_service.app.*.identity.0.principal_id)
}

output "app_name" {
  value = one(azurerm_app_service.app.*.name)
}

output "app_default_hostname" {
  value = "https://${one(azurerm_app_service.app.*.default_site_hostname)}"
}

output "app_outbound_ip_list" {
  value = one(azurerm_app_service.app.*.outbound_ip_address_list)
}

output "ip_white_list" {
  value = local.ip_white_list
}

