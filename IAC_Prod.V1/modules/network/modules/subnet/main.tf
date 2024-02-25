# ------------- Create Subnet -------------

resource "azurerm_subnet" "subnet" {
  resource_group_name                            = var.resource_group_name
  name                                           = var.name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = var.address_prefixes
  service_endpoints                              = var.service_endpoints
  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies
}
