# -------------- Network Security Gorup Resource Creation Template ----------------
resource "azurerm_network_security_group" "nsg" {
  location                    = var.location
  resource_group_name         = var.resource_group_name
  name                        = var.network_security_group_name
  tags                        = var.tags
}
