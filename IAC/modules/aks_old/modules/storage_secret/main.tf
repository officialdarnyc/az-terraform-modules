module "storage_secret" {
    source = "../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "secret"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name                     = var.secret_name
        namespace_name           = var.namespace_name
        storage_account_name     = var.storage_account_name
        storage_account_key      = var.storage_account_key
    }
}
