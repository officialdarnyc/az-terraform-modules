# ---------- Log Analytics Workspace Solution -------------

resource "azurerm_log_analytics_solution" "log_analytics_solution" {
  resource_group_name   = var.resource_group_name
  solution_name         = var.solution_name
  location              = var.location
  workspace_resource_id = var.workspace_resource_id
  workspace_name        = var.workspace_name

  plan {
    publisher = var.plan.publisher # "Microsoft"
    product   = var.plan.product # "OMSGallery/ContainerInsights"
  }

}