locals {
    waf_policy_managed_rules = var.waf_policy_managed_rules == null ? [] : var.waf_policy_managed_rules
    waf_policy_custom_rules = var.waf_policy_custom_rules == null ? [] : var.waf_policy_custom_rules
    
    waf_policies = var.waf_policies == null ? {} : {
        for waf_policy in var.waf_policies:
            lookup(waf_policy, "name") => {
                name = lookup(waf_policy, "name")
                enabled = tobool(lookup(waf_policy, "enabled", "true"))
                mode = lookup(waf_policy, "mode", null)
                redirect_url = lookup(waf_policy, "redirect_url", null)
                custom_block_response_status_code = lookup(waf_policy, "custom_block_response_status_code", null)
                custom_block_response_body = lookup(waf_policy, "custom_block_response_body", null)
                managed_rules = [
                    for rule in local.waf_policy_managed_rules:
                        {
                            type = lookup(rule, "type")
                            version = lookup(rule, "version")
                        }
                        if lookup(rule, "policy_name") == lookup(waf_policy, "name")
                ]
                custom_rules = [
                    for rule in local.waf_policy_custom_rules:
                        {
                            name = lookup(rule, "name")
                            type = lookup(rule, "type", "MatchRule")
                            action = lookup(rule, "action", "Allow")
                            enabled = lookup(rule, "enabled", "true")
                            priority = lookup(rule, "priority", "100")
                            rate_limit_duration_in_minutes = lookup(rule, "rate_limit_duration_in_minutes", null)
                            rate_limit_threshold = lookup(rule, "rate_limit_threshold", null)
                            condition_match_variable = lookup(rule, "condition_match_variable", null)
                            condition_operator = lookup(rule, "condition_operator", "Equal")
                            condition_negate = lookup(rule, "condition_negate", "false")
                            condition_match_values = lookup(rule, "condition_match_values", null)
                        }
                        if lookup(rule, "policy_name") == lookup(waf_policy, "name")
                ]
            }
    }
}

