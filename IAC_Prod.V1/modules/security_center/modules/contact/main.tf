resource "azurerm_security_center_contact" "contact" {
  email               = var.email               # "contact@example.com"
  phone               = var.phone               # "+1-555-555-5555"
  alert_notifications = var.alert_notifications # true
  alerts_to_admins    = var.alerts_to_admins    # true
}
