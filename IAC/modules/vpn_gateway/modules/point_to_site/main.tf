resource "azurerm_vpn_server_configuration" "settings" {
  name                     = "server-config-${var.point_to_site_conn_name}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  vpn_authentication_types = var.vpn_auth_types

  dynamic "client_root_certificate" {
    for_each = var.vpn_auth_types != null && contains(var.vpn_auth_types , "Certificate") ? { name = "cert-${var.point_to_site_conn_name}"} : {}
    content {
      name             = "cert-${var.point_to_site_conn_name}"
      public_cert_data = var.certificate_data
    }
  }
}

resource "azurerm_point_to_site_vpn_gateway" "point_to_site_vpn_conn" {
  name                        = "pts-vpn-${var.point_to_site_conn_name}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  virtual_hub_id              = var.vpn_gateway_hub_id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.settings.id
  scale_unit                  = var.scale_unit
  tags                        = var.tags
  connection_configuration {
    name = "pts-vpn-conn-${var.point_to_site_conn_name}"

    vpn_client_address_pool {
      address_prefixes = var.address_prefixes
    }
  }
}