# ----------- Container Registry -------------
resource "azurerm_container_registry" "acr" {

  resource_group_name         = var.resource_group_name
  location                    = var.location
  name                        = var.azure_container_registry_name
  sku                         = var.azure_container_registry_sku
  admin_enabled               = var.admin_enabled

  tags = var.tags
}

