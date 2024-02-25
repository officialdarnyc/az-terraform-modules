resource "azurerm_security_center_workspace" "workspace" {
  scope        = var.scope        # "/subscriptions/00000000-0000-0000-0000-000000000000"
  workspace_id = var.workspace_id # azurerm_log_analytics_workspace.example.id
}
