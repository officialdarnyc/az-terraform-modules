resource "azurerm_servicebus_namespace" "servicebus" {
  name						 	        = var.servicebus_name
  location            			= var.location
  resource_group_name 			= var.resource_group_name
  sku			                  = var.sku
  capacity						      = var.capacity
  zone_redundant				    = var.zone_redundant
  tags                      = var.tags	
}
