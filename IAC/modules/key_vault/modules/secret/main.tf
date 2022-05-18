resource "azurerm_key_vault_secret" "key_vault_secret" {
    name         = var.name
    value        = var.value
    key_vault_id = var.key_vault_id
    tags         = var.tags
}
