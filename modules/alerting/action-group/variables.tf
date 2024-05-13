variable "resource_group_name" {
  type        = string
  description = "The resource group for the Azure Monitor"
}

variable "action_groups" {
  type = map(object({
    webhook_receiver = optional(
      map(
        object({
          service_uri = string
        })
    )),
    email_receiver = optional(
      map(
        object({
          email_address = string
        })
    ))
    event_hub_receiver = optional(
      map(
        object({
          event_hub_name      = string
          event_hub_namespace = string
        })
    ))
  }))
  description = "Action groups configuration"
  default     = {}
  validation {
    condition = alltrue([
      for action_group in values(var.action_groups) : (action_group.webhook_receiver != null || action_group.email_receiver != null || action_group.event_hub_receiver != null)
    ])
    error_message = "Every action group should have either 'webhook receiver' or 'email receiver' or 'eventhub receiver'"
  }
}