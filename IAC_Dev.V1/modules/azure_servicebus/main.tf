module "servicebus" {
    source              = "./modules/servicebus"
    servicebus_name     = var.servicebus_name
    location            = var.location
    resource_group_name = var.resource_group_name
    sku                 = var.sku
    capacity            = var.capacity
    tags                = var.tags    
}

module "servicebus_topic" {
    source                = "./modules/servicebus_topic"
    for_each              = local.topics

    servicebus_topic_name = each.value.name
    resource_group_name   = var.resource_group_name
    servicebus_name       = var.servicebus_name
    depends_on = [
        module.servicebus
    ]
}

module "servicebus_queue" {
    source                = "./modules/servicebus_queue"
    for_each              = local.queues

    servicebus_queue_name = each.value.name
    resource_group_name   = var.resource_group_name
    servicebus_name       = var.servicebus_name
    depends_on = [
        module.servicebus
    ]
}

module "servicebus_subscription" {
    source                = "./modules/servicebus_subscription"
    for_each              = local.subscriptions

    resource_group_name   = var.resource_group_name
    subscription_name     = each.value.name
    servicebus_name       = var.servicebus_name
    servicebus_topic_name = each.value.servicebus_topic_name
	depends_on = [
        module.servicebus_topic
    ]
}

module "servicebus_diagnostic_setting" {
    source                         = "../azure_monitor/modules/diagnostics_setting"
    count                          = local.servicebus_diagnostics_setting_enabled ? 1 : 0

    diagnostic_setting_name        = local.diagnostic_setting_name
    target_resource_id             = module.servicebus.id
    log_analytics_workspace_id     = var.log_analytics_workspace_id

    depends_on = [
        module.servicebus
    ]
}