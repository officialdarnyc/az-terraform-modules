resource "azurerm_servicebus_topic" "servicebus_topic" {
  name						                        = var.servicebus_topic_name
  resource_group_name 		                = var.resource_group_name
  namespace_name      		                = var.servicebus_name
  enable_partitioning 		                = var.enable_partitioning
  status					                        = var.servicebus_topic_status	
  auto_delete_on_idle		 	                = var.auto_delete_on_idle
  max_size_in_megabytes                   = var.max_size_in_megabytes
  requires_duplicate_detection            = var.requires_duplicate_detection
  default_message_ttl                     = var.default_message_ttl
  duplicate_detection_history_time_window = var.duplicate_detection_history_time_window
  enable_batched_operations               = var.enable_batched_operations
  enable_express                          = var.enable_express
  support_ordering                        = var.support_ordering
}