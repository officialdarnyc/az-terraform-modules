variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "service_name" {
    type = string
    description = "Service name"
}

variable "namespace_name" {
    type = string
    description = "Namespace name"
}

variable "port" {
    type = number
    description = "Port"
}

variable "target_port" {
    type = number
    description = "Target Port"
}

variable "additional_ports" {
    type = list(map(string))
    description = "Additional ports. Every config should contain three keys - name, deployment_port & ingress_port:"
    default = []
}
variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}
