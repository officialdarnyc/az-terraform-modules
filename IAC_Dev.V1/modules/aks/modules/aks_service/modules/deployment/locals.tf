locals {
    additional_ports = [
        for indx, additional_port in var.additional_ports: {
            name = lookup(additional_port, "name", null)
            port = lookup(additional_port, "deployment_port", null)
            type = lookup(additional_port, "type", "TCP")
        }
        if lookup(additional_port, "name", null) != null && lookup(additional_port, "deployment_port", null) != null && lookup(additional_port, "deployment_port", var.port) != var.port
    ]
    tolerations = [
        for indx, toleration in var.tolerations: {
            key = lookup(toleration, "key", null)
            value = lookup(toleration, "value", null)
            operator = lookup(toleration, "operator", "Equal")
            effect = lookup(toleration, "effect", "NoSchedule")
        }
        if lookup(toleration, "key", null) != null && lookup(toleration, "value", null) != null
    ]
    environment_variables = [
        for indx, environment_variable in var.environment_variables: {
            key = lookup(environment_variable, "key", null)
            value = lookup(environment_variable, "value", null)
        }
        if lookup(environment_variable, "key", null) != null && lookup(environment_variable, "value", null) != null
    ]

    not_null_persistent_volumes = var.persistent_volumes == null ? [] : var.persistent_volumes

    persistent_volumes = [
        for indx, persistent_volume in local.not_null_persistent_volumes: {
            name = lookup(persistent_volume, "name", "")
            secret_name = lookup(persistent_volume, "secret_name", "")
            read_only = lookup(persistent_volume, "read_only", "true")
            share_name = lookup(persistent_volume, "share_name", "")
            mount_path = lookup(persistent_volume, "mount_path", "")
            sub_path   = lookup(persistent_volume, "sub_path", "")
        }
        if lookup(persistent_volume, "name", null) != null && lookup(persistent_volume, "mount_path", null) != null && lookup(persistent_volume, "share_name", null) != null
    ]


    timezone = length(var.timezone == null ? "" : var.timezone) == 0 ? "tz${lower(replace(var.timezone_location == null ? "" : var.timezone_location, "/", "-"))}" : var.timezone

    configure_timezone = length(local.timezone) > 0 && length(var.timezone_location == null ? "" : var.timezone_location) > 0

    timezone_name       = local.configure_timezone ? "- name: ${local.timezone}" : ""
    timezone_mount_path = local.configure_timezone ? "  mountPath: /etc/localtime" : ""
    timezone_host_path  = local.configure_timezone ? "  hostPath:" : ""
    timezone_local_path = local.configure_timezone ? "    path: ${var.timezone_location}" : ""

    max_cpu    = var.max_cpu == null || var.max_cpu == ""       ? "" : "cpu: ${var.max_cpu}"
    max_memory = var.max_memory == null || var.max_memory == "" ? "" : "memory: ${var.max_memory}"
    min_cpu    = var.min_cpu == null || var.min_cpu == ""       ? "" : "cpu: ${var.min_cpu}"
    min_memory = var.min_memory == null || var.min_memory == "" ? "" : "memory: ${var.min_memory}"

    readiness_probe_period            = var.readiness_probe_period == null || var.readiness_probe_period == ""                       ? "" : "periodSeconds: ${var.readiness_probe_period}"
    readiness_probe_timeout           = var.readiness_probe_timeout == null || var.readiness_probe_timeout == ""                     ? "" : "timeoutSeconds: ${var.readiness_probe_timeout}"
    readiness_probe_failure_threshold = var.readiness_probe_failure_threshold == null || var.readiness_probe_failure_threshold == "" ? "" : "failureThreshold: ${var.readiness_probe_failure_threshold}"
    liveness_probe_period             = var.liveness_probe_period == null || var.liveness_probe_period == ""                         ? "" : "periodSeconds: ${var.liveness_probe_period}"
    liveness_probe_timeout            = var.liveness_probe_timeout == null || var.liveness_probe_timeout == ""                       ? "" : "timeoutSeconds: ${var.liveness_probe_timeout}"
    liveness_probe_failure_threshold  = var.liveness_probe_failure_threshold == null || var.liveness_probe_failure_threshold == ""   ? "" : "failureThreshold: ${var.liveness_probe_failure_threshold}"

    deployment_hpa_enabled = var.max_replica_count != null && var.max_replica_count != var.replica_count ? true : false
    deployment_hpa_name = "${var.deployment_name}-hpa"
    target_cpu_utilization = var.target_cpu_utilization == null ? 70 : var.target_cpu_utilization
    scale_down_period = var.scale_down_period == null ? 300 : var.scale_down_period
}