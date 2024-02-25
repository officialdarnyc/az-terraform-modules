locals {
    backend_pool_load_balancings = {
        for routing_rule in var.routing_rules:
            "${lookup(routing_rule, "name")}-bplb" => {
                name = lookup(routing_rule, "load_balancer_name", "${lookup(routing_rule, "name")}-bplb")
            }
    }

    backend_pool_health_probes = {
        for routing_rule in var.routing_rules:
            "${lookup(routing_rule, "name")}-bphb" => {
                name = lookup(routing_rule, "health_probe_name", "${lookup(routing_rule, "name")}-bphb")
                path = lookup(routing_rule, "health_probe_path", "/")
                probe_method = lookup(routing_rule, "health_probe_method", "GET")
                protocol = lookup(routing_rule, "health_probe_protocol", "Http")
            }
    }

    backend_pools = {
        for routing_rule in var.routing_rules:
            "${lookup(routing_rule, "name")}-bp" => {
                name = lookup(routing_rule, "backend_pool_name", "${lookup(routing_rule, "name")}-bp")
                host_header = lookup(routing_rule, "host_header", lookup(routing_rule, "backend_route"))
                address = lookup(routing_rule, "address", lookup(routing_rule, "backend_route"))
                http_port = tonumber(lookup(routing_rule, "http_port", "80"))
                https_port = tonumber(lookup(routing_rule, "https_port", "443"))
                weight = tonumber(lookup(routing_rule, "weight", "100"))
                load_balancing_name = lookup(routing_rule, "load_balancer_name", "${lookup(routing_rule, "name")}-bplb")
                health_probe_name = lookup(routing_rule, "health_probe_name", "${lookup(routing_rule, "name")}-bphb")
            }        
    }

    frontend_endpoints = {
        for routing_rule in var.routing_rules:
            "${lookup(routing_rule, "name")}-fep" => {
                name = lookup(routing_rule, "frontend_endpoint_name", "${lookup(routing_rule, "name")}-fep")
                host_name = lookup(routing_rule, "frontend_route")
                policy_id = lookup(routing_rule, "policy_id", var.default_policy_id)
            }
    }

    routing_rules = {
        for routing_rule in var.routing_rules:
            lookup(routing_rule, "name") => {
                name = lookup(routing_rule, "name")
                accepted_protocols = split(",", lookup(routing_rule, "accepted_protocols", "Http,Https"))
                patterns_to_match = split(",", lookup(routing_rule, "patterns_to_match", "/*"))
                frontend_endpoints = [ lookup(routing_rule, "frontend_endpoint_name", "${lookup(routing_rule, "name")}-fep") ]
                enabled = tobool(lookup(routing_rule, "enabled", "true"))
                backend_pool_name = lookup(routing_rule, "backend_pool_name", "${lookup(routing_rule, "name")}-bp")
                forwarding_protocol = lookup(routing_rule, "forwarding_protocol", "MatchRequest")
                forwarding_path = lookup(routing_rule, "forwarding_path", "")
            }
    }
}