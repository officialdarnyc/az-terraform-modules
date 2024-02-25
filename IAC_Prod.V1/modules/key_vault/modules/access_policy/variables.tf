variable "key_vault_id" {
    type = string
    description = "Provide azure resource id for key vault"
}
variable "tenant_id" {
    type = string
    description = "Provide azure subscription tenant id"
}
variable "object_id" {
    type = string
    description = "Provide azure application id"
}
variable "key_permissions" {
    type    = list(string)
    default = [ "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Recover", "Purge", "Restore", "Update", "Verify", "Sign", "WrapKey", "UnwrapKey" ]
}
variable "secret_permissions" {
    type    = list(string)
    default = [ "Backup", "Get", "List", "Purge", "Set", "Recover", "Restore", "Delete" ]
}
variable "certificate_permissions" {
    type    = list(string)
    default = [ "Get", "List", "Recover", "Import", "Delete", "Purge", "Create", "Restore", "Update" ]
}
variable "storage_permissions" {
    type    = list(string)
    default = [ "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "Restore", "RegenerateKey", "Set", "SetSAS", "Update"]
}
