resource "azurerm_key_vault" "key_vault" {
    name                       = var.key_vault_name
    resource_group_name        = var.resource_group_name
    location                   = var.location
    tenant_id                  = var.tenant_id
    sku_name                   = var.key_vault_sku
    purge_protection_enabled   = var.purge_protection_enabled
    soft_delete_retention_days = var.soft_delete_retention_days
    enabled_for_deployment     = var.enabled_for_deployment
    network_acls {
        default_action         = var.network_acl_default_action
        bypass                 = var.network_acl_bypass
    }
    
    tags                       = var.tags
}