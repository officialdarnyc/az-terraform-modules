locals {
  tolerations = join(" ", flatten([
      for component_name, tolerations in var.tolerations:[
        for indx, toleration in tolerations:
          " --set ${component_name}.tolerations[${indx}].key=${toleration.key} --set ${component_name}.tolerations[${indx}].value=${toleration.value} --set ${component_name}.tolerations[${indx}].operator=${toleration.operator} --set ${component_name}.tolerations[${indx}].effect=${toleration.effect}"
      ]
  ]))

  is_static_ip_allocation = lower(lookup(var.ingress_settings, "ip_allocation", "Dynamic")) == "static"
  ingress_ip_address = var.ingress_ip_address
  ingress_lb_ip_settings = " --set controller.service.loadBalancerIP=${local.ingress_ip_address} --set controller.service.annotations.\"service\\.beta\\.kubernetes\\.io/azure-dns-label-name\"=${lower(var.ingress_settings.dns_prefix)} "
}