locals {
    attach_repository = var.attach_repository == null ? (var.repository_name == null || var.repository_name == "" ? false : true) : var.attach_repository
    
    dns_prefix = var.dns_prefix == null || length(var.dns_prefix == null ? "" : var.dns_prefix) == 0 ? replace(var.aks_cluster_name, "-", "") : var.dns_prefix
    
    node_resource_group = var.node_resource_group == null ? "rg-aks-${var.aks_cluster_name}" : var.node_resource_group
    
    # availability_zones = lookup(var.default_node_pool, "availability_zones", "1")

    # enable_auto_scaling = tobool(lookup(var.default_node_pool, "enable_auto_scaling", length(local.availability_zones) > 1 ? "true" : "false"))

    # min_count = tonumber(lookup(var.default_node_pool, "min_count", "1"))
    
    # default_node_pool = {
    #     name                         = replace(lookup(var.default_node_pool, "name", "${var.aks_cluster_name}-npd"), "-", "")
    #     orchestrator_version         = lookup(var.default_node_pool, "orchestrator_version", var.kubernetes_version)
    #     node_count                   = tonumber(lookup(var.default_node_pool, "node_count", "1"))
    #     vm_size                      = lookup(var.default_node_pool, "vm_size", "Standard_D2_v2")
    #     max_pods                     = tonumber(lookup(var.default_node_pool, "max_pods", "110"))
    #     availability_zones           = split(",", local.availability_zones == null || length(local.availability_zones) == 0 ? "1" : local.availability_zones)
    #     only_critical_addons_enabled = tobool(lookup(var.default_node_pool, "only_critical_addons_enabled", "true"))
    #     os_disk_size_gb              = tonumber(lookup(var.default_node_pool, "os_disk_size_gb", "1024"))
    #     # vnet_subnet_id               = lookup(var.default_node_pool, "vnet_subnet_id", var.node_pool_subnet_id)
    #     # vnet_subnet_id               = var.node_pool_subnet_id
    #     vnet_subnet_id              =  local.vnet_subnet_id
    #     node_taints                  = lookup(var.default_node_pool, "node_taints", null)
    #     enable_auto_scaling          = local.enable_auto_scaling
    #     min_count                    = local.min_count
    #     max_count                   = tonumber(lookup(var.default_node_pool, "max_count", local.enable_auto_scaling ? "${local.min_count * 2}" : "${local.min_count}"))
    #     enable_node_public_ip        = tobool(lookup(var.default_node_pool, "enable_node_public_ip", "false"))
    # }

  #   default_node_pool = {
  #    name            = "k8sagentpool"
  #    vm_size         = "Standard_F8s_v2"
  #    os_disk_size_gb = "1024"
  #    #  advanced networking
  #    vnet_subnet_id = var.vnet_subnet_id
  #    enable_auto_scaling = "true"
  #   #  max_count = var.agent_pool_count
  #   #  min_count = local.min_count
  #   #  node_count = var.min_count
  #    # availability_zones  = [1, 2, 3]
  #    # type = "VirtualMachineScaleSets"

  # }
}
