resource "local_file" "initialize_definition_file" {
    content = templatefile(local.template_file_name, var.options)
    filename = local.yaml_file_name
}

resource "null_resource" "deploy_resource" {
    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = "kubectl apply -f ${local.yaml_file_name}"
    }
    
    depends_on = [
        local_file.initialize_definition_file
    ]
}

resource "null_resource" "cleanup_resource" {
    for_each = var.cleanup ? { "cleanup" = "-" } : { }

    triggers = {
        always_run = "change-${timestamp()}"
    }

    provisioner "local-exec" {
        command = "del ${local.yaml_file_name}"
    }
    
    depends_on = [
        null_resource.deploy_resource
    ]
}
