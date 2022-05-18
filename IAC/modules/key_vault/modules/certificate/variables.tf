variable "key_vault_id" {
    type = string
    description = "Provide azure resource id for keuvault"
}
variable "certificate_name" {
    type = string
    description = "Provide certificate name(pfx file type)"
}
variable "issuer" {
    type = string
    description = "Provide issuer of the certificate"
    default = "Self"
}
variable "certificate_file_name" {
    type = string
    description = "Provide PFX certificate file path"
}
variable "certificate_file_credentials" {
    type = string
    description = "Provide PFX certificate file password"
}
variable "properties" {
    type = object({
        content_type    = string
        exportable      = bool
        key_size        = number
        key_type        = string
        reuse_key       = bool
    })
    default = {
        content_type  = "application/x-pkcs12"
        exportable    = true
        key_size      = 2048
        key_type      = "RSA"
        reuse_key     = false
    }
    description = "Provide certificate file properties"
}
