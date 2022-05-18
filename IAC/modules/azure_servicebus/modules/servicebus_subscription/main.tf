resource "azurerm_servicebus_subscription" "servicebus_subscription" {
  name                                      = var.subscription_name
  resource_group_name                       = var.resource_group_name
  namespace_name                            = var.servicebus_name
  topic_name                                = var.servicebus_topic_name
  max_delivery_count                        = var.max_delivery_count
  auto_delete_on_idle		 	                  = var.auto_delete_on_idle
  default_message_ttl                       = var.default_message_ttl
  lock_duration		 	    	                  = var.lock_duration
  dead_lettering_on_message_expiration      = var.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error = var.dead_lettering_on_filter_evaluation_error
  enable_batched_operations                 = var.enable_batched_operations
  requires_session                          = var.requires_session
  forward_to                                = var.forward_to
  forward_dead_lettered_messages_to         = var.forward_dead_lettered_messages_to
  status					                          = var.servicebus_subscription_status
}