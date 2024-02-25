variable "resource_group_name" {
    type = string
    description = "Default resource group name that the keyvault will be created in."
}

variable "location" {
    type = string
    description = "Provide region name, defaults to 'eastus'"
    default = "eastus"
}

variable "key_vault_name" {
    type = string
    description = "Name of the keyvault to create"
}

variable "key_vault_sku" {
    type = string
    default = "standard"
    description = "Provide SKU for keyvault ? defaults to 'standard'"
}

variable "purge_protection_enabled" {
    type = bool
    default = false
    description = "Provide boolean value, enable purge protection ? true/false, defaults to false"
}

variable "soft_delete_retention_days" {
    type = number
    default = 30
    description = "Provide soft delete retention days, defaults to 30"
}

variable "enabled_for_deployment" {
    type = bool
    default = false
    description = "Provide boolean value, enable for deployment ? true/false, defaults to false"
}

variable "network_acl_default_action"{
    type = string
    description = "Default action for network acl"
    default = "Allow"
}

variable "tenant_id"{
    type = string
    description = "Default action for network acl"
}

variable "network_acl_bypass"{
    type = string
    description = "Allow bypass for network acl"
    default = "AzureServices"
}

variable "tags" {
    description = "The tags to associate with the keyvault"
}