resource "azurerm_security_center_auto_provisioning" "auto_provisioning" {
  auto_provision = var.enable_auto_provisioning # "On"
}
