resource "azurerm_vpn_site" "conn" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.name
  virtual_wan_id      = var.virtual_wan_id
  tags                = var.tags

  dynamic "link" {
    for_each = {for indx,link in var.links: link.value => merge(link, {index = "00${indx}"}) }
    content {
      name       = "link-${var.name}-${link.value.index}"
      ip_address = link.value.type == "IP" ? link.value.value : null
      fqdn = link.value.type == "FQDN" ? link.value.value : null
    }
  }
}