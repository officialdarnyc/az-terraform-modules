module "azure_user_assigned_identity" {
    source = "./modules/azure_user_assigned_identity"

    resource_group_name         = var.resource_group_name
    location                    = var.location
    user_managed_identity_name  = var.user_managed_identity_name
    tags                        = var.tags
}

module "azure_application_gateway" {
    source = "./modules/azure_application_gateway"

    resource_group_name             = var.resource_group_name
    location                        = var.location
    user_managed_identity_name      = var.user_managed_identity_name
    app_gateway_name                = var.app_gateway_name
    sku                             = var.sku
    gateway_ip_configuration        = var.gateway_ip_configuration
    backend_address_pool            = var.backend_address_pool
    frontend_port                   = var.frontend_port
    backend_http_settings           = var.backend_http_settings
    probe                           = var.probe
    frontend_ip_configuration       = var.frontend_ip_configuration
    app_gateway_frontend_ip_config_pip = var.app_gateway_frontend_ip_config_pip
    app_gateway_ip_configuration_vnet = var.app_gateway_ip_configuration_vnet
    app_gateway_ip_configuration_subnet = var.app_gateway_ip_configuration_subnet
    http_listener                   = var.http_listener
    url_path_map                    = var.url_path_map
    request_routing_rule            = var.request_routing_rule
    identity_ids                    = [module.azure_user_assigned_identity.id]
    subscription_id                 = var.subscription_id
    tags = var.tags

    depends_on = [
      module.azure_user_assigned_identity
    ]
}