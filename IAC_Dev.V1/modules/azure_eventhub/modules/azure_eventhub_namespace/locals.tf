locals {
  rulesets = {
    for network_ruleset in var.rulesets:
    "${lookup(network_ruleset, "name")}" => {
      default_action = lookup(network_ruleset, "default_action","Deny")
      ip_mask = lookup(network_ruleset, "ip_mask")
      subnet_id = lookup(network_ruleset, "subnet_id")
    }
  }

  identities = {
    for identity in var.identities:
    "${lookup(identity, "name")}" => {
      type = lookup(identity, "type","SystemAssigned")
    }
  }
  
}