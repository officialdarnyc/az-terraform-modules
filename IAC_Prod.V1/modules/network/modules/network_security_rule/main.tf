resource "azurerm_network_security_rule" "rule" {
  name                         = var.nsg_rule_name
  priority                     = var.nsg_rule_priority
  direction                    = var.nsg_rule_direction
  access                       = var.nsg_rule_access
  protocol                     = var.nsg_rule_protocol
  source_port_range            = length(var.nsg_rule_source_port_ranges) > 0 ? null : var.nsg_rule_source_port_range
  source_port_ranges           = length(var.nsg_rule_source_port_ranges) > 0 ? var.nsg_rule_source_port_ranges : null
  destination_port_range       = length(var.nsg_rule_destination_port_ranges) > 0 ? null: var.nsg_rule_destination_port_range
  destination_port_ranges      = length(var.nsg_rule_destination_port_ranges) > 0 ? var.nsg_rule_destination_port_ranges: null
  source_address_prefix        = length(var.nsg_rule_source_address_prefixes) > 0 ? null: var.nsg_rule_source_address_prefix
  source_address_prefixes      = length(var.nsg_rule_source_address_prefixes) > 0 ? var.nsg_rule_source_address_prefixes : null
  destination_address_prefix   = var.nsg_rule_destination_address_prefix
  destination_address_prefixes = var.nsg_rule_destination_address_prefixes
  resource_group_name          = var.resource_group_name
  network_security_group_name  = var.network_security_group_name
}
