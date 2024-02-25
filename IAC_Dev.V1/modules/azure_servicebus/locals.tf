locals {

    diagnostic_setting_name = local.servicebus_diagnostics_setting_enabled && (var.diagnostic_setting_name == null || var.diagnostic_setting_name == "") ? "${var.servicebus_name}-ds" : var.diagnostic_setting_name
    servicebus_diagnostics_setting_enabled = var.servicebus_diagnostics_setting_enabled == true ? true : false

    topics = {
        for topic in var.topics:
            lookup(topic, "name") => {
                name = lookup(topic, "name")
            }
    }
	
	queues = {
        for queue in var.queues:
            lookup(queue, "name") => {
                name = lookup(queue, "name")
            }
    }

	subscriptions = {
        for subscription in var.subscriptions:
            lookup(subscription, "name") => {
                name     = lookup(subscription, "name")
                servicebus_topic_name = lookup(subscription, "servicebus_topic_name")
            }
    }

}