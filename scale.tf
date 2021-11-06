resource "azurerm_monitor_autoscale_setting" "scale" {
  count               = var.enabled ? 1 : 0

  name                = format("%s-autoscale", local.name)
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_app_service_plan.plan.id

  profile {
    name = "default"

    capacity {
      default = 1
      minimum = 1
      maximum = 2
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.plan.id
        operator           = "GreaterThan"
        statistic          = "Average"
        threshold          = 80
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT5M"
      }
      scale_action {
        cooldown  = "PT10M"
        direction = "Increase"
        type      = "ChangeCount"
        value     = 1
      }
    }

    rule {
      metric_trigger {
        metric_name        = "CpuPercentage"
        metric_resource_id = azurerm_app_service_plan.plan.id
        operator           = "LessThan"
        statistic          = "Average"
        threshold          = 10
        time_aggregation   = "Average"
        time_grain         = "PT1M"
        time_window        = "PT5M"
      }
      scale_action {
        cooldown  = "PT5M"
        direction = "Decrease"
        type      = "ChangeCount"
        value     = 1
      }
    }


  }

  notification {
    email {
      send_to_subscription_administrator = false
      send_to_subscription_co_administrator = false
      custom_emails = var.alert_emails
    }
  }
}