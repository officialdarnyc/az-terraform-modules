variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "ingress_name" {
    type = string
    description = "Ingress name"
}

variable "namespace_name" {
    type = string
    description = "Namespace name"
}

variable "service_port" {
    type = number
    description = "Service port"
}

variable "secret_name" {
    type = string
    description = "Secret name"
}

variable "host_name" {
    type = string
    description = "Host name"
}

variable "path" {
    type = string
    description = "Service path"
    default = "/"
}

variable "rewrite_path_enabled" {
    type = bool
    description = "Host name"
    default = null
}

variable "deployment_path" {
    type = string
    description = "Service path"
    default = null
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}

variable "additional_ports" {
    type = list(map(string))
    description = "Additional ports. Every config should contain three keys - name, path & ingress_port:"
    default = []
}
variable "annotations" {
    type = list(map(string))
    description = "Annotations"
    default = null
}