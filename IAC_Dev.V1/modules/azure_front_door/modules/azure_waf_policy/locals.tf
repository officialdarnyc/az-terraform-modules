locals {
    managed_rules = var.managed_rules == null ? {} : {
        for managed_rule in var.managed_rules:
            lookup(managed_rule, "type") => {
                type = lookup(managed_rule, "type")
                version = lookup(managed_rule, "version")
            }
    }

    custom_rules = var.custom_rules == null ? {} : {
        for custom_rule in var.custom_rules:
            lookup(custom_rule, "name") => {
                name = lookup(custom_rule, "name")
                type = lookup(custom_rule, "type", "MatchRule")
                action = lookup(custom_rule, "action", "Allow")
                enabled = tobool(lookup(custom_rule, "enabled", "true"))
                priority = tonumber(lookup(custom_rule, "priority", "100"))
                rate_limit_duration_in_minutes = lookup(custom_rule, "rate_limit_duration_in_minutes", null) == null ? null : tonumber(lookup(custom_rule, "rate_limit_duration_in_minutes", "0"))
                rate_limit_threshold = lookup(custom_rule, "rate_limit_threshold", null) == null ? null : tonumber(lookup(custom_rule, "rate_limit_threshold", "0"))

                conditions = lookup(custom_rule, "condition_match_variable", null) == null ? {} : {
                    "default_rule" = {
                        match_variable = lookup(custom_rule, "condition_match_variable", null)
                        operator = lookup(custom_rule, "condition_operator", "Equal")
                        negation_condition = tobool(lookup(custom_rule, "condition_negate", "false"))
                        match_values = split(",", lookup(custom_rule, "condition_match_values", null) == null ? "" : lookup(custom_rule, "match_values", "")), 
                    }
                }
            }
    }
}
