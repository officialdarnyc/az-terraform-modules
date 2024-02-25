variable "subscription_id" {
    type        = string
    description = "Subscription Id"
}

variable "client_id" {
    type        = string
    description = "Client Id"
}

variable "environment" {
    type        = string
    description = "Environment - [production, test, staging, development, ...]"
}

variable "purpose" {
    type        = string
    description = "Purpose - [demonstration, poc, production, ...]"
}

variable "client_name" {
    type        = string
    description = "Client Name"
}

variable "resource_name_prefix" {
    type        = string
    description = "Resource name prefix"
}

variable "resource_group_name" {
    type        = string
    description = "Provide resource group name"
    default     = null
}

variable "location" {
    type        = string
    description = "Provide resource group location"
    default     = "eastus"
}

variable "tags" {
    type = map(string)
    description = "Provide tags for the resource group"
    default = {}
}

variable "virtual_network_name" {
    type        = string
    description = "Virtual network name"
    default     = null
}
variable "aks_cluster_name" {
    type        = string
    description = "AKS Cluster name"
}

variable "repository_name" {
    type        = string
    description = "AKS repository name"
}

variable "virtual_network_address_space" {
    type        = list(string)
    description = "Virtual network address space"
}
variable "client_secret" {
    type        = string
    description = "ACR client_secret"
}

variable "subnets" {
    type        = list(map(string))
    description = "Subnet configuration"
    default     = []
}

variable "nsg_rules" {
    type        = list(map(string))
    description = "Subnet NSG Rules"
    default     = []
}

variable "vpn_gateway_name" {
    type        = string
    description = "VPN gateway name"
    default     = null
}

variable "site_to_site_links" {
    type = list(object({
        type = string
        value = string
    }))
    description = "Provide list of site ip_address/fqdn of local site"
    default = []
}

variable "point_to_site_adress_prefixes" {
    type = list(string)
    description = "Provide Site address_prefixs for remote site"
    default = []
}

variable "point_to_site_vpn_auth_types" {
    type = list(string)
    description = "Provite vpn_auth_types"
    default = []
}

variable "point_to_site_certificate_data" {
    description = "certificate data"
    default = null
}

variable "point_to_site_scale_unit" {
    type = number
    description = "Provite scale_unit"
    default = 1
}

variable "public_ips" {
    type = list(map(string))
    description = "public ips detail"
}

variable "bastion_hosts" {
    type = list(map(string))
    description = "bastion hosts detail"
}

variable "user_managed_identity_name" {
    type = string
    description = "user managed identity name"
}


variable "app_gateway_name" {
    type = string
    description = "value"
}

variable "sku" {
    type = object({
        name = string
        tier = string
        capacity = number
    })
    description = "SKU specification for application gateway resource"
}

variable "gateway_ip_configuration" {
    type = object({
        name = string
    })
    description = "Application gateway ip configuration"
}

variable "backend_address_pool" {
    type = list(object({
        name = string
        type = string
        value = list(string)
    }))
    description = "Backend pool settings list"
}

variable "frontend_port" {
    type = object({
        port = number
        name = string
    })
    description = "Frontend port details"
}

variable "backend_http_settings" {
    type = list(object({
        name = string
        cookie_based_affinity = string
        path = string
        port = number
        protocol = string
        request_timeout = number
        pick_host_name_from_backend_address = bool
        probe_name = string
        host_name = string
    }))
    description = "Backend HTTP settings"
}

variable "probe" {
    type = list(object({
        name = string
        host = string
        port = number
        protocol = string
        path = string
        interval = number
        timeout = number
        unhealthy_threshold = number
        pick_host_name_from_backend_http_settings = bool
        match = object({
            body = string
            status_code = list(string)
        })
    }))
}

variable "frontend_ip_configuration" {
  type = list(object({
    name = string
    private_ip_allocation = string
  }))
}

variable "http_listener" {
    type = list(object({
        name = string
        frontend_ip_configuration_name = string
        frontend_port_name = string
        host_name = string
        protocol = string
        ssl_certificate_name = string
    }))
    description = "HTTP listener settings"
}

variable "url_path_map" {
    type = list(object({
        name = string
        default_backend_address_pool_name = string
        default_backend_http_settings_name = string
        path_rule = list(object({
            name = string
            paths = list(string)
            backend_address_pool_name = string
            backend_http_settings_name = string
        }))
    }))
    description = "URL path map of Path based routing rules"
}

variable "request_routing_rule" {
    type = list(object({
        name = string
        rule_type = string
        http_listener_name = string
        backend_address_pool_name = string
        backend_http_settings_name = string
        url_path_map_name = string
    }))
    description = "Request routing rule configuration"
}

variable "app_gateway_frontend_ip_config_pip" {
  type = string
}

variable "app_gateway_ip_configuration_vnet" {
  type = string
}

variable "app_gateway_ip_configuration_subnet" {
  type = string
}

variable "firewall_policyname"{
    type = string
    description = "firewall_policyname"
}

variable "firewall_policy_sku"{
    type = string
    description = "firewall_policy_sku"
}

variable "firewall_name"{
    type = string
    description = "firewall_name"
}

variable "firewall_sku_name"{
    type = string
    description = "firewall_sku_name"
}

variable "sku_tier"{
    type = string
    description = "sku_tier"
}

variable "fw_ip_config_name"{
    type = string
    description = "fw_ip_config_name"
}

variable "fw_ip_config_vnet"{
    type = string
    description = "fw_ip_config_vnet"
}

variable "fw_ip_config_subnet"{
    type = string
    description = "fw_ip_config_subnet"
}

variable "fw_ip_config_pip"{
    type = string
    description = "fw_ip_config_pip"
}

variable "network_peerings" {
    type        = list(map(string))
    description = "network_peerings"
    default     = []
}

variable "route_table_name" {
    type = string
    description = "route_table_name"
}

variable "routes" {
    type = list(map(string))
    description = "route_table_name"
}

variable "firewall_policy_rule_name" {
    type = string
    description = "firewall_policy_rule_name"
}

variable "firewall_policy_rule_priority" {
    type = string
    description = "firewall_policy_rule_priority"
}

variable "application_rule_collection" {
    description = "application_rule_collection"
}

variable "network_rule_collection" {
    description = "network_rule_collection"
}

variable "nat_rule_collection" {
    description = "nat_rule_collection"
}

variable "front_door_name" {
    type        = string
    description = "Name for Azure FrontDoor resource"
}
variable "default_policy_name" {
    type = string
    description = "Default policy name"
    default = null
}
variable "routing_rules" {
    type = list(object({
        name = string
        accepted_protocols = string
        patterns_to_match = string        
        enabled = string
        backend_pool_name =string 
        backend_route = string
        frontend_route = string
    }))
    description = "Request routing rule configuration"
}

variable "waf_policies" {
    type = list(object({
        name = string
        enabled = string
     }))
    description = "Waf policy configuration"
}

variable "kubernetes_version" {
    type        = string
    description = "AKS Version"    
}

variable "network_profile" {
    type = map
    description = "Network profile"
    default = {}
}

variable "azure_container_registry_sku"{
    type = string
    description = "Provide the ACR sku."
    default = null
}

variable "admin_enabled" {
    type = bool
    description = "Admin access enabled"
    default = false
}
