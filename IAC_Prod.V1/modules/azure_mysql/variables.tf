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

variable "replicas" {
    type = list(map(string))
    description = "replicas for MySql"
    default = []
}

variable "databases" {
    type = list(map(string))
    description = "databases for MySql"
    default = []
}

variable "tags" {
    description = "tags for MySql"
}

variable "firewall_rules" {
    type = list(map(string))
    description = "Firewall rules"
    default = []
}

variable "subnet_id" {
    type = string
    description = "Server subnet id"
    default = null
}

variable "subnet_rule_name" {
    type = string
    description = "Server subnet rule name"
    default = null
}

variable "allow_access_to_azure_services" {
    type = bool
    description = "Allow access to azure services"
    default = false
}

variable "private_link_enabled" {
    type = bool
    description = "Enable private link endpoint"
    default = false
}

variable "private_link_endpoint_name" {
    type = string
    description = "Private link endpoint name"
    default = null
}

variable "private_link_subnet_id" {
    type = string
    description = "Private link subnet id"
    default = null
}

variable "configurations" {
    type = list(map(string))
    description = "Server configuration parameters"
    default = []
}

variable "log_analytics_workspace_id" {
    type    = string
    default = null
}

variable "diagnostic_setting_name" {
    type    = string
    default = null
}

variable "mysql_diagnostics_setting_enabled" {
    type = bool
    description = "Enable Diagnostics setting"
    default = false
}


