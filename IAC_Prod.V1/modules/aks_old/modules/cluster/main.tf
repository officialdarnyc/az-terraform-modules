resource "azurerm_kubernetes_cluster" "aks" {
    resource_group_name              = var.resource_group_name
    location                         = var.location
    name                             = var.aks_cluster_name
    dns_prefix                       = local.dns_prefix
    private_dns_zone_id              = var.private_cluster_enabled ? var.private_dns_zone_id : null
    node_resource_group              = local.node_resource_group
    private_cluster_enabled          = var.private_cluster_enabled
    // enable_azure_policy              = var.enable_azure_policy
    enable_pod_security_policy       = var.enable_pod_security_policy
   // # api_server_authorized_ip_ranges  = var.api_server_authorized_ip_ranges == null ? null : split(",", var.api_server_authorized_ip_ranges == null ? "" : var.api_server_authorized_ip_ranges)
    kubernetes_version               = var.kubernetes_version


    default_node_pool  {
     name            = "k8sagentpool"
     vm_size         = var.aks_vm_size
     os_disk_size_gb = "150"
     #  advanced networking
     vnet_subnet_id =  var.vnet_subnet_id
     enable_auto_scaling = "true"
     max_count = "1"
     min_count = "1"
     node_count = "1"

  }

    dynamic "identity" {
        for_each = var.client_id != null ? [] : [var.identity_type]

        content {
            type = var.identity_type
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
        for_each = var.linux_admin_user_name == null || var.linux_admin_ssh == null ? [] : [ var.linux_admin_user_name ]

        content {
            admin_username = var.linux_admin_user_name
            ssh_key { 
                key_data = var.linux_admin_ssh
            }
        }
    }


    network_profile {
        
    network_plugin = "azure"
    load_balancer_sku = "standard"

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
    
    # role_based_access_control {
    #     enabled = var.role_based_access_control_enabled
    # }

#    role_based_access_control {
#    enabled = true
#    azure_active_directory {
#      managed                =  var.ad_auth
#      admin_group_object_ids =  [var.admin_group_object_ids]
#   }
# }

    tags                    = var.tags
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
