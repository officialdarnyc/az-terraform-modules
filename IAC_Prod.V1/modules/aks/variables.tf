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

variable "repository_name" {
    type = string
    description = "Images repository name"
    default = null
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
    default = false
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
    default = null
}
variable "ingress_settings" {
    type = map(string)
    description = "Ingress settings required to customize the setup"
    default = {
      "enabled" = "false"
      "ip_allocation" = "Dynamic"
      "dns_prefix" = "xcc"
    }
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

variable "node_pools" {
    type = list(map(string))
    description = "Node pools"
    default = []
}

variable "namespaces" {
    type = list(map(string))
    description = "Namespaces"
    default = []
}

variable "secrets" {
  type = list(map(string))
  description = "secrets for k8s"
  default = []
}

variable "services" {
    type = list(map(string))
    description = "Services"
    default = []
}

variable "services_tolerations" {
    type = map
    description = "Provide tolerations"
    default = {}
}

variable "services_environment_variables" {
  type = map
  description = "Environment variables"
  default = {}
}

variable "services_persistent_volumes" {
  type = map
  description = "Services Persistent Volumes"
  default = {}
}

variable "jobs" {
    type = list(map(string))
    description = "Jobs"
    default = []
}

variable "cronjobs" {
#    type = list(map(string))
    description = "Jobs"
    default = []
}

variable "jobs_environment_variables" {
  type = map
  description = "Environment variables"
  default = {}
}

variable "jobs_tolerations" {
    type = map
    description = "Provide tolerations"
    default = {}
}

variable "jobs_persistent_volumes" {
  type = map
  description = "Jobs Persistent Volumes"
  default = {}
}

variable "global_environment_variables" {
  type = list(map(string))
  description = "Global Environment variables"
  default = []
}

variable "load_balancer_name" {
  type = string
  description = "Load balancer name"
  default = null
}

variable "load_balancer_public_ip_label" {
  type = string
  description = "Load balancer public ip label"
  default = null
}

variable "attach_repository" {
  type = bool
  description = "Attach repository. Should be passed as false, if you do not have owner rights."
  default = null
}

variable "node_pool_subnet_id" {
  type = string
  description = "Default node pool subnet id"
  default = null
}

variable "load_balancer_template_file_name" {
  type = string
  description = "Load balancer template file name"
  default = null
}


variable "attach_diagnostic_settings"{
    type        = bool
    default     = null
    description = "Attach diagnostic settings"
}

