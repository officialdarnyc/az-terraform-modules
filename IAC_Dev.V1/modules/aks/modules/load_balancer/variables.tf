variable "resource_group_name" {
    type = string
    description = "Resource group name"
}

variable "aks_cluster_name" {
    type = string
    description = "AKS cluster name"
}

variable "loadbalancer_name" {
    type = string
    description = "Load balancer name"
}

variable "ip_address" {
    type = string
    description = "Load balancer IP Address"
}

variable "port" {
    type = number
    description = "Load balancer Port"
    default = 80
}

variable "template_file_name" {
    type = string
    description = "Template file"
    default = null
}
