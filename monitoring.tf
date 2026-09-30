################## create a log analytics workspace ##############

resource "azurerm_log_analytics_workspace" "AhmedLogAnalytics" {
  name                = var.log_analytics_workspace_name
  location            = azurerm_resource_group.AhmedRG.location
  resource_group_name = azurerm_resource_group.AhmedRG.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}


################# create a diagnostic setting for the log analytics workspace ##############

resource "azurerm_monitor_diagnostic_setting" "Ahmed_lb_Diagnostics" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_lb.ahmed_lb.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.AhmedLogAnalytics.id

  enabled_log {
    category = "LoadBalancerHealthEvent"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

################# create an action group for alerts ##############

resource "azurerm_monitor_action_group" "AhmedActionGroup" {
  name                = var.action_group_name
  resource_group_name = azurerm_resource_group.AhmedRG.name
  short_name          = "AhmedAG"

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_address_for_alerts
    use_common_alert_schema = true
  }
}

################## create a metric alert for the load balancer ##############

resource "azurerm_monitor_metric_alert" "AhmedMetricAlert" {
  name                = var.metric_alert_name
  resource_group_name = azurerm_resource_group.AhmedRG.name
  scopes              = [azurerm_lb.ahmed_lb.id]
  description         = "Fires when a backend VM fails the health probe"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Network/loadBalancers"
    metric_name      = "DipAvailability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100
  }

  action {
    action_group_id = azurerm_monitor_action_group.AhmedActionGroup.id
  }
}

