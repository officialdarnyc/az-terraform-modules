locals {
    vpn_gateways = {
        for subnet in var.subnets:
            lookup(subnet, "name") => {
                name                                           = tobool(lookup(subnet, "provision_vpn_gateway", "false")) ? "GatewaySubnet" : lookup(subnet, "name")
                address_prefixes                               = split(",", lookup(subnet, "address_prefixes"))
            }
            if (lookup(subnet, "name") == "GatewaySubnet" || tobool(lookup(subnet, "provision_vpn_gateway", "false")) == true) && length(lookup(subnet, "address_prefixes", "")) > 0
    }

    vpn_gateway_name = var.vpn_gateway_name == null ? "vpn-${var.name}" : var.vpn_gateway_name

    subnets = {
        for subnet in var.subnets:
            ((lookup(subnet, "name") == "GatewaySubnet" || tobool(lookup(subnet, "provision_vpn_gateway", "false"))) ? "GatewaySubnet" : lookup(subnet, "name")) => {
                provision_vpn_gateway                                 = tobool(lookup(subnet, "provision_vpn_gateway", "false"))
                name                                           = (lookup(subnet, "name") == "GatewaySubnet" || tobool(lookup(subnet, "provision_vpn_gateway", "false"))) ? "GatewaySubnet" : lookup(subnet, "name")
                address_prefixes                               = split(",", lookup(subnet, "address_prefixes"))
                service_endpoints                              = split(",", lookup(subnet, "service_endpoints", ""))
                enforce_private_link_endpoint_network_policies = tobool(lookup(subnet, "enforce_private_link_endpoint_network_policies", "false"))
            }
    }

    network_security_groups = {
        for subnet in var.subnets:
            lookup(subnet, "nsg_name", "") => {
                nsg_name = lookup(subnet, "nsg_name", "")
            }
        if lookup(subnet, "nsg_name", "") != null && length(lookup(subnet, "nsg_name", "")) > 0
    }

    network_security_group_associations = {
        for subnet in var.subnets:
            "${lookup(subnet, "nsg_name", "")}_${(lookup(subnet, "name") == "GatewaySubnet" || tobool(lookup(subnet, "provision_vpn_gateway", "false"))) ? "GatewaySubnet" : lookup(subnet, "name")}" => {
                subnet_name = (lookup(subnet, "name") == "GatewaySubnet" || tobool(lookup(subnet, "provision_vpn_gateway", "false"))) ? "GatewaySubnet" : lookup(subnet, "name")
                nsg_name = lookup(subnet, "nsg_name", "")
            }
        if lookup(subnet, "nsg_name", null) != null && length(lookup(subnet, "nsg_name", "")) > 0
    }

    nsg_rules = {
        for index, nsg_rule in var.nsg_rules:
            lookup(nsg_rule, "nsg_rule_name", "${lookup(nsg_rule, "nsg_name")}-rule-${index}") => {
                nsg_rule_name                         = lookup(nsg_rule, "nsg_rule_name", "${lookup(nsg_rule, "nsg_name")}-rule-${index}")
                nsg_name                              = lookup(nsg_rule, "nsg_name")
                nsg_rule_priority                     = tonumber(lookup(nsg_rule, "nsg_rule_priority", "100"))
                nsg_rule_direction                    = lookup(nsg_rule, "nsg_rule_direction", "Inbound")
                nsg_rule_access                       = lookup(nsg_rule, "nsg_rule_access", "Allow")
                nsg_rule_protocol                     = lookup(nsg_rule, "nsg_rule_protocol", "*")
                nsg_rule_source_port_range            = null
                nsg_rule_source_port_ranges           = split(",", lookup(nsg_rule, "nsg_rule_source_port_range", lookup(nsg_rule, "nsg_rule_source_port_ranges", "")))
                nsg_rule_destination_port_range       = null
                nsg_rule_destination_port_ranges      = split(",", lookup(nsg_rule, "nsg_rule_destination_port_range", lookup(nsg_rule, "nsg_rule_destination_port_ranges", "")))
                nsg_rule_source_address_prefix        = null
                nsg_rule_source_address_prefixes      = split(",", lookup(nsg_rule, "nsg_rule_source_address_prefix", lookup(nsg_rule, "nsg_rule_source_address_prefixes", "")))
                nsg_rule_destination_address_prefix   = null
                nsg_rule_destination_address_prefixes = split(",", lookup(nsg_rule, "nsg_rule_destination_address_prefix", lookup(nsg_rule, "nsg_rule_destination_address_prefixes", "")))
            }

    }
}