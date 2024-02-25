resource "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer_name
  sku                 = var.sku_name
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                          = var.frontend_ip_configuration_name
    availability_zone             = var.availability_zone
    public_ip_address_id          = var.public_ip_address_id
    subnet_id                     = var.subnet_id
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address_version    = var.private_ip_address_version
  }
  tags = var.tags
}
