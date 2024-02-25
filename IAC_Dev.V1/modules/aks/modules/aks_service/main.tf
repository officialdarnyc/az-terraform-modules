module "aks_service_deployment" {
    source = "./modules/deployment"

    resource_group_name   = var.resource_group_name
    aks_cluster_name      = var.aks_cluster_name
    deployment_name       = local.deployment_name
    namespace_name        = local.deployment_namespace_name
    image                 = var.image
    replica_count         = var.replica_count
    port                  = var.deployment_port
    additional_ports      = local.additional_ports
    liveness_probe_path   = local.liveness_probe_path
    readiness_probe_path  = local.readiness_probe_path
    tolerations           = var.tolerations
    environment_variables = var.environment_variables
    persistent_volumes    = var.persistent_volumes
    template_file_name    = var.deployment_template_file_name
    timezone              = var.timezone
    timezone_location     = var.timezone_location
    max_cpu               = var.max_cpu
    min_cpu               = var.min_cpu
    max_memory            = var.max_memory
    min_memory            = var.min_memory
    max_replica_count     = var.max_replica_count
    target_cpu_utilization            = var.target_cpu_utilization
    scale_down_period                 = var.scale_down_period
    deployment_hpa_template_file_name = var.deployment_hpa_template_file_name
    readiness_probe_period            = var.readiness_probe_period
    readiness_probe_timeout           = var.readiness_probe_timeout
    readiness_probe_failure_threshold = var.readiness_probe_failure_threshold
    liveness_probe_period             = var.liveness_probe_period
    liveness_probe_timeout            = var.liveness_probe_timeout
    liveness_probe_failure_threshold  = var.liveness_probe_failure_threshold
}

module "aks_service_service" {
    source = "./modules/service"

    resource_group_name  = var.resource_group_name
    aks_cluster_name     = var.aks_cluster_name
    service_name         = local.service_name
    namespace_name       = var.namespace_name
    port                 = var.ingress_port
    target_port          = var.deployment_port
    template_file_name   = var.service_template_file_name
    additional_ports     = local.additional_ports
}

module "aks_service_ingress" {
    source = "./modules/ingress"
    count = tobool(var.ingress_settings.enabled) ? 0 : 1

    resource_group_name  = var.resource_group_name
    aks_cluster_name     = var.aks_cluster_name
    ingress_name         = local.ingress_name
    namespace_name       = local.ingress_namespace_name
    service_port         = var.ingress_port
    secret_name          = var.secret_name
    host_name            = var.host_name
    path                 = local.ingress_path
    rewrite_path_enabled = var.rewrite_path_enabled
    deployment_path      = var.deployment_path
    template_file_name   = var.ingress_template_file_name
    additional_ports     = local.additional_ports
    annotations          = local.annotations
}

module "aks_nginx_ingress" {
    source = "./modules/ingress-nginx"
    count = tobool(var.ingress_settings.enabled) ? 1 : 0

    resource_group_name  = var.resource_group_name
    aks_cluster_name     = var.aks_cluster_name
    ingress_name         = local.ingress_name
    namespace_name       = local.ingress_namespace_name
    service_port         = var.ingress_port
    secret_name          = var.secret_name
    host_name            = var.host_name
    path                 = local.ingress_path
    rewrite_path_enabled = var.rewrite_path_enabled
    deployment_path      = var.deployment_path
    template_file_name   = var.ingress_template_file_name
    additional_ports     = local.additional_ports
    annotations          = local.annotations
}

/*resource "null_resource" "fetch_service_load_balancer_ip" {
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = "kubectl get svc ${local.ingress_name} -n kube-system -o=jsonpath={.status.loadBalancer.ingress[].ip} > ${local.lb_ip_file_name}"
    }
    

    depends_on = [
        module.aks_service_ingress
    ]
}*/

