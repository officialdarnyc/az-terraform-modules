# -------------- Create DNS zone vnet link ----------------
resource "azurerm_private_dns_zone_virtual_network_link" "network_link" {
  for_each = var.vnet_links
  
  name                  = each.key
  resource_group_name   = each.value.resource_group_name
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = each.value.virtual_network_id

  tags                  = var.tags
}
