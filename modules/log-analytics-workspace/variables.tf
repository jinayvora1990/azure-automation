variable "resource_location" {
  type        = string
  description = "Region for the backup vault"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the backup vault"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
}

variable "environment" {
  type        = string
  description = "Environment to provision resources"
  validation {
    condition     = can(regex("^(?:dev|qa|sit|uat|prod)$", var.environment))
    error_message = "Allowed values for environment: dev,qa,uat,sit,prod"
  }
}

variable "sku" {
  description = "(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018."
  type        = string
  default     = "PerGB2018"
}

variable "local_authentication_disabled" {
  description = "Specifies if the Log Analytics Workspace should enforce authentication using Azure AD."
  type        = bool
  default     = true
}

variable "retention_in_days" {
  description = "The number of days that logs should be retained."
  type        = number
  default     = 90
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "contributors" {
  description = "A list of users / apps that should have Log Analytics Contributer access. Required to use log analytics as log source."
  type        = list(string)
  default     = []
}