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

module "acr" {
    source                        = "../../modules/container_registry"
    resource_group_name           = var.resource_group_name
    location                      = var.location
    azure_container_registry_name = var.repository_name
    azure_container_registry_sku  = var.azure_container_registry_sku
    admin_enabled                 = var.admin_enabled
    tags                          = var.tags
    depends_on = [
        module.resource_group
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
    attach_repository                = true
    log_analytics_workspace_id       = null
    attach_diagnostic_settings       = null
    client_id                        = null
    client_secret                    = null
    node_pool_subnet_id              = lookup(module.network.subnet_id, "snet-aks-dev-eastus-001", null)

    network_profile = var.network_profile

    depends_on = [module.network,module.acr]
}
