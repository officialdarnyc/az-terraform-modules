locals {

     storage_account_private_link_enabled = var.storage_account_private_link_enabled == true ? true : false
     storage_account_private_link_endpoint_name = local.storage_account_private_link_enabled && (var.storage_account_private_link_endpoint_name == null || var.storage_account_private_link_endpoint_name == "") ? "ep-pl-${var.storage_account_name}" : var.storage_account_private_link_endpoint_name
     storage_account_private_link_subnet_id = var.storage_account_private_link_subnet_id == null ? "" : var.storage_account_private_link_subnet_id


     subresource_name = var.subresource_name == "" ? ["blob"] : var.subresource_name

    prevented_file_shares = [
        for file_share in var.file_shares:
            file_share
            if tobool(lookup(file_share, "prevent_destroy", "false")) == true
    ]

    prevented_containers = [
        for container in var.containers:
            container
            if tobool(lookup(container, "prevent_destroy", "false")) == true
    ]

    prevent_destroy = var.prevent_destroy || length(local.prevented_file_shares) > 0 || length(local.prevented_containers) > 0
    
    file_shares = {
        for file_share in var.file_shares:
            lookup(file_share, "share_name") => {
                name = lookup(file_share, "share_name")
                quota = lookup(file_share, "quota", null)
                prevent_destroy = tobool(lookup(file_share, "prevent_destroy", "false"))
            }
    }

    containers = {
        for container in var.containers:
            lookup(container, "container_name") => {
                name = lookup(container, "container_name")
                access_type = lookup(container, "access_type", "private")
                prevent_destroy = tobool(lookup(container, "prevent_destroy", "false"))
            }
    }
}
