resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  dynamic "private_service_connection" {
    for_each = {
      for indx, service in var.service_connections : indx => {
        index = indx
        resource_id      = service.resource_id
        subresource_name = service.subresource_name
        is_manual        = service.is_manual
        request_message  = service.request_message
      }
    }
    content {
      name                           = "service-conn-${private_service_connection.value.index}-${var.name}"
      is_manual_connection           = private_service_connection.value.is_manual
      request_message                = private_service_connection.value.request_message
      private_connection_resource_id = private_service_connection.value.resource_id
      subresource_names              = private_service_connection.value.subresource_name
    }
  }
}
