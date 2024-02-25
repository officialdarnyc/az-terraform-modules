resource "null_resource" "aks_initialize_context" {
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = "az aks get-credentials -n ${var.aks_cluster_name} -g ${var.resource_group_name} --admin --overwrite-existing" 
    }

    depends_on = []
}
