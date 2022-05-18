module "aks_job_job" {
    source = "../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "job_job"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name                    = var.job_name
        namespace_name          = var.namespace_name
        image                   = var.image
        command                 = var.command
        restart_policy           = local.restart_policy
        backoff_limit            = local.backoff_limit
        suspend                 = local.suspend
        parallelism             = local.parallelism
        completions             = local.completions
        ttl_seconds_after_finished = local.ttl_seconds_after_finished
        environment_variables   = local.environment_variables
    }
}
