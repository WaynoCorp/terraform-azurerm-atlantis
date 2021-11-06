module "webhook" {
  source = "./modules/webhook"
  atlantis_allowed_repo_names = [var.github_repo_allowlist]
  webhook_secret = var.github_webhook_secret
  webhook_url = "https://${one(azurerm_app_service.app.*.default_site_hostname)}/events"

  depends_on = [azurerm_app_service.app]
}