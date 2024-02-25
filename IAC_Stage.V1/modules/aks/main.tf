module "aks" {
    source = "./modules/cluster"

    resource_group_name               = var.resource_group_name
    location                          = var.location
    aks_cluster_name                  = var.aks_cluster_name
    repository_name                   = var.repository_name
    dns_prefix                        = var.dns_prefix
    private_dns_zone_id               = var.private_dns_zone_id
    node_resource_group               = local.node_resource_group
    private_cluster_enabled           = var.private_cluster_enabled
    enable_azure_policy               = var.enable_azure_policy
    enable_pod_security_policy        = var.enable_pod_security_policy
    api_server_authorized_ip_ranges   = var.api_server_authorized_ip_ranges
    kubernetes_version                = var.kubernetes_version
    http_application_routing_enabled  = var.http_application_routing_enabled
    kube_dashboard_enabled            = var.kube_dashboard_enabled
    role_based_access_control_enabled = var.role_based_access_control_enabled
    log_analytics_workspace_id        = var.log_analytics_workspace_id
    tags                              = var.tags
    identity_type                     = var.identity_type
    user_assigned_identity_id         = var.user_assigned_identity_id
    client_id                         = var.client_id
    client_secret                     = var.client_secret
    linux_admin_user_name             = var.linux_admin_user_name
    linux_admin_ssh                   = var.linux_admin_ssh
    windows_admin_user_name           = var.windows_admin_user_name
    windows_admin_user_password       = var.windows_admin_user_password
    network_profile                   = var.network_profile
    default_node_pool                 = local.default_node_pool
    attach_repository                 = var.attach_repository
    node_pool_subnet_id               = var.node_pool_subnet_id
    attach_diagnostic_settings        = var.attach_diagnostic_settings
}

module "node_pool" {
    source = "./modules/nodepool"
    for_each = local.node_pools

    kubernetes_cluster_id = module.aks.id
    name                  = each.key
    orchestrator_version  = var.kubernetes_version
    node_count            = each.value.node_count
    os_type               = each.value.os_type
    vm_size               = each.value.vm_size
    os_disk_size_gb       = each.value.os_disk_size_gb
    max_pods              = each.value.max_pods
    availability_zones    = each.value.availability_zones
    node_taints           = each.value.node_taints
    vnet_subnet_id        = each.value.vnet_subnet_id == null ? var.node_pool_subnet_id : each.value.vnet_subnet_id
    enable_auto_scaling   = each.value.enable_auto_scaling
    min_count             = each.value.min_count
    max_count             = each.value.max_count
    enable_node_public_ip = each.value.enable_node_public_ip
    tags                  = var.tags

    depends_on = [
        module.aks
    ]
}

module "aks_initialize" {
    source                = "./modules/aks_initialize"

    for_each              = local.aks_initialize ? { "-" = "" } : { }

    resource_group_name   = var.resource_group_name
    aks_cluster_name      = var.aks_cluster_name

    depends_on = [
        module.aks,
        module.node_pool
    ]
}

module "aks_namespace" {
    source               = "./modules/namespace"
    for_each             = local.namespaces

    resource_group_name  = var.resource_group_name
    aks_cluster_name     = var.aks_cluster_name
    namespace_name       = each.value.name
    template_file_name   = each.value.template_file_name

    depends_on = [
        module.aks_initialize,
        module.node_pool
    ]
}

module "ingress_ip" {
    source = "../network/modules/public_ip"
    count = tobool(local.ingress_settings.enabled) ? 1 : 0

    resource_group_name  = local.node_resource_group
    location             = var.location
    public_ip_name       = local.ingress_settings.name
    tags                 = var.tags
    domain_name_label    = local.ingress_settings.dns_prefix

     depends_on =[
         module.aks_namespace
     ]
}

module "install-nginx-ingress-controller" {
    source                = "./modules/nginx-ingress"
    for_each              = tobool(local.ingress_settings.enabled) ? { "-" = "" } : { }

    ingress_settings        = local.ingress_settings
    ingress_ip_address      = tobool(local.ingress_settings.enabled) ? module.ingress_ip[0].ip_address : null
    depends_on = [
        module.aks,
        module.node_pool,
        module.aks_initialize,
        module.aks_namespace,
        module.ingress_ip
    ]
}

module "aks_load_balancer_public_ip" {
    source = "../network/modules/public_ip"

    for_each             = var.load_balancer_name != null ? { "${var.load_balancer_name}" = "-" } : {}

    resource_group_name  = var.resource_group_name
    location             = var.location

    public_ip_name       = "${var.load_balancer_name}-pip"
    tags                 = var.tags
    domain_name_label    = var.load_balancer_public_ip_label
}

module "aks_loadbalancer" {
    source               = "./modules/load_balancer"
    for_each             = var.load_balancer_name != null ? { "${var.load_balancer_name}" = "-" } : {}

    resource_group_name  = var.resource_group_name
    aks_cluster_name     = var.aks_cluster_name
    loadbalancer_name    = var.load_balancer_name
    template_file_name   = var.load_balancer_template_file_name
    ip_address           = module.aks_load_balancer_public_ip[var.load_balancer_name].ip_address

    depends_on = [
        module.aks_initialize,
        module.node_pool
    ]
}

