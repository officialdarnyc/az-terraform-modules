module "vpn_gateway" {
    source              = "./modules/vpn_gateway"

    resource_group_name = var.resource_group_name
    location            = var.location
    vpn_gateway_name    = var.vpn_gateway_name
    address_prefix      = var.hub_address_prefix
    tags                = var.tags
}

module "site_to_site" {
    source              = "./modules/site_to_site"
    count               = local.create_site_to_site_connection ? 1 : 0

    resource_group_name = var.resource_group_name
    location            = var.location
    name                = local.site_to_site_connection_name
    virtual_wan_id      = module.vpn_gateway.wan_id
    links               = var.links
    tags                = var.tags

    depends_on = [
        module.vpn_gateway
    ]
}

module "point_to_site" {
    source                  = "./modules/point_to_site"
    count                   = local.create_point_to_site_connection ? 1 : 0
    
    resource_group_name     = var.resource_group_name
    location                = var.location
    point_to_site_conn_name = local.point_to_site_connection_name
    vpn_gateway_hub_id      = module.vpn_gateway.hub_id
    scale_unit              = var.scale_unit
    certificate_data        = var.certificate_data
    vpn_auth_types          = var.vpn_auth_types
    address_prefixes        = var.site_adress_prefixes
    tags                    = var.tags

    depends_on = [
        module.vpn_gateway
    ]
}
