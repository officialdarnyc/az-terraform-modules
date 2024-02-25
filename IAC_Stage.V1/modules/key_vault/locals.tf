locals {

    key_vault_private_link_enabled = var.key_vault_private_link_enabled == true ? true : false
    key_vault_private_link_endpoint_name = local.key_vault_private_link_enabled && (var.key_vault_private_link_endpoint_name == null || var.key_vault_private_link_endpoint_name == "") ? "ep-pl-${var.key_vault_name}" : var.key_vault_private_link_endpoint_name
    key_vault_private_link_subnet_id = var.key_vault_private_link_subnet_id == null ? "" : var.key_vault_private_link_subnet_id
    diagnostic_setting_name = local.keyvault_diagnostics_setting_enabled && (var.diagnostic_setting_name == null || var.diagnostic_setting_name == "") ? "${var.key_vault_name}-ds" : var.diagnostic_setting_name
    keyvault_diagnostics_setting_enabled = var.keyvault_diagnostics_setting_enabled == true ? true : false
    
    secrets = {
        for secret in var.secrets:
            lookup(secret, "key") => {
                key = lookup(secret, "key")
                value = lookup(secret, "value")
            }
    }

    access_policies = {
        for policy in var.access_policies:
            lookup(policy, "object_id", "-") => {
                object_id = lookup(policy, "object_id")
                tenant_id = lookup(policy, "tenant_id")
                key_permissions = lookup(policy, "key_permissions", null) == null ? [] : split(",", lookup(policy, "key_permissions", ""))
                secret_permissions = lookup(policy, "secret_permissions", null) == null ? [] : split(",", lookup(policy, "secret_permissions", ""))
                certificate_permissions = lookup(policy, "certificate_permissions", null) == null ? [] : split(",", lookup(policy, "certificate_permissions", ""))
                storage_permissions = lookup(policy, "storage_permissions", null) == null ? [] : split(",", lookup(policy, "storage_permissions", ""))
            }
            if lookup(policy, "object_id", null) != null
    }

    certificates = {
        for certificate in var.certificates:
            lookup(certificate, "certificate_name") => {
                certificate_name = lookup(certificate, "certificate_name")
                certificate_file_name = lookup(certificate, "certificate_file_name", null)
                certificate_file_credentials = lookup(certificate, "certificate_file_credentials", null)
                issuer = lookup(certificate, "issuer", null)
                properties = lookup(certificate, "properties", null) #TODO: This will be an issue in actual
            }
    }
}