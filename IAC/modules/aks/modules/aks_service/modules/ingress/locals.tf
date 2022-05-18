locals {
    annotations = var.annotations == null ? [] : var.annotations
    additional_ports = [
        for indx, additional_port in var.additional_ports: {
            name = lookup(additional_port, "name", null)
            service_port = lookup(additional_port, "ingress_port", lookup(additional_port, "service_port", "${var.service_port}")) == null ? "${var.service_port}" : lookup(additional_port, "ingress_port", lookup(additional_port, "service_port", "${var.service_port}"))
            path = local.rewrite_path_enabled ? "${lookup(additional_port, "path", "")}/(.*)" : lookup(additional_port, "path", "")
        }
        if lookup(additional_port, "name", null) != null && lookup(additional_port, "path", null) != null
    ]
    not_null_deployment_path = var.deployment_path == null || length(var.deployment_path == null ? "" : var.deployment_path) == 0 ? "/" : var.deployment_path
    
    sanitized_deployment_path = "${local.not_null_deployment_path}${substr(local.not_null_deployment_path, -1, -1) == "/" ? "" : "/"}$1"

    deployment_path_overrided = (var.deployment_path != null && var.deployment_path != "" && var.deployment_path != var.path)

    rewrite_path_enabled = var.rewrite_path_enabled == null ? ((var.path != "/" || local.deployment_path_overrided) ? true : false) : var.rewrite_path_enabled

    rewrite_annotation = local.rewrite_path_enabled ? "nginx.ingress.kubernetes.io/rewrite-target: ${local.sanitized_deployment_path}" : ""
    
    path = local.rewrite_path_enabled ? "${var.path}/(.*)" : var.path
}
