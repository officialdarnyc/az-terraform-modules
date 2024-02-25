# -------------- Create Public IP ----------------
resource "azurerm_public_ip" "ip" {
    name                  = var.public_ip_name
    location              = var.location
    resource_group_name   = var.resource_group_name
    allocation_method     = var.ip_allocation_method
    sku                   = var.sku
    domain_name_label     = var.domain_name_label
    reverse_fqdn          = var.reverse_fqdn
    tags                  = var.tags

}
