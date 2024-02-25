module "eventhub_namespace" {
    source                   = "./modules/azure_eventhub_namespace"
    eventhub_namespace       = local.eventhub_namespace
    location                 = var.location
    resource_group_name      = var.resource_group_name
    sku                      = var.sku
    capacity                 = var.capacity
    rulesets                 = var.rulesets
    identities               = var.identities
    tags                     = var.tags
}

module "eventhub" {
    source                   = "./modules/eventhub"
    for_each                 = local.eventhubs
    
    eventhub_name            = each.value.name
    eventhub_namespace       = local.eventhub_namespace
    resource_group_name      = var.resource_group_name
    partition_count          = each.value.partition_count
    message_retention        = each.value.message_retention
    eventhub_status          = each.value.eventhub_status
    depends_on = [
        module.eventhub_namespace
    ]
}

module "namespace_authorization_rule" {
    source                       = "./modules/eventhub_namespace_authorization_rule"
    for_each                     = local.namespace_authorization_rules
    eventhub_namespace           = local.eventhub_namespace
    resource_group_name          = var.resource_group_name
    namespace_auth_rule_name     = each.value.name
    listen                       = each.value.listen
    send                         = each.value.send
    manage                       = each.value.manage
    depends_on = [
        module.eventhub_namespace
    ]
}

module "eventhub_authorization_rule" {
    source                       = "./modules/eventhub_authorization_rule"
    for_each                     = local.eventhub_authorization_rules
    eventhub_namespace           = local.eventhub_namespace
    resource_group_name          = var.resource_group_name
    eventhub_auth_rule_name      = each.value.name
    eventhub_name                = each.value.eventhub_name
    listen                       = each.value.listen
    send                         = each.value.send
    manage                       = each.value.manage
    depends_on = [
        module.eventhub
    ]
}

module "eventhub_diagnostic_setting" {
    source                         = "../azure_monitor/modules/diagnostics_setting"
    count                          = local.eventhub_diagnostics_setting_enabled ? 1 : 0

    diagnostic_setting_name        = local.diagnostic_setting_name
    target_resource_id             = module.eventhub_namespace.id
    log_analytics_workspace_id     = var.log_analytics_workspace_id

    depends_on = [
        module.eventhub_namespace
    ]
}