module "aks_secret" {
    source = "./modules/secret"
    for_each = local.secrets

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    secret_name         = each.value.secret_name
    secret_crt          = each.value.secret_crt
    secret_key          = each.value.secret_key
    namespace_name      = each.value.namespace_name
    template_file_name  = each.value.template_file_name

    depends_on = [
        module.aks_namespace
    ]
}

module "storage_secret" {
    source = "./modules/storage_secret"
    for_each = local.persistent_volume_secrets

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    secret_name          = each.value.secret_name
    storage_account_name = each.value.storage_account_name
    storage_account_key  = each.value.storage_account_key
    namespace_name       = each.value.namespace_name
    template_file_name   = each.value.template_file_name

    depends_on = [
        module.aks_initialize,
        module.aks_namespace
    ]
}

module "aks_service" {
    source = "./modules/aks_service"
    for_each = local.services

    resource_group_name           = var.resource_group_name
    aks_cluster_name              = var.aks_cluster_name
    service_name                  = each.value.service_name
    ingress_name                  = each.value.ingress_name
    deployment_name               = each.value.deployment_name
    namespace_name                = each.value.namespace_name
    ingress_namespace_name        = each.value.ingress_namespace_name
    deployment_namespace_name     = each.value.deployment_namespace_name
    ingress_path                  = each.value.ingress_path
    image                         = each.value.image
    replica_count                 = each.value.replica_count
    deployment_port               = each.value.deployment_port
    ingress_port                  = each.value.ingress_port
    additional_ports              = each.value.additional_ports
    annotations                   = each.value.annotations
    timezone                      = each.value.timezone
    timezone_location             = each.value.timezone_location
    liveness_probe_path           = each.value.liveness_probe_path
    readiness_probe_path          = each.value.readiness_probe_path
    max_replica_count             = each.value.max_replica_count
    target_cpu_utilization        = each.value.target_cpu_utilization
    scale_down_period             = each.value.scale_down_period
    deployment_hpa_template_file_name = each.value.deployment_hpa_template_file_name
    secret_name                   = each.value.secret_name
    host_name                     = each.value.host_name
    rewrite_path_enabled          = each.value.rewrite_path_enabled
    deployment_path               = each.value.deployment_path
    deployment_template_file_name = each.value.deployment_template_file_name
    service_template_file_name    = each.value.service_template_file_name
    ingress_template_file_name    = each.value.ingress_template_file_name
    max_cpu                       = each.value.max_cpu
    min_cpu                       = each.value.min_cpu
    max_memory                    = each.value.max_memory
    min_memory                    = each.value.min_memory
    readiness_probe_period        = each.value.readiness_probe_period
    readiness_probe_timeout       = each.value.readiness_probe_timeout
    readiness_probe_failure_threshold = each.value.readiness_probe_failure_threshold
    liveness_probe_period         = each.value.liveness_probe_period
    liveness_probe_timeout        = each.value.liveness_probe_timeout
    liveness_probe_failure_threshold = each.value.liveness_probe_failure_threshold
    tolerations                   = lookup(var.services_tolerations, each.value.service_name, null)
    environment_variables         = concat(var.services_environment_variables[each.value.service_name], var.global_environment_variables == null ? [] : var.global_environment_variables)
    persistent_volumes            = lookup(var.services_persistent_volumes, each.value.service_name, null)
    ingress_settings              = local.ingress_settings

    depends_on = [
        module.aks_namespace,
        module.storage_secret
    ]
}

module "aks_cronjob" {
    source = "./modules/aks_cronjob"
    for_each = local.cronjobs

    resource_group_name           = var.resource_group_name
    aks_cluster_name              = var.aks_cluster_name
    job_name                      = each.value.job_name
    image                         = each.value.image
    timezone                      = each.value.timezone
    timezone_location             = each.value.timezone_location
    template_file_name            = each.value.template_file_name
    namespace_name                = each.value.namespace_name
    command                       = each.value.command
    restart_policy                = each.value.restart_policy
    boot_time                     = each.value.boot_time
    concurrency_policy            = each.value.concurrency_policy
    schedule                      = each.value.schedule
    tolerations                   = lookup(var.jobs_tolerations, each.value.job_name, null)
    environment_variables         = concat(var.jobs_environment_variables[each.value.job_name], var.global_environment_variables == null ? [] : var.global_environment_variables)
    persistent_volumes            = lookup(var.jobs_persistent_volumes, each.value.job_name, null)

    depends_on = [
        module.aks_namespace,
        module.storage_secret
    ]
}

module "aks_job" {
    source = "./modules/aks_job"
    for_each = local.jobs

    resource_group_name        = var.resource_group_name
    aks_cluster_name           = var.aks_cluster_name
    namespace_name             = each.value.namespace_name
    job_name                   = each.value.job_name
    image                      = each.value.image
    restart_policy             = each.value.restart_policy
    backoff_limit              = each.value.backoff_limit
    suspend                    = each.value.suspend
    parallelism                = each.value.parallelism
    completions                = each.value.completions
    ttl_seconds_after_finished = each.value.ttl_seconds_after_finished
    command                    = each.value.command
    template_file_name         = each.value.template_file_name
    environment_variables      = concat(var.jobs_environment_variables[each.value.job_name], var.global_environment_variables == null ? [] : var.global_environment_variables)

    depends_on = [
        module.aks_namespace
    ]  
}