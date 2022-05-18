module "resource_group" {
    source              = "../../modules/resource_group"

    resource_group_name = var.resource_group_name
    location            = var.location
    tags                = var.tags
}

module "network" {
    source = "../../modules/network"
    subscription_id                = var.subscription_id
    resource_group_name            = var.resource_group_name
    location                       = var.location
    name                           = var.virtual_network_name
    address_space                  = var.virtual_network_address_space
    subnets                        = var.subnets
    nsg_rules                      = var.nsg_rules

    vpn_gateway_name               = var.vpn_gateway_name
    site_to_site_links             = var.site_to_site_links
    point_to_site_adress_prefixes  = var.point_to_site_adress_prefixes
    point_to_site_vpn_auth_types   = var.point_to_site_vpn_auth_types
    point_to_site_certificate_data = var.point_to_site_certificate_data
    point_to_site_scale_unit       = var.point_to_site_scale_unit

    network_peerings               = var.network_peerings

    tags                           = var.tags

    depends_on = [
        module.resource_group
    ]
}

module "azure_public_ip" {
    for_each                       = {for public_ip in var.public_ips:  public_ip.pip_name => public_ip} 
    source                         = "../../modules/azure_public_ip"
    resource_group_name            = var.resource_group_name
    location                       = var.location
    public_ip_name                 = each.value.pip_name
    allocation_method              = each.value.allocation_method
    sku                            = each.value.sku

    tags                           = var.tags

    depends_on = [
        module.resource_group
    ]
}

module "azure_bastion" {
    for_each                       = {for bastion_host in var.bastion_hosts:  bastion_host.bastion_host_name => bastion_host} 
    source                         = "../../modules/azure_bastion"
    resource_group_name            = var.resource_group_name
    location                       = var.location
    bastion_name                   = each.value.bastion_host_name
    ip_configuration_name          = each.value.pip_name
    subnet_id                      = module.network.subnet_id[each.value.subnet_name]
    public_ip_address_id           = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${each.value.pip_name}"
    tags                           = var.tags

    depends_on = [
        module.network,
        module.azure_public_ip
    ]
}

module "aks" {
    source                           = "../../modules/aks"     
    resource_group_name              = var.resource_group_name
    location                         = var.location
    aks_cluster_name                 = var.aks_cluster_name
    kubernetes_version               = var.kubernetes_version
    repository_name                  = var.repository_name
    node_pools                       = [
        {
        name="systemnp"
        },
        {
            name="workernp"            
        }
    ]
    tags = var.tags
    namespaces                       = [
        {
            name = "frontend"
        },
        {
            name = "workload"
        }
    ]
    attach_repository                = false
    log_analytics_workspace_id       = null
    client_id                        = var.client_id
    client_secret                    = var.client_secret
    node_pool_subnet_id              = lookup(module.network.subnet_id, "default", null)

}



module "application_gateway" {
    source                         = "../../modules/application_gateway"

    resource_group_name            = var.resource_group_name
    location                       = var.location
    user_managed_identity_name     = var.user_managed_identity_name
    app_gateway_name               = var.app_gateway_name
    sku                            = var.sku
    gateway_ip_configuration       = var.gateway_ip_configuration
    backend_address_pool           = var.backend_address_pool
    frontend_port                  = var.frontend_port
    backend_http_settings          = var.backend_http_settings
    probe                          = var.probe
    frontend_ip_configuration      = var.frontend_ip_configuration
    http_listener                  = var.http_listener
    url_path_map                   = var.url_path_map
    request_routing_rule           = var.request_routing_rule
    subscription_id                = var.subscription_id
    app_gateway_frontend_ip_config_pip = var.app_gateway_frontend_ip_config_pip
    app_gateway_ip_configuration_vnet = var.app_gateway_ip_configuration_vnet
    app_gateway_ip_configuration_subnet = var.app_gateway_ip_configuration_subnet
    tags                           = var.tags

    depends_on = [
        module.resource_group,
        module.network,
        module.azure_public_ip
    ]
}

module "firewall" {
    source                          = "../../modules/firewall"

    resource_group_name             = var.resource_group_name
    location                        = var.location
    firewall_policyname             = var.firewall_policyname
    firewall_policy_sku             = var.firewall_policy_sku

    firewall_name                   = var.firewall_name
    firewall_sku_name               = var.firewall_sku_name
    sku_tier                        = var.sku_tier
    fw_ip_config_name               = var.fw_ip_config_name
    fw_ip_config_subnet_id          = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.fw_ip_config_vnet}/subnets/${var.fw_ip_config_subnet}"
    fw_ip_config_pipid              = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/publicIPAddresses/${var.fw_ip_config_pip}"

    firewall_policy_rule_name       = var.firewall_policy_rule_name
    firewall_policy_rule_priority   = var.firewall_policy_rule_priority
    application_rule_collection     = var.application_rule_collection
    network_rule_collection         = var.network_rule_collection
    nat_rule_collection             = var.nat_rule_collection
}

module "route_table" {
    source                          = "../../modules/route_table"

    resource_group_name             = var.resource_group_name
    location                        = var.location
    route_table_name                = var.route_table_name
    routes                          = var.routes
}

module "azure_front_door" {
    source                          = "../../modules/azure_front_door"

    front_door_name                 = var.front_door_name
    resource_group_name             = var.resource_group_name
    default_policy_name             = var.default_policy_name
    routing_rules                   = var.routing_rules
    waf_policies                    = var.waf_policies
}

