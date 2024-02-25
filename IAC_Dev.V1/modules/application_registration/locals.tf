data "azuread_client_config" "current" {}

locals {
    application_owners = var.application_owners == null || length(var.application_owners == null ? [] : var.application_owners) == 0 ? [ data.azuread_client_config.current.object_id ] : var.application_owners

    service_principal_owners = var.service_principal_owners == null || length(var.service_principal_owners == null ? [] : var.service_principal_owners) == 0 ? local.application_owners : var.service_principal_owners
}