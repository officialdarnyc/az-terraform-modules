module "aks_namespace" {
    source = "../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "namespace"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name = var.namespace_name
    }
}
