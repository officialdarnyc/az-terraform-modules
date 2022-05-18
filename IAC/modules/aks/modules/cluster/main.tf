resource "azurerm_kubernetes_cluster" "aks" {
  resource_group_name     = var.resource_group_name
  location                = var.location
  name                    = var.aks_cluster_name
  dns_prefix              = local.dns_prefix
  private_dns_zone_id     = var.private_cluster_enabled ? var.private_dns_zone_id : null
  node_resource_group     = local.node_resource_group
  private_cluster_enabled = var.private_cluster_enabled
  // enable_azure_policy              = var.enable_azure_policy
  enable_pod_security_policy      = var.enable_pod_security_policy
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges == null ? null : split(",", var.api_server_authorized_ip_ranges == null ? "" : var.api_server_authorized_ip_ranges)
  kubernetes_version              = var.kubernetes_version

  default_node_pool {
    name                         = local.default_node_pool.name
    orchestrator_version         = local.default_node_pool.orchestrator_version
    node_count                   = local.default_node_pool.node_count
    vm_size                      = local.default_node_pool.vm_size
    max_pods                     = local.default_node_pool.max_pods
    node_labels                  = var.tags
    availability_zones           = local.default_node_pool.availability_zones
    only_critical_addons_enabled = local.default_node_pool.only_critical_addons_enabled
    os_disk_size_gb              = local.default_node_pool.os_disk_size_gb
    vnet_subnet_id               = local.default_node_pool.vnet_subnet_id
    node_taints                  = local.default_node_pool.node_taints == null ? null : split(",", local.default_node_pool.node_taints == null ? "" : local.default_node_pool.node_taints)
    enable_auto_scaling          = local.default_node_pool.enable_auto_scaling
    min_count                    = local.default_node_pool.enable_auto_scaling == true ? local.default_node_pool.min_count : null
    max_count                    = local.default_node_pool.enable_auto_scaling == true ? local.default_node_pool.max_count : null
    enable_node_public_ip        = local.default_node_pool.enable_node_public_ip
  }

  dynamic "identity" {
    for_each = var.client_id != null ? [] : [var.identity_type]

    content {
      type                      = var.identity_type
      user_assigned_identity_id = var.user_assigned_identity_id
    }
  }

  dynamic "service_principal" {
    for_each = var.client_id == null ? [] : [var.client_id]

    content {
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }

  dynamic "linux_profile" {
    for_each = var.linux_admin_user_name == null || var.linux_admin_ssh == null ? [] : [var.linux_admin_user_name]

    content {
      admin_username = var.linux_admin_user_name
      ssh_key {
        key_data = var.linux_admin_ssh
      }
    }
  }

  dynamic "windows_profile" {
    for_each = var.windows_admin_user_name == null || var.windows_admin_user_password == null ? [] : [var.windows_admin_user_name]

    content {
      admin_username = var.windows_admin_user_name
      admin_password = var.windows_admin_user_password
    }
  }

  dynamic "network_profile" {
    for_each = var.network_profile == null || lookup(var.network_profile, "network_plugin", null) == null ? [] : ["-"]

    content {
      network_plugin     = lookup(var.network_profile, "network_plugin", null)
      outbound_type      = lookup(var.network_profile, "outbound_type", null)
      service_cidr       = lookup(var.network_profile, "service_cidr", null)
      docker_bridge_cidr = lookup(var.network_profile, "docker_bridge_cidr", null)
      dns_service_ip     = lookup(var.network_profile, "dns_service_ip", null)
      network_policy     = lookup(var.network_profile, "network_policy", null)
      load_balancer_sku  = lookup(var.network_profile, "load_balancer_sku", null)

      load_balancer_profile {
        managed_outbound_ip_count = lookup(var.network_profile, "managed_outbound_ip_count", null)
      }
    }
  }

  addon_profile {
    azure_policy {
      enabled = var.enable_azure_policy
    }

    http_application_routing {
      enabled = var.http_application_routing_enabled
    }
    kube_dashboard {
      enabled = var.kube_dashboard_enabled
    }
    oms_agent {
      enabled                    = var.log_analytics_workspace_id == null ? false : true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  role_based_access_control {
    enabled = var.role_based_access_control_enabled
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "aks_log_analytics" {
  count = var.attach_diagnostic_settings != null ? 1 : 0

  name                       = "ds-${var.aks_cluster_name}"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "cluster-autoscaler"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "cloud-controller-manager"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }


  log {
    category = "guard"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "csi-azuredisk-controller"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "csi-azurefile-controller"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }
  log {
    category = "csi-snapshot-controller"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-apiserver"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-audit"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-audit-admin"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-controller-manager"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  log {
    category = "kube-scheduler"
    enabled  = true

    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    retention_policy {
      enabled = false
    }
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

resource "null_resource" "attach_repository" {
  for_each = local.attach_repository ? { repository_name = var.repository_name } : {}

  triggers = {
    always_run = "change-${timestamp()}"
  }

  provisioner "local-exec" {
    command = "az aks update -n ${var.aks_cluster_name} -g ${var.resource_group_name} --attach-acr ${var.repository_name}"
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
