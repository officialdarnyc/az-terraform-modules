locals {
    service_name = var.service_name
    deployment_name = var.deployment_name == null ? var.service_name : var.deployment_name
    ingress_name = var.ingress_name == null ? var.service_name : var.ingress_name
    ingress_namespace_name = var.ingress_namespace_name == null ? var.namespace_name : var.ingress_namespace_name
    deployment_namespace_name = var.deployment_namespace_name == null ? var.namespace_name : var.deployment_namespace_name
    ingress_path = var.ingress_path == null ? "/" : var.ingress_path
    liveness_probe_path = var.liveness_probe_path == null ? "/" : var.liveness_probe_path
    readiness_probe_path = var.readiness_probe_path == null ? "/" : var.readiness_probe_path
    lb_ip_file_name = "${local.ingress_name}.ip"

    deployment_port = var.deployment_port == null ? "" : "${ var.deployment_port }"
    ingress_port = var.ingress_port == null ? "" : "${ var.ingress_port }"

    annotations = [
        for index, annotation in split(",", var.annotations == null ? "" : var.annotations):
            {
                key   = concat(split(":", annotation), [""])[0]
                value = concat(split(":", annotation), [""])[1]
            }
        if length(annotation) > 0 && length(concat(split(":", annotation), [""])[0]) > 0 && length(concat(split(":", annotation), [""])[1]) > 0 
    ]

    temp_additional_ports = [
        for index, port_config in split(",", var.additional_ports == null ? "" : var.additional_ports):
            {
                name            = split("#", port_config)[0]
                path            = concat(split(":", concat(split("#", port_config), [""])[1]), [ null, null ])[0]
                deployment_port = concat(split(":", concat(split("#", port_config), [""])[1]), [ null, null ])[1]
                ingress_port    = concat(split(":", concat(split("#", port_config), [""])[1]), [ null, null ])[2]
            }
        if length(port_config) > 0
    ]
    
    additional_ports = [
        for index, additional_port in local.temp_additional_ports:
            additional_port
        if length(additional_port.name) > 0 && length(additional_port.path) > 0
    ]
}
