module "aks_service_deployment" {
    source = "../../../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "service_deployment"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name                  = var.deployment_name
        namespace_name        = var.namespace_name
        image                 = var.image
        replica_count         = var.replica_count
        port                  = var.port
        liveness_probe_path   = var.liveness_probe_path
        readiness_probe_path  = var.readiness_probe_path
        tolerations           = local.tolerations
        environment_variables = local.environment_variables
        persistent_volumes    = local.persistent_volumes
        additional_ports      = local.additional_ports
        timezone_name         = local.timezone_name
        timezone_mount_path   = local.timezone_mount_path
        timezone_host_path    = local.timezone_host_path
        timezone_local_path   = local.timezone_local_path
        max_cpu               = local.max_cpu
        min_cpu               = local.min_cpu
        max_memory            = local.max_memory
        min_memory            = local.min_memory
        readiness_probe_period            = local.readiness_probe_period
        readiness_probe_timeout           = local.readiness_probe_timeout
        readiness_probe_failure_threshold = local.readiness_probe_failure_threshold
        liveness_probe_period             = local.liveness_probe_period
        liveness_probe_timeout            = local.liveness_probe_timeout
        liveness_probe_failure_threshold  = local.liveness_probe_failure_threshold
    }
}

module "aks_service_deployment_hpa" {
    source = "../../../template"
    count = local.deployment_hpa_enabled ? 1 : 0

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "service_deployment_hpa"
    template_path       = "${path.module}/"
    template_file_name  = var.deployment_hpa_template_file_name

    options             = {
        name = local.deployment_hpa_name
        deployment_name = var.deployment_name
        min_replica_count = var.replica_count
        max_replica_count = var.max_replica_count
        target_cpu_utilization = local.target_cpu_utilization
        scale_down_period = local.scale_down_period
    }
}