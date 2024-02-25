locals {
  service_connections = [
      for indx, service in var.service_connections: {
        resource_id      = lookup(service, "resource_id", null)
        subresource_name = lookup(service, "subresource_name", null)
        is_manual        = lookup(service, "is_manual", false)
        request_message  = lookup(service, "request_message", null)
      }
  ]
}