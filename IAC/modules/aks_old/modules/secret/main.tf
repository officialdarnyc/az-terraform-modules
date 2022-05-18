module "aks_namespace_secret" {
    source = "../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "namespace_secret"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name           = var.secret_name
        namespace_name = var.namespace_name
        secret_crt     = var.secret_crt
        secret_key     = var.secret_key
    }
}
