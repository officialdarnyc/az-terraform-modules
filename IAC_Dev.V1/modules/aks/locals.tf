locals {
    default_node_pool = var.node_pools[0]

    node_pools = {
        for index, node_pool in var.node_pools:
            lookup(node_pool, "name") => {
                name                         = replace(lookup(node_pool, "name", "${var.aks_cluster_name}-npd-${index + 1}"), "-", "")
                orchestrator_version         = lookup(node_pool, "orchestrator_version", var.kubernetes_version)
                node_count                   = tonumber(lookup(node_pool, "node_count", "1"))
                vm_size                      = lookup(node_pool, "vm_size", "Standard_D2_v2")
                os_type                      = lookup(node_pool, "os_type", "Linux")
                max_pods                     = tonumber(lookup(node_pool, "max_pods", "110"))
                availability_zones           = lookup(node_pool, "availability_zones", "1")# split(",", lookup(node_pool, "availability_zones", null) == null || length(lookup(node_pool, "availability_zones", "1")) == 0 ? "1" : lookup(node_pool, "availability_zones", "1"))
                only_critical_addons_enabled = tobool(lookup(node_pool, "only_critical_addons_enabled", "true"))
                os_disk_size_gb              = tonumber(lookup(node_pool, "os_disk_size_gb", "1024"))
                vnet_subnet_id               = lookup(node_pool, "vnet_subnet_id", var.node_pool_subnet_id)
                node_taints                  = lookup(node_pool, "node_taints", null)
                enable_auto_scaling          = tobool(lookup(node_pool, "enable_auto_scaling", length(lookup(node_pool, "availability_zones", "1")) > 1 ? "true" : "false"))
                min_count                    = tonumber(lookup(node_pool, "min_count", "1"))
                max_count                    = tonumber(lookup(node_pool, "max_count", tobool(lookup(node_pool, "enable_auto_scaling", length(lookup(node_pool, "availability_zones", "1")) > 1 ? "true" : "false")) ? "${tonumber(lookup(node_pool, "min_count", "1")) * 2}" : "${tonumber(lookup(node_pool, "min_count", "1"))}"))
                enable_node_public_ip        = tobool(lookup(node_pool, "enable_node_public_ip", "false"))
            }
            if index > 0
    }

    namespaces = {
        for namespace in var.namespaces:
            lookup(namespace, "name") => {
                name = lookup(namespace, "name")
                template_file_name = lookup(namespace, "template_file_name", null)
            }
    }
    
    node_resource_group = var.node_resource_group == null ? "rg-n-${var.aks_cluster_name}" : var.node_resource_group
    aks_initialize = length(var.namespaces) > 0
    ingress_settings = {
        name = "pip-ingress-${var.aks_cluster_name}"
        enabled = lookup(var.ingress_settings, "enabled", "false")
        ip_allocation = lookup(var.ingress_settings, "ip_allocation", "Dynamic")
        dns_prefix = lookup(var.ingress_settings, "dns_prefix", "xcc")
    }

    services = {
        for index, service in var.services:
            lookup(service, "service_name") => {
                service_name = lookup(service, "service_name")
                ingress_name = lookup(service, "ingress_name", null)
                deployment_name = lookup(service, "deployment_name", null)
                namespace_name = lookup(service, "namespace_name", null)
                ingress_namespace_name = lookup(service, "ingress_namespace_name", null)
                deployment_namespace_name = lookup(service, "deployment_namespace_name", null)
                additional_ports = lookup(service, "additional_ports", null)
                annotations = lookup(service, "annotations", null)
                timezone = lookup(service, "timezone", null)
                timezone_location = lookup(service, "timezone_location", null)
                max_cpu = lookup(service, "max_cpu", null)
                min_cpu = lookup(service, "min_cpu", null)
                max_memory = lookup(service, "max_memory", null)
                min_memory = lookup(service, "min_memory", null)
                max_replica_count = lookup(service, "max_replica_count", null)
                target_cpu_utilization = lookup(service, "target_cpu_utilization", null)
                scale_down_period = lookup(service, "scale_down_period", null)
                deployment_hpa_template_file_name = lookup(service, "deployment_hpa_template_file_name", null)
                readiness_probe_period = lookup(service, "readiness_probe_period", null)
                readiness_probe_timeout = lookup(service, "readiness_probe_timeout", null)
                readiness_probe_failure_threshold = lookup(service, "readiness_probe_failure_threshold", null)
                liveness_probe_period = lookup(service, "liveness_probe_period", null)
                liveness_probe_timeout = lookup(service, "liveness_probe_timeout", null)
                liveness_probe_failure_threshold = lookup(service, "liveness_probe_failure_threshold", null)
                ingress_path = lookup(service, "ingress_path", "/")
                image = lookup(service, "image")
                replica_count = lookup(service, "replica_count", 2)
                deployment_port = lookup(service, "deployment_port", 80)
                ingress_port = lookup(service, "ingress_port", 80)
                deployment_template_file_name = lookup(service, "deployment_template_file_name", null)
                service_template_file_name = lookup(service, "service_template_file_name", null)
                ingress_template_file_name = lookup(service, "ingress_template_file_name", null)
                liveness_probe_path = lookup(service, "liveness_probe_path", null)
                readiness_probe_path = lookup(service, "readiness_probe_path", null)
                secret_name = lookup(service, "secret_name", null)
                host_name = lookup(service, "host_name")
                deployment_path = lookup(service, "deployment_path", null)
                rewrite_path_enabled = lookup(service, "rewrite_path_enabled", null) == null ? null : tobool(lookup(service, "rewrite_path_enabled", "false"))
            }
    }
    
    jobs = {
        for index, job in var.jobs:
            lookup(job, "job_name") => {
                job_name = lookup(job, "job_name")
                namespace_name = lookup(job, "namespace_name", null)
                image = lookup(job, "image")
                command = lookup(job, "command")
                template_file_name = lookup(job, "template_file_name", null)
                restart_policy = lookup(job, "restart_policy", null)
                backoff_limit = lookup(job, "backoff_limit", null) == null ? null : tonumber(lookup(job, "backoff_limit", "0"))
                suspend = lookup(job, "suspend", null) == null ? null : tobool(lookup(job, "suspend", "false"))
                parallelism = lookup(job, "parallelism", null) == null ? null : tonumber(lookup(job, "parallelism", "0"))
                completions = lookup(job, "completions", null) == null ? null : tonumber(lookup(job, "completions", "0"))
                ttl_seconds_after_finished = lookup(job, "ttl_seconds_after_finished", null) == null ? null : tonumber(lookup(job, "ttl_seconds_after_finished", "0"))
            }
    }

    cronjobs = {
        for index, job in var.cronjobs:
            lookup(job, "job_name") => {
                job_name = lookup(job, "job_name")
                namespace_name = lookup(job, "namespace_name", null)
                image = lookup(job, "image")
                command = lookup(job, "command")
                template_file_name = lookup(job, "template_file_name", null)
                restart_policy = lookup(job, "restart_policy", null)
                timezone = lookup(job, "timezone", null)
                timezone_location = lookup(job, "timezone_location", null)
                boot_time = lookup(job, "boot_time", null)
                concurrency_policy = lookup(job, "concurrency_policy", null)
                schedule = lookup(job, "schedule", null)
            }
    }
    
    secrets = {
        for index, secret in var.secrets:
            "${lookup(secret, "namespace_name")}_${lookup(secret, "secret_name")}" => {
                secret_name = lookup(secret, "secret_name")
                namespace_name = lookup(secret, "namespace_name")
                secret_crt = lookup(secret, "secret_crt", null)
                secret_key = lookup(secret, "secret_key", null)
                template_file_name = lookup(secret, "template_file_name", null)
            }
    }

    all_persistent_volumes = flatten([
        for service_name, volumes in var.services_persistent_volumes:
            [
                for volume in volumes:
                    volume
            ]
    ])

    grouped_volume_secrets = {
        for volume in local.all_persistent_volumes:
            volume.secret_name => volume
        ...
    }

    persistent_volume_secrets = {
        for secret_name, volumes in local.grouped_volume_secrets:
            secret_name => volumes[0]
    }
}
