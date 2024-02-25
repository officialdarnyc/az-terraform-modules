output "id" {
  value = azurerm_vpn_gateway.gateway.id
}
output "wan_id" {
  value = azurerm_virtual_wan.wan.id
}
output "hub_id" {
  value = azurerm_virtual_hub.hub.id
}
