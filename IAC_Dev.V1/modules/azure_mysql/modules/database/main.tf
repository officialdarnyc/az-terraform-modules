resource "azurerm_mysql_database" "mysql_database" {
    name                = var.mysql_db_name
    resource_group_name = var.resource_group_name
    server_name         = var.mysql_server_name
    charset             = var.charset
    collation           = var.collation
}

resource "local_file" "create_user_file" {
    content     = <<-EOT
        CREATE USER IF NOT EXISTS '${local.user}'@'%' IDENTIFIED BY '${local.password}';
        GRANT ${local.privileges} TO '${local.user}'@'%';
        FLUSH PRIVILEGES;
    EOT
    filename = "${local.create_user_file_name}"
}

resource "null_resource" "create_database_user" {
    for_each = local.create_database_user ?  { "provision" : "true" } : {}
    triggers = {
        always_run = "change-${var.mysql_server_name}-${var.mysql_db_name}-${var.user}"
    }

    provisioner "local-exec" {
        command = "mysql --host=${var.mysql_server_name}.mysql.database.azure.com --user=${var.administrator_login}@${var.mysql_server_name}.mysql.database.azure.com --password=${var.administrator_password} < ${local.create_user_file_name}"
    }

    depends_on = [
        azurerm_mysql_database.mysql_database,
        local_file.create_user_file
    ]
}

resource "null_resource" "clean_user_file" {
    for_each = local.create_database_user ?  { "provision" : "true" } : {}
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = <<-EOT
            del ${local.create_user_file_name}
        EOT
    }

    depends_on = [
        null_resource.create_database_user
    ]
}
