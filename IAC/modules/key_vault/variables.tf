variable "tags" {
    description = "The tags to associate with the keyvault"
}

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

variable "enabled_for_disk_encryption" {
    type = bool
    default = false
    description = "Provide boolean value, enable for disk encryption ? true/false, defaults to false"
}

variable "enable_rbac_authorization" {
    type = bool
    default = false
    description = "Provide boolean value, enable RBAC authorization ? true/false, defaults to false"
}

variable "network_acl_default_action"{
      type = string
      description = "Default action for network acl"
      default = "Allow"
}

variable "network_acl_bypass"{
      type = string
      description = "Allow bypass for network acl"
      default = "AzureServices"
}

# ------------------ Keyvault Secret variables ------------------
variable "secrets" {
    type    = list(map(string))
    description = "Provide list of secret key and values to be stored in keyvault"
    default = []
}
# ------------------ Keyvault Access Policy variables ------------------
variable "tenant_id" {
    type = string
    description = "Provide azure subscription tenant id"
}
variable "access_policies" {
    type = list(map(string))
    description = "Provide keyvault access policy for each object/userId/appId"
    default = []
}

variable "certificates" {
    type = list(map(string))
    description = "Provide list of certificates (PFX files) to be uploaded to keyvault"
    default = []
}

variable "key_vault_private_link_enabled" {
    type = bool
    description = "Enable private link endpoint"
    default = false
}

variable "key_vault_private_link_endpoint_name" {
    type = string
    description = "Private link endpoint name"
    default = null
}

variable "key_vault_private_link_subnet_id" {
    type = string
    description = "Private link subnet id"
    default = null
}

variable "log_analytics_workspace_id" {
    type    = string
    default = null
}

variable "keyvault_diagnostics_setting_enabled" {
    type = bool
    description = "Enable Diagnostics setting"
    default = false
}

variable "diagnostic_setting_name" {
    type    = string
    default = null
}