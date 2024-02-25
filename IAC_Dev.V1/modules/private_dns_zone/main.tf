# -------------- Create DNS zone ----------------
resource "azurerm_private_dns_zone" "dns" {
  name                  = var.private_dns_zone
  resource_group_name   = var.resource_group_name
  
  tags                  = var.tags
}

module "a_records" {
  source = "./modules/a_record"

  a_records = var.a_records
  
  tags = var.tags
  depends_on = [
    azurerm_private_dns_zone.dns
  ]
}

module "cname_records" {
  source = "./modules/cname_record"

  cname_records = var.cname_records
  
  tags = var.tags
  depends_on = [
    module.a_records
  ]
}

module "vnet_links" {
  source = "./modules/vnet_link"

  vnet_links = var.vnet_links
  
  tags = var.tags
  depends_on = [
    module.cname_records
  ]
}
