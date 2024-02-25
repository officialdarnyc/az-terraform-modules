module "aks_loadbalancer" {
    source = "../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "loadbalancer"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name = var.loadbalancer_name
        resource_group_name = var.resource_group_name
        ip_address = var.ip_address
        port = var.port
    }
}
