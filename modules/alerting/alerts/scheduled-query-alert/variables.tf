variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

/*variable "application_name" {
  type        = string
  description = "The application that requires this resource"
}*/

/*variable "environment" {
  type        = string
  description = "Environment where redis cache is provisioned"
  validation {
    condition     = can(regex("^(?:dev|qa|sit|uat|prod)$", var.environment))
    error_message = "Allowed values for environment: dev,qa,uat,sit,prod"
  }
}*/

variable "log_search_alerts" {
  type = map(object({
    name                 = string
    scopes               = list(string)
    severity             = number
    window_duration      = string
    evaluation_frequency = string
    criteria = object({
      operator                = string
      query                   = string
      threshold               = number
      time_aggregation_method = string
      metric_measure_column   = string
      resource_id_column      = string
      dimension = optional(object({
        name     = string
        operator = string
        values   = list(string)
      }))
      failing_periods = optional(object({
        minimum_failing_periods_to_trigger_alert = number
        number_of_evaluation_periods             = number
      }))
    })
    actions = list(string)
  }))
  description = "The log scheduled query alert map"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}
