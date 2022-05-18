locals {
    additional_ports = [
        for indx, additional_port in var.additional_ports: {
            name = lookup(additional_port, "name", null)
            port = lookup(additional_port, "ingress_port", null)
            target_port = lookup(additional_port, "deployment_port", null)
            type = lookup(additional_port, "type", "TCP")
        }
        if lookup(additional_port, "name", null) != null && lookup(additional_port, "ingress_port", null) != null && lookup(additional_port, "ingress_port", var.port) != var.port && lookup(additional_port, "deployment_port", null) != null && lookup(additional_port, "deployment_port", var.target_port) != var.target_port
    ]
}