module "aks_service_ingress" {
    source = "../../../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "service_ingress"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name               = var.ingress_name
        namespace_name     = var.namespace_name
        secret_name        = var.secret_name
        host_name          = var.host_name
        service_port       = var.service_port
        path               = local.path
        rewrite_annotation = local.rewrite_annotation
        additional_ports   = local.additional_ports
        annotations        = local.annotations
    }
}
