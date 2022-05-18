module "key_vault" {
    source                     = "./modules/key_vault"
    
    key_vault_name                    = var.key_vault_name
    resource_group_name               = var.resource_group_name
    location                          = var.location
    tenant_id                         = var.tenant_id
    key_vault_sku                     = var.key_vault_sku
    purge_protection_enabled          = var.purge_protection_enabled
    soft_delete_retention_days        = var.soft_delete_retention_days
    enabled_for_deployment            = var.enabled_for_deployment
    network_acl_default_action        = var.network_acl_default_action
    network_acl_bypass                = var.network_acl_bypass

    tags                       = var.tags
}

module "secret" {
    source                     = "./modules/secret"
    
    for_each                   = local.secrets

    key_vault_id               = module.key_vault.id
    name                       = each.value.key
    value                      = each.value.value
    tags                       = var.tags

    depends_on                 = [
        module.key_vault,
        module.access_policy
    ]
}

module "access_policy" {
    source = "./modules/access_policy"

    for_each                  = local.access_policies

    key_vault_id              = module.key_vault.id
    tenant_id                 = each.value.tenant_id
    object_id                 = each.value.object_id
    key_permissions           = each.value.key_permissions 
    secret_permissions        = each.value.secret_permissions 
    certificate_permissions   = each.value.certificate_permissions  
    storage_permissions       = each.value.storage_permissions

    depends_on = [
        module.key_vault
    ]
}

module "certificate" {
    source = "./modules/certificate"

    for_each                      = local.certificates

    key_vault_id                  = module.key_vault.id
    certificate_name              = each.value.certificate_name
    certificate_file_name         = each.value.certificate_file_name
    certificate_file_credentials  = each.value.certificate_file_credentials
    issuer                        = each.value.issuer 
    properties                    = each.value.properties

    depends_on = [
        module.key_vault,
        module.access_policy
    ]
}

module "key_vault_private_endpoint" {
    source              = "../private_link_service"
    count               = local.key_vault_private_link_enabled ? 1 : 0

    location            = var.location
    resource_group_name = var.resource_group_name
    
    endpoint_name       = local.key_vault_private_link_endpoint_name
    subnet_id           = local.key_vault_private_link_subnet_id
    service_connections = [
        {
            resource_id      = module.key_vault.id
            subresource_name = [ "vault" ]
        }
    ]

    depends_on = [
        module.key_vault
    ]
}

module "key_vault_diagnostic_setting" {
    source                         = "../azure_monitor/modules/diagnostics_setting"
    count                          = local.keyvault_diagnostics_setting_enabled ? 1 : 0

    diagnostic_setting_name        = local.diagnostic_setting_name
    target_resource_id             = module.key_vault.id
    log_analytics_workspace_id     = var.log_analytics_workspace_id

    depends_on = [
        module.key_vault
    ]
}
