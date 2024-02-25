resource "azurerm_security_center_setting" "setting" {
  setting_name = var.setting_name   # "MCAS"
  enabled      = var.enable_setting # true
}
