resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                           = var.diagnostic_setting_name
  target_resource_id             = var.target_resource_id
  storage_account_id             = var.storage_account_id
  eventhub_name                  = var.eventhub_name
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = var.log_analytics_destination_type

  /*log {
    category = var.log_category
    enabled  = var.log_enabled

    retention_policy {
      enabled = var.retention_policy_enabled
      days    = var.days
    }
  } */

  metric {
    category = var.metric_category

    retention_policy {
      enabled = var.retention_policy_enabled
      days    = var.days
    }
  }
}