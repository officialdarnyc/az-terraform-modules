variable "resource_group_name" {
    type        = string
    description = "resource group name"
}

variable "location" {
    type        = string
    description = "location"
}

variable "storage_account_name" {
    type        = string
    description = "storage account name"
}

variable "account_tier" {
    type        = string
    description = "account tier : standard"
    default     = "standard"
}

variable "account_replication_type" {
    type        = string
    description = "account replication : LRS"
    default     = "LRS"
}

variable "tags" {
    description = "provide tags for tags"
}

variable "prevent_destroy" {
    type = bool
    description = "Prevent destroy"
    default = false
}