locals {
    # default_node_pool = var.node_pools[0]
    # aks_admin         = var.aks_admin
    # client_id     = var.kubernetes_client_id
    # client_secret = var.kubernetes_client_secret

    # node_pools = {
    #     for index, node_pool in var.node_pools:
    #         lookup(node_pool, "name") => {
    #             name                         = replace(lookup(node_pool, "name", "${var.aks_cluster_name}-npd-${index + 1}"), "-", "")
    #             orchestrator_version         = lookup(node_pool, "orchestrator_version", var.kubernetes_version)
    #             node_count                   = tonumber(lookup(node_pool, "node_count", "1"))
    #             vm_size                      = lookup(node_pool, "vm_size", "Standard_D2_v2")
    #             os_type                      = lookup(node_pool, "os_type", "Linux")
    #             max_pods                     = tonumber(lookup(node_pool, "max_pods", "110"))
    #             availability_zones           = lookup(node_pool, "availability_zones", "1")# split(",", lookup(node_pool, "availability_zones", null) == null || length(lookup(node_pool, "availability_zones", "1")) == 0 ? "1" : lookup(node_pool, "availability_zones", "1"))
    #             only_critical_addons_enabled = tobool(lookup(node_pool, "only_critical_addons_enabled", "true"))
    #             os_disk_size_gb              = tonumber(lookup(node_pool, "os_disk_size_gb", "1024"))
    #             # vnet_subnet_id               = lookup(node_pool, "vnet_subnet_id", var.node_pool_subnet_id)
    #             # vnet_subnet_id               = var.node_pool_subnet_id
    #             # vnet_subnet_id               = var.vnet_subnet_id
    #             node_taints                  = lookup(node_pool, "node_taints", null)
    #             enable_auto_scaling          = tobool(lookup(node_pool, "enable_auto_scaling", length(lookup(node_pool, "availability_zones", "1")) > 1 ? "true" : "false"))
    #             min_count                    = tonumber(lookup(node_pool, "min_count", "1"))
    #             max_count                    = tonumber(lookup(node_pool, "max_count", tobool(lookup(node_pool, "enable_auto_scaling", length(lookup(node_pool, "availability_zones", "1")) > 1 ? "true" : "false")) ? "${tonumber(lookup(node_pool, "min_count", "1")) * 2}" : "${tonumber(lookup(node_pool, "min_count", "1"))}"))
    #             enable_node_public_ip        = tobool(lookup(node_pool, "enable_node_public_ip", "false"))
    #         }
    #         if index > 0
    # }


    
    node_resource_group = var.node_resource_group == null ? "rg-n-${var.aks_cluster_name}" : var.node_resource_group

}
