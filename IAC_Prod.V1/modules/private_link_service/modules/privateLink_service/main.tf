resource "azurerm_private_link_service" "privateLink_service" {
  name                = var.privateLink_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  dynamic "service" {
    for_each = var.linkService
    content {
      nat_ip_configuration {
        name      = var.nat_ip_configuration_name
        subnet_id = var.subnet_id
        primary   = var.primary
      }
      load_balancer_frontend_ip_configuration_ids = [var.load_balancer_frontend_ip_configuration_ids]
    }
  }
  enable_proxy_protocol = var.enable_proxy_protocol
  tags                  = var.tags
}
