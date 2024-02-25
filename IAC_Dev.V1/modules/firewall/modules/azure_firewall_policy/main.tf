resource "azurerm_firewall_policy" "firewall_policy" {
  name                = var.firewall_policyname
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.firewall_policy_sku
  dns {
    proxy_enabled = "true"
  }
  threat_intelligence_mode = "Alert"  
  /*tls_certificate {  
    name = var.certificateName
    key_vault_secret_id = azurerm_key_vault_secret.example.id
  }*/
  intrusion_detection {
      mode="Alert"
  }
}