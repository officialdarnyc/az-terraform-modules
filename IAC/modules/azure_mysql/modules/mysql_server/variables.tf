variable "server_name" {
    type = string
}

variable "location" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "administrator_login" {
    type = string
}

variable "administrator_login_password" {
    type = string
}

variable "sku_name" {
    type    = string
    default = "B_Gen5_2"
}

variable "storage_mb" {
    type    = number
    default = 5120
}

variable "mysql_server_version" {
    type    = string
    default = "5.7"
}

variable "auto_grow_enabled" {
    type    = bool
    default = true
}

variable "backup_retention_days" {
    type    = number
    default = 7
}

variable "geo_redundant_backup_enabled" {
    type    = bool
    default = false
}

variable "infrastructure_encryption_enabled" {
    type    = bool
    default = false
}

variable "public_network_access_enabled" {
    type    = bool
    default = true
}

variable "ssl_enforcement_enabled" {
    type    = bool
    default = true
}

variable "ssl_minimal_tls_version_enforced" {
    type    = string
    default = "TLS1_2"
}

variable "tags" {
    description = "tags for MySql"
}

variable "create_mode" {
    type        = string
    description = "create mode for mysql"
    default     = "Default"
}

variable "creation_source_server_id" {
    type        = string
    description = "creation source server id for mysql"
    default     = null
}
