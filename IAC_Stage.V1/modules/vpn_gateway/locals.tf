locals {
    create_site_to_site_connection = var.links != null && length(var.links == null ? [] : var.links) > 0 ? true : false

    site_to_site_connection_name = var.site_to_site_connection_name == null ? "sts-conn-${var.vpn_gateway_name}" : var.site_to_site_connection_name

    create_point_to_site_connection = local.create_site_to_site_connection == false && var.site_adress_prefixes != null && length(var.site_adress_prefixes == null ? [] : var.links) > 0 ? true : false

    point_to_site_connection_name = var.point_to_site_connection_name == null ? "pts-conn-${var.vpn_gateway_name}" : var.point_to_site_connection_name

}