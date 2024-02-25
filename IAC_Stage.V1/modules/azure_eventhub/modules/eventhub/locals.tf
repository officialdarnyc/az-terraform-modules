locals {
    descriptions = {
        for description in var.descriptions:
            "${lookup(description, "name")}" => {
                enabled             = lookup(description, "enabled")
                encoding            = lookup(description, "encoding")
                interval_in_seconds = lookup(description, "interval_in_seconds")
                size_limit_in_bytes = lookup(description, "size_limit_in_bytes")
                skip_empty_archives = lookup(description, "skip_empty_archives")
                name                = lookup(description, "name")
                archive_name_format = lookup(description, "archive_name_format")
                blob_container_name = lookup(description, "blob_container_name")
                storage_account_id  = lookup(description, "storage_account_id")
            }
    }
}