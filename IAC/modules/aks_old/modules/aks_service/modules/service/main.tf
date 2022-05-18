module "aks_service_service" {
    source = "../../../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "service_service"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name                 = var.service_name
        namespace_name       = var.namespace_name
        port                 = var.port
        target_port          = var.target_port
        additional_ports     = local.additional_ports
    }
}
