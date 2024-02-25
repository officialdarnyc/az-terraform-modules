module "aks_cronjob_cronjob" {
    source = "../template"

    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.aks_cluster_name
    resource_type       = "cronjob_cronjob"
    template_path       = "${path.module}/"
    template_file_name  = var.template_file_name

    options             = {
        name                    = var.job_name
        namespace_name          = var.namespace_name
        image                   = var.image
        commands                = local.commands
        restart_policy          = local.restart_policy
        schedule                = local.schedule
        environment_variables   = local.environment_variables
        concurrency_policy      = local.concurrency_policy
        boot_time               = local.boot_time
        tolerations             = local.tolerations
        persistent_volumes      = local.persistent_volumes
        timezone_name           = local.timezone_name
        timezone_mount_path     = local.timezone_mount_path
        timezone_host_path      = local.timezone_host_path
        timezone_local_path     = local.timezone_local_path
    }
}
