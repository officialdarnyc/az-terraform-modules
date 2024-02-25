resource "azurerm_network_interface" "vm_nic" {
    name                = local.nic_name
    location            = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = local.nic_ip_config_name
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = var.address_allocation
    }
}

resource "azurerm_virtual_machine" "linux_vm" {
    for_each = local.os == "linux" ? { "provision": true } : {}
    name                             = var.name
    location                         = var.location
    resource_group_name              = var.resource_group_name
    network_interface_ids            = [azurerm_network_interface.vm_nic.id]
    vm_size                          = var.sku
    delete_os_disk_on_termination    = var.delete_os_disk_on_termination
    delete_data_disks_on_termination = var.delete_data_disks_on_termination

    dynamic "storage_image_reference" {
        for_each = length(var.image_uri == null ? "" : var.image_uri) == 0 ? [ "provision" ] : []
        content {
            publisher                    = local.image_publisher
            offer                        = local.image_offer
            sku                          = local.image_sku
            version                      = local.image_version
        }
    }
    dynamic "storage_image_reference" {
        for_each = length(var.image_uri == null ? "" : var.image_uri) > 0 ? [ "provision" ] : []
        content {
            id                           = var.image_uri
            version                      = var.image_uri_version
        }
    }

    storage_os_disk {
        name                         = local.os_disk_name
        caching                      = "ReadWrite"
        create_option                = "FromImage"
        managed_disk_type            = var.disk_type
    }

    os_profile {
        computer_name                = local.computer_name
        admin_username               = var.username
        admin_password               = var.password
    }

    os_profile_linux_config {
        disable_password_authentication = var.disable_password_authentication
    }

    tags                             = var.tags
}

resource "azurerm_virtual_machine" "windows_vm" {
    for_each = local.os == "windows" ? { "provision": true } : {}
    name                             = var.name
    location                         = var.location
    resource_group_name              = var.resource_group_name
    network_interface_ids            = [azurerm_network_interface.vm_nic.id]
    vm_size                          = var.sku
    delete_os_disk_on_termination    = var.delete_os_disk_on_termination
    delete_data_disks_on_termination = var.delete_data_disks_on_termination

    dynamic "storage_image_reference" {
        for_each = length(var.image_uri == null ? "" : var.image_uri) == 0 ? [ "provision" ] : []
        content {
            publisher                    = local.image_publisher
            offer                        = local.image_offer
            sku                          = local.image_sku
            version                      = local.image_version
        }
    }
    dynamic "storage_image_reference" {
        for_each = length(var.image_uri == null ? "" : var.image_uri) > 0 ? [ "provision" ] : []
        content {
            id                           = var.image_uri
            version                      = var.image_uri_version
        }
    }

    storage_os_disk {
        name                         = local.os_disk_name
        caching                      = "ReadWrite"
        create_option                = "FromImage"
        managed_disk_type            = var.disk_type
    }

    os_profile {
        computer_name                = local.computer_name
        admin_username               = var.username
        admin_password               = var.password
    }

    os_profile_windows_config {
        provision_vm_agent           = var.provision_vm_agent
        enable_automatic_upgrades    = var.enable_automatic_upgrades
        timezone                     = local.timezone
    }

    tags                             = var.tags
}