# -------------- Create a record ----------------
resource "azurerm_private_dns_a_record" "a_record" {
  
  for_each = var.a_records

  name                = each.key
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.ip

  tags                  = var.tags
}