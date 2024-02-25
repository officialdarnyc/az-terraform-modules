variable "diagnostic_setting_name"{
    type = string
    description = "Diagnostics Settings Name"
}

variable "target_resource_id"{
    type = string
    description = "Diagnostics Settings Target Resource Id"
    default=null
}

variable "storage_account_id"{
    type = string
    description = "Diagnostics Settings Storage Account Id"
    default=null
}

variable "eventhub_name"{
    type = string
    description = "Diagnostics Settings Eventhub name"
    default=null
}

variable "eventhub_authorization_rule_id"{
    type = string
    description = "Diagnostics Settings Eventhub authorization rule id"
    default=null
}

variable "log_analytics_workspace_id"{
    type = string
    description = "Diagnostics Settings log analytics workspace id"
    default=null
}

variable "log_analytics_destination_type"{
    type = string
    description = "Diagnostics Settings log analytics destination type"
    default=null
}

variable "retention_policy_enabled"{
    type = bool
    description = "Diagnostics Settings log analytics destination type"
    default="false"
}

variable "days"{
    type = string
    description = "Retention days"
    default= "7"
}

variable "metric_category"{
    type = string
    description = "Metrics category"
    default="AllMetrics"
}



