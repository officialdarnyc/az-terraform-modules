# ---------- Log Analytics -------------
resource "azurerm_log_analytics_workspace" "log_analytics" {
  resource_group_name = var.resource_group_name
  name                = var.log_analytics_workspace_name
  location            = var.location
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  tags                = var.tags
}

