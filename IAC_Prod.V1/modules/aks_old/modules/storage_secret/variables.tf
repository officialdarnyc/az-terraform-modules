variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "namespace_name" {
    type = string
    description = "Namespace name"
    default = "default"
}

variable "secret_name" {
    type = string
    description = "Secret name"
}

variable "storage_account_name" {
    type = string
    description = "Storage Account Name"
}  

variable "storage_account_key" {
    type = string
    description = "Storage Account Key"
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}

