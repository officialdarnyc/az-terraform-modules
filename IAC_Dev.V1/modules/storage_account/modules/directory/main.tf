resource "azurerm_storage_share_directory" "directory" {
    name                 = var.directory_name
    share_name           = var.storage_share_name
    storage_account_name = var.storage_account_name
}
