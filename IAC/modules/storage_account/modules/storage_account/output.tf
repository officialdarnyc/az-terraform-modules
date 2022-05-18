output "id" {
    value = azurerm_storage_account.storage_account.id
}

output "primary_access_key" {
    value = azurerm_storage_account.storage_account.primary_access_key
}

output "secondary_access_key" {
    value = azurerm_storage_account.storage_account.secondary_access_key
}
