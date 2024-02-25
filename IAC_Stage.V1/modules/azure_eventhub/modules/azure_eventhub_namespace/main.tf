resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                     = var.eventhub_namespace
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku
  capacity                 = var.capacity
  auto_inflate_enabled     = var.auto_inflate_enabled
  dedicated_cluster_id     = var.dedicated_cluster_id
  maximum_throughput_units = var.maximum_throughput_units
  zone_redundant           = var.zone_redundant
  tags                     = var.tags


  dynamic "identity" {
    for_each = local.identities
    content {
    type = identity.value.type
    }
  }

  dynamic "network_rulesets" {
    for_each = local.rulesets
    content {
      default_action = network_ruleset.value.default_action

      ip_rule {
        ip_mask = network_ruleset.value.ip_mask
      }

      virtual_network_rule {
        subnet_id = network_ruleset.value.subnet_id
      }
    }
  }
}