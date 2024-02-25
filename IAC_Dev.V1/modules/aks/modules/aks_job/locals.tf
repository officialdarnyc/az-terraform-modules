locals {
    restart_policy = var.restart_policy == null ? "OnFailure" : var.restart_policy
    backoff_limit = var.backoff_limit == null ? "3" : var.backoff_limit
    suspend = var.suspend == null || var.suspend == "" ? "" : "suspend: ${var.suspend}"
    parallelism = var.parallelism == null ? "" : "parallelism: ${var.parallelism}"
    completions = var.completions == null ? "" : "completions: ${var.completions}"
    ttl_seconds_after_finished = var.ttl_seconds_after_finished == null ? "" : "ttlSecondsAfterFinished: ${var.ttl_seconds_after_finished}"
    environment_variables = [
        for indx, environment_variable in var.environment_variables: {
            key = lookup(environment_variable, "key", null)
            value = lookup(environment_variable, "value", null)
        }
        if lookup(environment_variable, "key", null) != null && lookup(environment_variable, "value", null) != null
    ]
}
