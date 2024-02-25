locals {
    template_path = var.template_path == null ? "${path.module}/templates/" : var.template_path
    
    template_name = var.template_name == null ? var.resource_type : var.template_name

    template_file_name = var.template_file_name == null ? "${local.template_path}${local.template_name}.tpl" : var.template_file_name
    
    file_name_prefix = "${var.resource_group_name}_${var.aks_cluster_name}_${var.resource_type}_${lookup(var.options, "name")}"
    
    yaml_file_name = "${local.file_name_prefix}.yml"
}
