resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
  name                = var.eventhub_auth_rule_name
  namespace_name      = var.eventhub_namespace
  eventhub_name       = var.eventhub_name
  resource_group_name = var.resource_group_name
  listen              = var.listen
  send                = var.send
  manage              = var.manage
}
      
