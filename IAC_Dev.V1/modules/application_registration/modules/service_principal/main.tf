
resource "azuread_service_principal" "service_principal" {
    application_id               = var.application_id
    app_role_assignment_required = var.app_role_assignment_required
    owners                       = var.owners 
    use_existing                 = var.use_existing
    description                  = var.description
    #TODO - Unused fields - alternative_names, features(custom_single_sign_on_app,enterprise_application,gallery_application,visible_to_others), login_url, notes, notification_email_addresses, preferred_single_sign_on_mode, saml_single_sign_on(relay_state), tags
}

resource "azuread_application_password" "service_principal_secret" {
    application_object_id = var.application_object_id
    end_date_relative     = var.end_date_relative
    display_name          = var.name
    depends_on = [
        azuread_service_principal.service_principal
    ]
}

resource "azurerm_role_definition" "service_principal_user_defined_roles" {
    for_each           = local.user_defined_roles
    name               = each.value.name
    scope              = each.value.scope
    description        = each.value.description

    permissions {
        actions     = each.value.actions
        not_actions = each.value.not_actions
    }

    assignable_scopes = each.value.assignable_scopes
}

resource "azurerm_role_assignment" "service_principal_predefined_role_assignment" {
    for_each             = local.predefined_roles
    scope                = each.value.scope
    role_definition_name = each.value.name
    principal_id         = azuread_service_principal.service_principal.id
}

resource "azurerm_role_assignment" "service_principal_user_defined_role_assignment" {
    for_each             = local.user_defined_roles
    scope                = each.value.scope
    role_definition_id   = azurerm_role_definition.service_principal_user_defined_roles[each.value.name].role_definition_resource_id
    principal_id         = azuread_service_principal.service_principal.id
}
