locals {
    
    diagnostic_setting_name = local.eventhub_diagnostics_setting_enabled && (var.diagnostic_setting_name == null || var.diagnostic_setting_name == "") ? "${local.eventhub_namespace}-ds" : var.diagnostic_setting_name
    eventhub_diagnostics_setting_enabled = var.eventhub_diagnostics_setting_enabled == true ? true : false
    
    eventhub_namespace = var.eventhub_namespace == null && var.name != null ? "${var.name}-ns" : var.eventhub_namespace

    all_event_hubs = concat(
        var.name != null ? [ {
            name = var.name
            partition_count = var.partition_count
            message_retention = var.message_retention
            eventhub_status = var.status
            descriptions = var.descriptions
        }] : [],
        [
            for eventhub in (var.eventhubs == null ? [] : var.eventhubs):
                {
                    name = lookup(eventhub, "name")
                    partition_count = tonumber(lookup(eventhub, "partition_count", "2"))
                    message_retention = tonumber(lookup(eventhub, "message_retention", "1"))
                    eventhub_status = lookup(eventhub, "eventhub_status", "Active")
                    descriptions = []
                }
        ]
    )

    eventhubs = {
        for eventhub in local.all_event_hubs:
            eventhub.name => eventhub
    }

    temp_namespace_authorization_rules = var.name != null && length(try(var.namespace_authorization_rules, [])) == 0 ? [
        { listen = true, send = true, manage = true }
    ] : var.namespace_authorization_rules

    namespace_authorization_rules = {
        for index, nmspace_auth_rule in local.temp_namespace_authorization_rules:
            lookup(nmspace_auth_rule, "name", "${lookup(nmspace_auth_rule, "eventhub_name", local.eventhub_namespace)}-rule-${index}") => {
                name = lookup(nmspace_auth_rule, "name", "${lookup(nmspace_auth_rule, "eventhub_name", local.eventhub_namespace)}-rule-${index}")
                listen = tobool(lookup(nmspace_auth_rule, "listen", "false"))
                send = tobool(lookup(nmspace_auth_rule, "send", "false"))
                manage = tobool(lookup(nmspace_auth_rule, "manage", "false"))
            }
    }

    temp_eventhub_authorization_rules = var.name != null && length(try(var.eventhub_authorization_rules, [])) == 0 ? [
        { listen = true, send = true, manage = true }
    ] : var.eventhub_authorization_rules

    eventhub_authorization_rules = {
        for index, ehub_auth_rule in local.temp_eventhub_authorization_rules:
            lookup(ehub_auth_rule, "name", "${lookup(ehub_auth_rule, "eventhub_name", var.name)}-rule-${index}") => {
                name = lookup(ehub_auth_rule, "name", "${lookup(ehub_auth_rule, "eventhub_name", var.name)}-rule-${index}")
                eventhub_name = lookup(ehub_auth_rule, "eventhub_name", var.name)
                listen = tobool(lookup(ehub_auth_rule, "listen", "false"))
                send = tobool(lookup(ehub_auth_rule, "send", "false"))
                manage = tobool(lookup(ehub_auth_rule, "manage", "false"))
            }
    }
}


