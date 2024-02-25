variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "resource_type" {
    type = string
    description = "Resource type"
}

variable "options" {
#    type = map
    description = "Resource options"
}

variable "cleanup" {
    type = bool
    description = "Cleanup resources"
    default = true
}

variable "template_path" {
    type = string
    description = "Template path"
    default = null
}

variable "template_name" {
    type = string
    description = "Template name"
    default = null
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}
