locals {
    all_roles = [
        for role in var.roles:
            {
                name = lookup(role, "name"),
                scope = lookup(role, "scope", var.subscription_id)
                user_defined_role = tobool(lookup(role, "user_defined_role", "false"))
                description = lookup(role, "description", null)
                actions = lookup(role, "actions", null) == null ? [] : split(",", lookup(role, "actions", ""))
                not_actions = lookup(role, "not_actions", null) == null ? [] : split(",", lookup(role, "not_actions", ""))
                assignable_scopes = split(",", lookup(role, "assignable_scopes", try(var.subscription_id, "")))
            }
    ]

    user_defined_roles = {
        for role in local.all_roles:
            role.name => role
            if role.user_defined_role
    }

    predefined_roles = {
        for role in local.all_roles:
            role.name => role
            if !role.user_defined_role
    }
}
