data "azurerm_subscription" "subscription" {
}

module "application" {
    source = "./modules/azuread_application"
    
    application_name              = var.application_name
    homepage_url                  = var.homepage_url
    owners                        = local.application_owners
    logout_url                    = var.logout_url
    required_resource_accesses    = var.required_resource_accesses
    redirect_uris                 = var.redirect_uris
    access_token_issuance_enabled = var.access_token_issuance_enabled
    id_token_issuance_enabled     = var.id_token_issuance_enabled
}

module "service_principal" {
    source = "./modules/service_principal"
    
    application_id                = module.application.application_id
    application_object_id         = module.application.object_id
    end_date_relative             = var.service_principal_end_date_relative
    name                          = var.service_principal_name
    description                   = var.service_principal_description
    owners                        = local.service_principal_owners
    app_role_assignment_required  = var.service_principal_app_role_assignment_required
    use_existing                  = var.use_existing_service_principal
    subscription_id               = var.subscription_id
    roles                         = var.service_principal_roles
}
