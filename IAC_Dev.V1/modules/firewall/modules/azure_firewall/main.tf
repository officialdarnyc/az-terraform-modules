resource "azurerm_firewall" "firewall" {
  name                      = var.firewall_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  sku_name                  = var.firewall_sku_name
  sku_tier                  = var.sku_tier
  firewall_policy_id        = var.firewall_policy_id

  ip_configuration {
    name                 = var.fw_ip_config_name
    subnet_id            = var.fw_ip_config_subnet_id 
    public_ip_address_id = var.fw_ip_config_pipid 
  }
}