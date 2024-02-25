variable "mysql_db_name" {
    type = string
}

variable "charset" {
    type    = string
    default = "utf8"
}

variable "collation" {
    type    = string
    default = "utf8_unicode_ci"
}

variable "mysql_server_name" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "administrator_login" {
    type = string
    default = null
}

variable "administrator_password" {
    type = string
    default = null
}

variable "user" {
    type = string
    default = null
}

variable "password" {
    type = string
    default = null
}

variable "privileges" {
    type = string
    default = null
}
