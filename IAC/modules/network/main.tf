module "virtual_network" {
    source  = "./modules/vnet"

    name                          = var.name
    resource_group_name           = var.resource_group_name
    location                      = var.location
    address_space                 = var.address_space
    dns_servers                   = var.dns_servers

    tags                          = var.tags
}

module "subnet" {
    source                                         = "./modules/subnet"
    for_each                                       = local.subnets

    name                                           = each.key
    address_prefixes                               = each.value.address_prefixes
    resource_group_name                            = var.resource_group_name
    virtual_network_name                           = var.name
    service_endpoints                              = each.value.service_endpoints
    enforce_private_link_endpoint_network_policies = each.value.enforce_private_link_endpoint_network_policies
    depends_on = [
        module.virtual_network
    ]
}

module "network_security_group" {
    source                       = "./modules/network_security_group"
    for_each                     = local.network_security_groups

    network_security_group_name  = each.value.nsg_name
    location                     = var.location
    resource_group_name          = var.resource_group_name
    tags                         = var.tags
    depends_on = [
        module.virtual_network,
        module.subnet
    ]
}

module "network_security_group_subnet_association" {
    source                     = "./modules/network_security_group_subnet_association"
    for_each                   = local.network_security_group_associations
    subnet_id                  = module.subnet[each.value.subnet_name].id
    network_security_group_id  = module.network_security_group[each.value.nsg_name].id
    depends_on = [
        module.network_security_group,
        module.nsg_rule_config
    ]
}

module "nsg_rule_config" {
    source                                = "./modules/network_security_rule"
    for_each                              = local.nsg_rules
 
    resource_group_name                   = var.resource_group_name
    network_security_group_name           = each.value.nsg_name
    nsg_rule_name                         = each.value.nsg_rule_name
    nsg_rule_priority                     = each.value.nsg_rule_priority
    nsg_rule_direction                    = each.value.nsg_rule_direction
    nsg_rule_access                       = each.value.nsg_rule_access
    nsg_rule_protocol                     = each.value.nsg_rule_protocol
    nsg_rule_source_port_range            = each.value.nsg_rule_source_port_range
    nsg_rule_source_port_ranges           = each.value.nsg_rule_source_port_ranges
    nsg_rule_destination_port_range       = each.value.nsg_rule_destination_port_range
    nsg_rule_destination_port_ranges      = each.value.nsg_rule_destination_port_ranges
    nsg_rule_source_address_prefix        = each.value.nsg_rule_source_address_prefix
    nsg_rule_source_address_prefixes      = each.value.nsg_rule_source_address_prefixes
    nsg_rule_destination_address_prefix   = each.value.nsg_rule_destination_address_prefix
    nsg_rule_destination_address_prefixes = each.value.nsg_rule_destination_address_prefixes

    depends_on = [
        module.network_security_group
    ]
}

module "vpn_gateway" {
    source               = "../vpn_gateway"
    for_each             = local.vpn_gateways

    resource_group_name  = var.resource_group_name
    location             = var.location
    vpn_gateway_name     = local.vpn_gateway_name
    hub_address_prefix   = each.value.address_prefixes[0]
    tags                 = var.tags

    links                = var.site_to_site_links

    site_adress_prefixes = var.point_to_site_adress_prefixes
    vpn_auth_types       = var.point_to_site_vpn_auth_types
    certificate_data     = var.point_to_site_certificate_data
    scale_unit           = var.point_to_site_scale_unit
    depends_on = [
        module.virtual_network,
        module.subnet
    ]
}

module "network_peering" {
    for_each                      = {for network_peering in var.network_peerings:  network_peering.peering_name => network_peering}
    source                        = "./modules/network_peering"

    peering_name                  = each.value.peering_name
    resource_group_name           = each.value.resource_group_name
    virtual_network_name          = each.value.vnet_name
    remote_virtual_network_id     = each.value.destination_vnet_id
    allow_forwarded_traffic       = each.value.allow_forwarded_traffic
    allow_gateway_transit         = each.value.allow_gateway_transit
    use_remote_gateways           = each.value.use_remote_gateways
    
    depends_on = [
        module.virtual_network,
        module.subnet
    ]
}