locals {
    restart_policy = var.restart_policy == null ? "OnFailure" : var.restart_policy
    concurrency_policy = var.concurrency_policy == null ? "Allow" : var.concurrency_policy
    boot_time = var.boot_time == null ? 0 : var.boot_time
    commands = split("~", var.command == null ? "" : var.command)
    schedule = var.schedule == null ? "0 * * * *" : var.schedule
    environment_variables = [
        for indx, environment_variable in var.environment_variables: {
            key = lookup(environment_variable, "key", null)
            value = lookup(environment_variable, "value", null)
        }
        if lookup(environment_variable, "key", null) != null && lookup(environment_variable, "value", null) != null
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
}
