resource "azuread_application" "application" {
    display_name = var.application_name

    owners = var.owners
    
    dynamic "required_resource_access" {
        for_each = local.required_resource_accesses

        content {
            resource_app_id = required_resource_access.key

            dynamic "resource_access" {
                for_each = required_resource_access.value

                content {
                    id   = resource_access.value.id
                    type = resource_access.value.type
                }
            }
        }
    }

    dynamic "web" {
        for_each = length(var.homepage_url != null ? var.homepage_url : "") > 0 || length(var.logout_url != null ? var.logout_url : "") > 0 || length(var.redirect_uris != null ? var.redirect_uris : []) > 0 ? { "app_registration_web" : "app_registration_web" } : {}

        content {
            homepage_url  = var.homepage_url
            logout_url    = var.logout_url
            redirect_uris = var.redirect_uris
            implicit_grant {
                access_token_issuance_enabled = var.access_token_issuance_enabled
                id_token_issuance_enabled     = var.id_token_issuance_enabled
            }
        }
    }
}