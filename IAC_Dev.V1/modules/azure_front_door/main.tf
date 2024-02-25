module "afd_waf_policy" {
    source                            = "./modules/azure_waf_policy"
    for_each                          = local.waf_policies
    name                              = each.value.name
    resource_group_name               = var.resource_group_name
    enabled                           = each.value.enabled
    mode                              = each.value.mode
    redirect_url                      = each.value.redirect_url
    custom_block_response_status_code = each.value.custom_block_response_status_code
    custom_block_response_body        = each.value.custom_block_response_body
    managed_rules                     = each.value.managed_rules
    custom_rules                      = each.value.custom_rules
    tags                              = var.tags
}

module "afd" {
    source                                       = "./modules/afd"
    front_door_name                              = var.front_door_name
    resource_group_name                          = var.resource_group_name
    enforce_backend_pools_certificate_name_check = var.enforce_backend_pools_certificate_name_check
    load_balancer_enabled                        = var.load_balancer_enabled
    routing_rules                                = var.routing_rules
    default_policy_id                            = var.default_policy_name == null ? null : module.afd_waf_policy[var.default_policy_name].id
    tags                                         = var.tags
    depends_on = [
        module.afd_waf_policy
    ]
}

/*
resource "azurerm_storage_account" "afd_storage" {
    for_each                 = var.attach_log_analytics ? { "attach" : "" } : {}
    
    name                     = "${replace(var.front_door_name, "-", "")}strg"
    resource_group_name      = var.resource_group_name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "GRS"
    
    depends_on = [
        module.afd
    ]
}*/

resource "azurerm_monitor_diagnostic_setting" "afd_log_analytics" {
    for_each           = var.attach_log_analytics ? { "attach" : "" } : {}
    
    name               = "${var.front_door_name}-diagnostics"
    target_resource_id = module.afd.id
    #storage_account_id = azurerm_storage_account.afd_storage["attach"].id
    log_analytics_workspace_id = var.log_analytics_workspace_id

    log {
        category = "FrontdoorAccessLog"
        enabled  = true

        retention_policy {
            enabled = false
        }
    }

    /*log {
        category = "FrontDoorHealthProbeLog"
        enabled  = true

        retention_policy {
            enabled = false
        }
    }*/

    log {
        category = "FrontdoorWebApplicationFirewallLog"
        enabled  = true

        retention_policy {
            enabled = false
        }
    }

    metric {
        category = "AllMetrics"

        retention_policy {
            enabled = false
        }
    }

    depends_on = [
        module.afd #azurerm_storage_account.afd_storage
    ]
}

/*
resource "azurerm_log_analytics_linked_storage_account" "law_strg_link" {
    for_each              = var.attach_log_analytics ? { "attach" : "" } : {}
    
    data_source_type      = "customlogs" #customlogs/azurewatson/query/alerts/Ingestion
    resource_group_name   = var.resource_group_name
    workspace_resource_id = var.log_analytics_workspace_id
    storage_account_ids   = [ azurerm_storage_account.afd_storage["attach"].id ]
    
    depends_on = [
        azurerm_monitor_diagnostic_setting.afd_log_analytics
    ]
}
*/
