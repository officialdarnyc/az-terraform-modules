# -------------- Create cname record ----------------

resource "azurerm_private_dns_cname_record" "cname" {
  for_each = var.cname_records
  

  name                = each.key
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.fqdn

  tags                  = var.tags
}