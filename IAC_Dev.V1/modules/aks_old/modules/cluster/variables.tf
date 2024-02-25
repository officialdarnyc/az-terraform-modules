variable "resource_group_name" {
    description = "Resource group name"
    type = string
}

variable "location"{
    type        = string
    default     = "eastus"
    description = "Location"
}

variable "aks_cluster_name" {
    description = "AKS cluster name"
    type = string
}

variable "dns_prefix" {
    description = "DNS Prefix"
    type = string
    default = null
}

variable "private_dns_zone_id" {
    description = "Private DNS Zone Id (Required in case of private)"
    type = string
    default = null
}

variable "node_resource_group" {
    description = "DNS Prefix"
    type = string
    default = null
}
variable "private_cluster_enabled" {
    description = "Enable private cluster"
    type = bool
    default = true
}

variable "enable_azure_policy" {
    description = "Enable azure policy"
    type = bool
    default = true
}

variable "enable_pod_security_policy" {
    description = "Enable pod security policy"
    type = bool
    default = false
}

variable "api_server_authorized_ip_ranges" {
    description = "API Server authorized IP Ranges"
    type = string
    default = null
}

variable "kubernetes_version" {
    description = "Kubernetes version"
    type = string
}

variable "default_node_pool" {
    description = "Default node pool configuration"
    type = map(string)
}

variable "http_application_routing_enabled" {
    description = "Enable HTTP Application Routing"
    type = bool
    default = false
}

variable "kube_dashboard_enabled" {
    description = "Enable Kube Dashboard"
    type = bool
    default = false
}

variable "role_based_access_control_enabled" {
    description = "Enable RBAC"
    type = bool
    default = true
}

variable "log_analytics_workspace_id" {
    description = "Log Analytics Workspace Id"
    type = string
    default = null
}

variable "tags"{
    type = map
    default = {}
}

variable "identity_type" {
    type = string
    description = "Identity Type"
    default = "SystemAssigned"
}

variable "user_assigned_identity_id" {
    type = string
    description = "User assigned identity id"
    default = null
}

variable "client_id" {
    type = string
    description = "Service Principal - Client Id"
    default = null
}

variable "client_secret" {
    type = string
    description = "Service Principal - Client Secret"
    default = null
}

variable "linux_admin_user_name" {
    type = string
    description = "Linux Administrator User Name"
    default = null
}

variable "linux_admin_ssh" {
    type = string
    description = "Linux Administrator SSH"
    default = null
}

variable "windows_admin_user_name" {
    type = string
    description = "Windows Administrator User Name"
    default = null
}

variable "windows_admin_user_password" {
    type = string
    description = "Windows Administrator Password"
    default = null
}

variable "network_profile" {
    type = map
    description = "Network profile"
    default = {}
}

variable "repository_name" {
    type = string
    description = "Images repository name"
    default = null
}

variable "attach_repository" {
  type = bool
  description = "Attach repository"
  default = null
}
# variable "node_pool_subnet_id" {
#     description = "Nodepool subnet resource id"
#     # default = null 
#     type = string
# }

variable "vnet_subnet_id" {
  type = any
}


# variable "admin_group_object_ids" {

# }

# variable "ad_auth"{

# }

# variable "kubernetes_client_id" {

# }

# variable "kubernetes_client_secret" {

# }


variable "aks_vm_size" {

}
