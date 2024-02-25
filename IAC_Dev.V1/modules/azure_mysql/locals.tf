locals {
    private_link_enabled = var.private_link_enabled == true ? true : false
    private_link_endpoint_name = local.private_link_enabled && (var.private_link_endpoint_name == null || var.private_link_endpoint_name == "") ? "ep-pl-${var.server_name}" : var.private_link_endpoint_name
    diagnostic_setting_name = local.mysql_diagnostics_setting_enabled && (var.diagnostic_setting_name == null || var.diagnostic_setting_name == "") ? "ds-${var.server_name}" : var.diagnostic_setting_name
    private_link_subnet_id = var.private_link_subnet_id == null ? "" : var.private_link_subnet_id

    mysql_diagnostics_setting_enabled = var.mysql_diagnostics_setting_enabled == true ? true : false

    public_network_access_enabled = local.private_link_enabled ? false : true
    
    database_replicas = [
        for replica in var.replicas: 
            {
                name                              = lookup(replica, "name")
                location                          = lookup(replica, "location", var.location)
                resource_group_name               = lookup(replica, "resource_group_name", var.resource_group_name)
                administrator_login               = lookup(replica, "administrator_login", var.administrator_login)
                administrator_login_password      = lookup(replica, "administrator_login_password", var.administrator_login_password)
                sku_name                          = lookup(replica, "sku_name", var.sku_name)
                mysql_server_version              = lookup(replica, "mysql_server_version", var.mysql_server_version)
                backup_retention_days             = lookup(replica, "backup_retention_days", var.backup_retention_days)
                infrastructure_encryption_enabled = lookup(replica, "infrastructure_encryption_enabled", var.infrastructure_encryption_enabled)
                auto_grow_enabled                 = lookup(replica, "auto_grow_enabled", var.auto_grow_enabled)
                storage_mb                        = lookup(replica, "storage_mb", var.storage_mb)
                geo_redundant_backup_enabled      = lookup(replica, "geo_redundant_backup_enabled", var.geo_redundant_backup_enabled)
                private_link_enabled              = tobool(lookup(replica, "private_link_enabled", "false"))
                private_link_subnet_name          = lookup(replica, "private_link_enabled", "false") == false ? null : lookup(replica, "private_link_subnet_name", null)
                private_link_endpoint_name        = lookup(replica, "private_link_enabled", "false") == false ? null : lookup(replica, "private_link_endpoint_name", "ep-pl-${lookup(replica, "name")}")
                private_link_subnet_id            = lookup(replica, "private_link_enabled", "false") == false ? null : lookup(replica, "private_link_subnet_id", null)
                public_network_access_enabled     = tobool(lookup(replica, "public_network_access_enabled", "true")) && tobool(lookup(replica, "private_link_enabled", "false")) == false ? true : false
                ssl_enforcement_enabled           = lookup(replica, "ssl_enforcement_enabled", var.ssl_enforcement_enabled)
                ssl_minimal_tls_version_enforced  = lookup(replica, "ssl_minimal_tls_version_enforced", var.ssl_minimal_tls_version_enforced)
            }
    ]

    replicas = {
        for replica in local.database_replicas: 
            replica.name => replica
    }

    replica_endpoints = {
        for replica in local.database_replicas: 
            replica.name => replica
            if replica.private_link_enabled
    }

    databases = {
        for database in var.databases: 
            lookup(database, "name") => {
                name       = lookup(database, "name")
                charset    = lookup(database, "charset", "utf8") == null ? "utf8" : lookup(database, "charset", "utf8")
                collation  = lookup(database, "collation", "utf8_unicode_ci") == null ? "utf8_unicode_ci" : lookup(database, "collation", "utf8_unicode_ci")
                user       = lookup(database, "user", null)
                password   = lookup(database, "password", null)
                privileges = lookup(database, "privileges", null)
            }
    }

    firewall_rules = local.public_network_access_enabled ? {
        for index, rule in var.firewall_rules: 
            lookup(rule, "name", "${var.server_name}-fr-${index}") => {
                name             = lookup(rule, "name", "${var.server_name}-fr-${index}")
                start_ip_address = lookup(rule, "start_ip_address", lookup(rule, "ip_address", "*"))
                end_ip_address   = lookup(rule, "end_ip_address", lookup(rule, "start_ip_address", lookup(rule, "ip_address", "*")))
            }
    } : {}

    subnet_rule_name = var.subnet_rule_name == null ? "${var.server_name}-sn-r" : var.subnet_rule_name

    temp_database_restores = [
        for database in var.databases: 
            {
                name                    = lookup(database, "name")
                dump_file_name          = lookup(database, "dump_file_name", null)
                dump_file_location      = lookup(database, "dump_file_location", null) == null ? ((lookup(database, "file_share_name", null) != null && lookup(database, "file_share_account_name", null) != null && lookup(database, "file_share_account_key", null) != null) ? "file_share" : "local") : lookup(database, "dump_file_location", null)
                local_path              = lookup(database, "local_path", null) == null ? "./" : lookup(database, "local_path", null)
                file_share_name         = lookup(database, "file_share_name", null)
                file_share_path         = lookup(database, "file_share_path", null) == null ? "" : lookup(database, "file_share_path", null)
                file_share_account_name = lookup(database, "file_share_account_name", null)
                file_share_account_key  = lookup(database, "file_share_account_key", null)
            }
            if lookup(database, "dump_file_name", null) != null && (lookup(database, "restore", null) == null || tobool(lookup(database, "restore", "true")) == true)
    ]

    database_restores = {
        for restore in local.temp_database_restores: 
            restore.name => restore
            if (restore.dump_file_location != "file_share" || (restore.file_share_name != null && restore.file_share_account_name != null && restore.file_share_account_key != null)) && restore.dump_file_name != null
    }

    database_downloads = {
        for restore in local.temp_database_restores: 
            restore.name => restore
            if restore.dump_file_location == "file_share" && restore.file_share_name != null && restore.file_share_account_name != null && restore.file_share_account_key != null
    }

    configurations = {
        for configuration in var.configurations:
            lookup(configuration, "name", null) => {
                name = lookup(configuration, "name", null)
                value = lookup(configuration, "value", null)
            }
            if lookup(configuration, "name", null) != null && lookup(configuration, "value", null) != null
    }
}