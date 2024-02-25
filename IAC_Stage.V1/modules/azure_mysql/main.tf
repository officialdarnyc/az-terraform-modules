module "mysql_server" {
    source                            = "./modules/mysql_server"

    server_name                       = var.server_name
    location                          = var.location
    resource_group_name               = var.resource_group_name
    administrator_login               = var.administrator_login
    administrator_login_password      = var.administrator_login_password
    sku_name                          = var.sku_name
    storage_mb                        = var.storage_mb
    mysql_server_version              = var.mysql_server_version
    auto_grow_enabled                 = var.auto_grow_enabled
    backup_retention_days             = var.backup_retention_days
    geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
    infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
    public_network_access_enabled     = local.public_network_access_enabled
    ssl_enforcement_enabled           = var.ssl_enforcement_enabled
    ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced
    tags                              = var.tags
}

resource "azurerm_mysql_configuration" "mysql_configuration" {
    for_each            = local.configurations
    resource_group_name = var.resource_group_name
    server_name         = var.server_name
    name                = each.value.name
    value               = each.value.value
    
    depends_on = [
        module.mysql_server,
        null_resource.download_database_dump
    ]
}

module "host_ip" {
    source = "../host_ip"

    depends_on = [
        null_resource.download_database_dump
    ]
}

module "host_ip_firewall_rule" {
    source              = "./modules/firewall_rule"
    for_each            = local.public_network_access_enabled ? { "server_name" = var.server_name } : {}
    mysql_firewall_name = "${var.server_name}-hip-fr"
    server_name         = var.server_name
    resource_group_name = var.resource_group_name
    start_ip_address    = module.host_ip.ip
    end_ip_address      = module.host_ip.ip

    depends_on = [
        module.mysql_server,
        module.host_ip
    ]
}

module "azure_access_firewall_rule" {
    source              = "./modules/firewall_rule"
    for_each            = var.allow_access_to_azure_services && local.public_network_access_enabled ? { "azure_server_name" = var.server_name } : {}
    mysql_firewall_name = "${var.server_name}-as-fr"
    server_name         = var.server_name
    resource_group_name = var.resource_group_name
    start_ip_address    = "0.0.0.0"
    end_ip_address      = "0.0.0.0"

    depends_on = [
        module.mysql_server
    ]
}

module "mysql_databases" {
    source                 = "./modules/database"

    for_each               = local.databases
    
    mysql_db_name          = each.value.name
    resource_group_name    = var.resource_group_name
    mysql_server_name      = var.server_name
    charset                = each.value.charset
    collation              = each.value.collation
    administrator_login    = var.administrator_login
    administrator_password = var.administrator_login_password
    user                   = each.value.user
    password               = each.value.password
    privileges             = each.value.privileges
    depends_on = [
        module.mysql_server,
        module.host_ip_firewall_rule,
        module.azure_access_firewall_rule,
        azurerm_mysql_configuration.mysql_configuration
    ]
}

module "mysql_server_replicas" {
    source                            = "./modules/mysql_server"
    
    for_each                          = local.replicas
    
    server_name                       = each.value.name
    location                          = each.value.location
    resource_group_name               = each.value.resource_group_name
    administrator_login               = each.value.administrator_login
    administrator_login_password      = each.value.administrator_login_password
    sku_name                          = each.value.sku_name
    storage_mb                        = each.value.storage_mb
    mysql_server_version              = each.value.mysql_server_version
    auto_grow_enabled                 = each.value.auto_grow_enabled
    backup_retention_days             = each.value.backup_retention_days
    geo_redundant_backup_enabled      = each.value.geo_redundant_backup_enabled
    infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
    public_network_access_enabled     = each.value.public_network_access_enabled
    ssl_enforcement_enabled           = each.value.ssl_enforcement_enabled
    ssl_minimal_tls_version_enforced  = each.value.ssl_minimal_tls_version_enforced
    tags                              = var.tags
    create_mode                       = "Replica"
    creation_source_server_id         = module.mysql_server.id
    depends_on = [
        module.mysql_server,
        module.mysql_databases
    ]
}

module "firewall_rule" {
    source              = "./modules/firewall_rule"
    for_each            = local.firewall_rules
    mysql_firewall_name = each.value.name
    server_name         = var.server_name
    resource_group_name = var.resource_group_name
    start_ip_address    = each.value.start_ip_address
    end_ip_address      = each.value.end_ip_address
    depends_on = [
        module.mysql_server
    ]
}

module "virtual_network_rule" {
    for_each = var.subnet_id == null ? {} : { local.subnet_rule_name = local.subnet_rule_name }
    source              = "./modules/mysql_virtual_network_rule"
    name                = local.subnet_rule_name
    resource_group_name = var.resource_group_name
    server_name         = var.server_name
    subnet_id           = var.subnet_id
    depends_on = [
        module.mysql_server
    ]
}

resource "null_resource" "download_database_dump" {
    for_each = local.database_downloads
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = <<-EOT
            az storage file download --account-name ${each.value.file_share_account_name} --account-key ${each.value.file_share_account_key} --share-name ${each.value.file_share_name} --path ${each.value.file_share_path}${each.value.dump_file_name}
        EOT
    }

    depends_on = [
        module.mysql_server
    ]
}

resource "null_resource" "restore_database_dump" {
    for_each = local.database_restores
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = "mysql --host=${var.server_name}.mysql.database.azure.com --user=${var.administrator_login}@${var.server_name}.mysql.database.azure.com --password=${var.administrator_login_password} --database=${each.value.name} < ${each.value.dump_file_location == "file_share" ? "" : each.value.local_path}${each.value.dump_file_name}"
    }

    depends_on = [
        module.mysql_databases,
        null_resource.download_database_dump
    ]
}

resource "null_resource" "clean_database_dump" {
    for_each = local.database_downloads
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = <<-EOT
            del ${each.value.dump_file_name}
        EOT
    }

    depends_on = [
        null_resource.restore_database_dump
    ]
}

module "my_sql_server_private_endpoint" {
    source              = "../private_link_service"
    count               = local.private_link_enabled ? 1 : 0

    location            = var.location
    resource_group_name = var.resource_group_name
    
    endpoint_name       = local.private_link_endpoint_name
    subnet_id           = local.private_link_subnet_id
    service_connections = [
        {
            resource_id      = module.mysql_server.id
            subresource_name = [ "mysqlServer" ]
        }
    ]

    depends_on = [
        module.mysql_server
    ]
}

module "mysql_server_replica_endpoints" {
    source              = "../private_link_service"
    
    for_each            = local.replica_endpoints
    
    location            = var.location
    resource_group_name = var.resource_group_name
    
    endpoint_name       = each.value.private_link_endpoint_name
    subnet_id           = each.value.private_link_subnet_id
    service_connections = [
        {
            resource_id      = module.mysql_server_replicas[each.value.name].id
            subresource_name = [ "mysqlServer" ]
        }
    ]

    depends_on = [
        module.mysql_server_replicas
    ]
}

module "mysql_diagnostic_setting" {
    source                         = "../azure_monitor/modules/diagnostics_setting"
    count                          = local.mysql_diagnostics_setting_enabled ? 1 : 0

    diagnostic_setting_name        = local.diagnostic_setting_name
    target_resource_id             = module.mysql_server.id
    log_analytics_workspace_id     = var.log_analytics_workspace_id

    depends_on = [
        module.mysql_server
    ]
}
