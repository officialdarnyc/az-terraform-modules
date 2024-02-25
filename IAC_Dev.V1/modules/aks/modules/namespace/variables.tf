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
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}
