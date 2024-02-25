variable "resource_group_name" {
    type = string
    description = "Resource group name of Network Security Group"
}

variable "subscription_id" {
    type        = string
    description = "Subscription Id"
}

variable "location" {
    type = string
    description = "Regional location of resource"
}

variable "user_managed_identity_name"{
    type = string
    description = "user managed identity name"
}


/*variable "keyvault_name" {
    type = string
    description = "Name of KeyVault"
}
variable "keyvault_secret_name" {
    type = list(string)
    description = "Name of SSL certificate names in keyVault"
}

variable "ssl_certificate_name" {
    type = string
    description = "Name of SSL certificate stored in keyVault"
}*/

variable "app_gateway_name" {
    type = string
    description = "Application Gateway Name"
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

variable "app_gateway_frontend_ip_config_pip" {
  type = string
}

variable "app_gateway_ip_configuration_vnet" {
  type = string
}

variable "app_gateway_ip_configuration_subnet" {
  type = string
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

variable "tags"{
    description = "Provide tags for application gateway"
}

