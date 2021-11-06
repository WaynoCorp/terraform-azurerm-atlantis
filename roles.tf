resource "azurerm_role_assignment" "app" {
  count                = var.enabled ? 1 : 0
  scope                = var.subscription_id
  role_definition_name = "Owner"
  principal_id         = azurerm_app_service.app[count.index].identity[0].principal_id

  depends_on = [azurerm_app_service.app]
}

resource "azurerm_role_assignment" "storage" {
  count                = var.enabled ? 1 : 0
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = azurerm_app_service.app[count.index].identity[0].principal_id

  depends_on = [azurerm_app_service.app, azurerm_storage_account.sa]
}