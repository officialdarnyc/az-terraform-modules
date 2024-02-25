resource "azurerm_servicebus_queue" "servicebus_queue" {
  name 						                        = var.servicebus_queue_name
  resource_group_name 		                = var.resource_group_name
  namespace_name      		                = var.servicebus_name
  enable_partitioning 		                = var.enable_partitioning
  status					                        = var.servicebus_queue_status	
  lock_duration		 	    	                = var.lock_duration
  auto_delete_on_idle		 	                = var.auto_delete_on_idle
  max_size_in_megabytes                   = var.max_size_in_megabytes
  requires_duplicate_detection            = var.requires_duplicate_detection
  requires_session                        = var.requires_session
  default_message_ttl                     = var.default_message_ttl
  dead_lettering_on_message_expiration    = var.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = var.duplicate_detection_history_time_window
  max_delivery_count                      = var.max_delivery_count
  enable_batched_operations               = var.enable_batched_operations
  enable_express                          = var.enable_express
  forward_to                              = var.forward_to
  forward_dead_lettered_messages_to       = var.forward_dead_lettered_messages_to
}