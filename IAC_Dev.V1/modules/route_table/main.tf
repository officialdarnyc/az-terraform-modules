resource "azurerm_route_table" "route_table" {
    name                = var.route_table_name
    location            = var.location
    resource_group_name = var.resource_group_name
    
    for_each            = {for route in var.routes:  route.name => route} 
        route {
            name                   = each.value.name
            address_prefix         = each.value.address_prefix
            next_hop_type          = each.value.next_hop_type
            next_hop_in_ip_address = each.value.next_hop_in_ip_address
        }
}