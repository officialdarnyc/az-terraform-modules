#-------------- Create FrontDoor WAF Policy ----------------

resource "azurerm_frontdoor_firewall_policy" "afdpolicy" {
    name                              = var.name
    resource_group_name               = var.resource_group_name
    enabled                           = var.enabled
    mode                              = var.mode
    redirect_url                      = var.redirect_url
    custom_block_response_status_code = var.custom_block_response_status_code
    custom_block_response_body        = var.custom_block_response_body

    dynamic "managed_rule" {
        for_each = local.managed_rules

        content {
            type    = managed_rule.value.type
            version = managed_rule.value.version
        }
    }


    dynamic "custom_rule" {
        for_each = local.custom_rules
        content {
            name                           = custom_rule.value.name
            enabled                        = custom_rule.value.enabled
            priority                       = custom_rule.value.priority
            rate_limit_duration_in_minutes = custom_rule.value.rate_limit_duration_in_minutes
            rate_limit_threshold           = custom_rule.value.rate_limit_threshold
            type                           = custom_rule.value.type
            action                         = custom_rule.value.action

            dynamic "match_condition" {
                for_each = lookup(custom_rule.value, "conditions", {})
                
                content {
                    match_variable     = match_condition.value.match_variable
                    operator           = match_condition.value.operator
                    negation_condition = match_condition.value.negation_condition
                    match_values       = match_condition.value.match_values
                }
            }
        }
    }

/*
    dynamic "managed_rule" {
        for_each = var.settings_waf.managed_rules
        content {
            type    = managed_rule.value.type
            version = managed_rule.value.version

            dynamic "exclusion" {
                for_each = contains(keys(managed_rule.value), "exclusions") ? managed_rule.value.exclusions : {}
                content {
                    match_variable = exclusion.value.match_variable
                    operator       = exclusion.value.operator
                    selector       = exclusion.value.selector
                }
            }

            dynamic "override" {
                for_each = contains(keys(managed_rule.value), "overrides") ? managed_rule.value.overrides : {}
                content {
                    rule_group_name = override.value.rule_group_name

                    dynamic "exclusion" {
                        for_each = contains(keys(override.value), "overrides") ? override.value.exclusions : {}
                        content {
                            match_variable = exclusion.value.match_variable
                            operator       = exclusion.value.operator
                            selector       = exclusion.value.selector
                        }
                    }

                    dynamic "rule" {
                        for_each = contains(keys(override.value), "rules") ? override.value.rules : {}
                        content {
                            rule_id = rule.value.rule_id
                            action  = rule.value.action

                            dynamic "exclusion" {
                                for_each = contains(keys(rule.value), "exclusions") ? rule.value.exclusions : {}
                                content {
                                    match_variable = exclusion.value.match_variable
                                    operator       = exclusion.value.operator
                                    selector       = exclusion.value.selector
                                }
                            }
                        }
                    }
                }
            }
        }
    }*/
    tags = var.tags
}