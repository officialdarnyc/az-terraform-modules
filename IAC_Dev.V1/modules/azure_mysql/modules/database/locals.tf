locals {
    create_user_file_name = "cu_${var.mysql_server_name}_${var.mysql_db_name}.sql"

    privileges = var.privileges == null ? "ALL PRIVILEGES ON ${var.mysql_db_name}.*" : var.privileges

    create_database_user = var.user != null && length(var.user == null ? "" : var.user) > 0 && var.password != null && length(var.password == null ? "" : var.password) > 0

    user = var.user == null ? "" : var.user
    password = var.password == null ? "" : var.password
}
