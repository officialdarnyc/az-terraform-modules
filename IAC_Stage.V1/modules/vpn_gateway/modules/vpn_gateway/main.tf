resource "azurerm_virtual_wan" "wan" {
    name                = "vwan-${var.vpn_gateway_name}"
    resource_group_name = var.resource_group_name
    location            = var.location
    tags                = var.tags
}

resource "azurerm_virtual_hub" "hub" {
    name                = "hub-${var.vpn_gateway_name}"
    resource_group_name = var.resource_group_name
    location            = var.location
    virtual_wan_id      = azurerm_virtual_wan.wan.id
    address_prefix      = var.address_prefix
    tags                = var.tags
}

resource "azurerm_vpn_gateway" "gateway" {
    name                = "vpng-${var.vpn_gateway_name}"
    location            = var.location
    resource_group_name = var.resource_group_name
    virtual_hub_id      = azurerm_virtual_hub.hub.id
    tags                = var.tags
}