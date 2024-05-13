variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

variable "metric_alerts" {
  type = map(object({
    scopes = list(string)
    criteria = list(object({
      metric_name      = string
      metric_namespace = string
      aggregation      = string
      threshold        = number
      operator         = string
      dimension = optional(list(object({
        name     = string
        operator = string
        values   = list(string)
      })))
    }))
    actions = list(string)
  }))
  description = "Metric Alerts Configuration"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}
