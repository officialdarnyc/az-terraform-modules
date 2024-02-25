resource "azurerm_mysql_server" "mysql_server" {
    name                              = var.server_name
    location                          = var.location
    resource_group_name               = var.resource_group_name
    administrator_login               = var.administrator_login
    administrator_login_password      = var.administrator_login_password
    sku_name                          = var.sku_name
    storage_mb                        = var.storage_mb
    version                           = var.mysql_server_version
    auto_grow_enabled                 = var.auto_grow_enabled
    backup_retention_days             = var.backup_retention_days
    geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
    infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
    public_network_access_enabled     = var.public_network_access_enabled
    ssl_enforcement_enabled           = var.ssl_enforcement_enabled
    ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
    create_mode                       = var.create_mode
    creation_source_server_id         = var.creation_source_server_id
    tags                              = var.tags
}
