resource "azurerm_application_gateway" "application_gateway" {

  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration.name
    subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.app_gateway_ip_configuration_vnet}/subnets/${var.app_gateway_ip_configuration_subnet}"
  }

  frontend_port {
    name = var.frontend_port.name
    port = var.frontend_port.port
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration

    content {
      name = frontend_ip_configuration.value.name
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_allocation
      public_ip_address_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${var.app_gateway_frontend_ip_config_pip}"
      
     
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool

    content {
      name = backend_address_pool.value.name
      fqdns = backend_address_pool.value.type == "FQDN" ? backend_address_pool.value.value : null
      ip_addresses = backend_address_pool.value.type == "IP" ? backend_address_pool.value.value : null
    }
  }

  dynamic "probe" {
    for_each = var.probe

    content {
      name = probe.value.name
      host = probe.value.host
      port = probe.value.port
      protocol = probe.value.protocol
      path = probe.value.path
      interval = probe.value.interval
      timeout = probe.value.timeout
      unhealthy_threshold = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      match {
        body = probe.value.match.body
        status_code = probe.value.match.status_code
      }
    }

  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      path                  = backend_http_settings.value.path
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      probe_name            = backend_http_settings.value.probe_name
      host_name             = backend_http_settings.value.host_name
    }
  }

  /* dynamic "ssl_certificate" {
    for_each = { for indx, item in var.keyvault_secret_name: indx => item}
    content {
      name = data.azurerm_key_vault_certificate.certificate[ssl_certificate.key].name
      key_vault_secret_id = data.azurerm_key_vault_certificate.certificate[ssl_certificate.key].secret_id
    }
  }*/
  
  dynamic "http_listener" {
    for_each = var.http_listener
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      host_name                      = http_listener.value.host_name
      protocol                       = http_listener.value.protocol
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      #data.azurerm_key_vault_certificate.certificate.name
    }
  }

  dynamic "url_path_map" {
    for_each = var.url_path_map

    content {
      name = url_path_map.value.name
      #type = "Forwarding"
      default_backend_address_pool_name = url_path_map.value.default_backend_address_pool_name
      default_backend_http_settings_name = url_path_map.value.default_backend_http_settings_name
      dynamic "path_rule" {
        for_each = url_path_map.value.path_rule

        content {
          name = path_rule.value.name
          paths = path_rule.value.paths
          backend_address_pool_name = path_rule.value.backend_address_pool_name
          backend_http_settings_name = path_rule.value.backend_http_settings_name
        }
      }
    }
  }
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule

    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name  = request_routing_rule.value.backend_http_settings_name
      url_path_map_name           = request_routing_rule.value.url_path_map_name
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = var.identity_ids
  }

  tags          = var.tags
}