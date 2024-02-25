data "azurerm_key_vault" "keyvault" {
    name                = var.certificate_key_vault
}

resource "azurerm_frontdoor_custom_https_configuration" "cutom_https_settings" {
    frontend_endpoint_id              = var.frontend_endpoint_id
    custom_https_provisioning_enabled = var.certificate_enabled

    custom_https_configuration {
        certificate_source                         = var.certificate_source
        azure_key_vault_certificate_secret_name    = var.certificate_secret
        azure_key_vault_certificate_vault_id       = data.azurerm_key_vault.keyvault.id
        azure_key_vault_certificate_secret_version = var.certificate_version
    }
}
