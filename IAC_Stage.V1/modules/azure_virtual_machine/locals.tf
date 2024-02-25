locals {
    nic_name = "nic-${var.name}"
    nic_ip_config_name = "nicip-${var.name}"
    os = var.os == null || var.os != "linux" ? "windows" : "linux"
    image_publisher = length(var.image_publisher == null ? "" : var.image_publisher) > 0 ? var.image_publisher : (local.os == "linux" ? "Canonical" : "MicrosoftWindowsServer")
    image_offer = length(var.image_offer == null ? "" : var.image_offer) > 0 ? var.image_offer : (local.os == "linux" ? "UbuntuServer" : "WindowsServer")
    image_sku = length(var.image_sku == null ? "" : var.image_sku) > 0 ? var.image_sku : (local.os == "linux" ? "16.04-LTS" : "2016-Datacenter")
    image_version = length(var.image_version == null ? "" : var.image_version) > 0 ? var.image_version : (local.os == "linux" ? "latest" : "latest")
    os_disk_name = "osd-${var.name}"
    computer_name = length(var.computer_name == null ? "" : var.computer_name) > 0 ? var.computer_name : var.name
    timezone = length(var.timezone == null ? "" : var.timezone) > 0 ? var.timezone : "Eastern Standard Time"
}
