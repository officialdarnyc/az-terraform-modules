resource "azurerm_frontdoor" "afd" {
    name                                         = var.front_door_name
    resource_group_name                          = var.resource_group_name
    enforce_backend_pools_certificate_name_check = var.enforce_backend_pools_certificate_name_check
    load_balancer_enabled                        = var.load_balancer_enabled

    dynamic "routing_rule" {
        for_each = local.routing_rules
        content {
            name                = routing_rule.value.name
            accepted_protocols  = routing_rule.value.accepted_protocols
            patterns_to_match   = routing_rule.value.patterns_to_match
            frontend_endpoints  = routing_rule.value.frontend_endpoints
            enabled             = routing_rule.value.enabled

            forwarding_configuration {
                forwarding_protocol    = routing_rule.value.forwarding_protocol
                backend_pool_name      = routing_rule.value.backend_pool_name
                custom_forwarding_path = routing_rule.value.forwarding_path
            }
        }
    }
    
    dynamic "backend_pool_load_balancing" {
        for_each = local.backend_pool_load_balancings
        content {
            name = backend_pool_load_balancing.value.name
        }
    }

    dynamic "backend_pool_health_probe" {
        for_each = local.backend_pool_health_probes
        content {
            name         = backend_pool_health_probe.value.name
            path         = backend_pool_health_probe.value.path
            probe_method = backend_pool_health_probe.value.probe_method
            protocol     = backend_pool_health_probe.value.protocol
        }
    }

    dynamic "backend_pool" {
        for_each = local.backend_pools
        content {
            name = backend_pool.value.name
            backend {
                host_header = backend_pool.value.host_header
                address     = backend_pool.value.address
                http_port   = backend_pool.value.http_port
                https_port  = backend_pool.value.https_port
                weight      = backend_pool.value.weight
            }
            load_balancing_name = backend_pool.value.load_balancing_name
            health_probe_name   = backend_pool.value.health_probe_name
        }
    }

    dynamic "frontend_endpoint" {
        for_each = local.frontend_endpoints
        content {
            name      = frontend_endpoint.value.name
            host_name = frontend_endpoint.value.host_name
            web_application_firewall_policy_link_id = frontend_endpoint.value.policy_id
        }
    }

    tags = var.tags
}