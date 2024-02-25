resource "azurerm_eventhub" "eventhub" {
    name                = var.eventhub_name
    namespace_name      = var.eventhub_namespace
    resource_group_name = var.resource_group_name
    partition_count     = var.partition_count
    message_retention   = var.message_retention
    status              = var.eventhub_status

    dynamic "capture_description" {
        for_each = local.descriptions
        content {
            enabled             = capture_description.value.enabled
            encoding            = capture_description.value.encoding
            interval_in_seconds = capture_description.value.interval_in_seconds
            size_limit_in_bytes = capture_description.value.size_limit_in_bytes
            skip_empty_archives = capture_description.value.skip_empty_archives
            destination {
                name                 = capture_description.value.name
                archive_name_format  = capture_description.value.archive_name_format
                blob_container_name  = capture_description.value.blob_container_name
                storage_account_id   = capture_description.value.storage_account_id
            }
        }
    }
}