variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

variable "activity_log_alert" {
  type = map(object({
    scopes = list(string)
    criteria = object({
      category           = string
      caller             = optional(string)
      operation_name     = optional(string)
      levels             = optional(list(string))
      statuses           = optional(list(string))
      sub_statuses       = optional(list(string))
      resource_providers = optional(list(string))
      resource_types     = optional(list(string))
      resource_groups    = optional(list(string))
      resource_ids       = optional(list(string))
      service_health = optional(object({
        events    = list(string)
        locations = optional(list(string))
        services  = list(string)
      }))
      resource_health = optional(object({
        current  = list(string)
        previous = list(string)
        reason   = list(string)
      }))
    })
    actions = list(string)
  }))
  description = "The activity log alert configuration"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}