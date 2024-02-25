resource "azurerm_eventhub_namespace_authorization_rule" "namespace_authorization_rule" {
  name                = var.namespace_auth_rule_name
  namespace_name      = var.eventhub_namespace
  resource_group_name = var.resource_group_name
  listen              = var.listen
  send                = var.send
  manage              = var.manage
}
      
