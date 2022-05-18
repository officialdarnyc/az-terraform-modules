locals {
    application_ids = {
        null = null,
        "Microsoft Graph" = "00000003-0000-0000-c000-000000000000",
        "Office 365 Management" = "c5393580-f805-4401-95e8-94b7a6ef2fc2",
        "Key Vault" = "00000002-0000-0000-c000-000000000000"
    }

    resource_ids = {
        null = null,
        "User.Read.All" = "df021288-bdef-4463-88db-98f22de89214",
        "User.ReadWrite" = "b4e74841-8e56-480b-be8b-910348b18b4c"
        "ActivityFeed.Read" = "c5393580-f805-4401-95e8-94b7a6ef2fc2"
        "KeyVault.Read" = "5778995a-e1bf-45b8-affa-663a9f3f4d04"
    }

    required_resource_accesses = {
        for access in var.required_resource_accesses:
            try(local.application_ids[lookup(access, "app_name", null)], lookup(access, "app_id", null)) => {
                id = try(local.resource_ids[lookup(access, "resource_name", null)], lookup(access, "resource_id")),
                type = lookup(access, "type", "Role")
            }...
    }
}
