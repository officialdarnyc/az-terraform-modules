resource "null_resource" "helm-install-nginx-ingress-controller" {

    triggers = {
        helm_version = var.helm_version
        nginx_version = var.nginx_version
        installation_method = var.installation_method
    }
    
    provisioner "local-exec" {
         command = "helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx"   
    }

    provisioner "local-exec" {
         command = "helm repo update"   
    }

    provisioner "local-exec" {
         command = "helm install ingress-nginx ingress-nginx/ingress-nginx --create-namespace --namespace ${var.ingress_namespace} --set controller.replicaCount=${var.replica_count} ${local.tolerations} ${local.ingress_lb_ip_settings} "   
    }

    depends_on = []
}
