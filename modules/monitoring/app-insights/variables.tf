variable "resource_location" {
  type        = string
  description = "location of the redis cache"
  default     = "uaenorth"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group for the redis cache"
}

variable "application_name" {
  type        = string
  description = "The application that requires this resource"
}

variable "environment" {
  type        = string
  description = "Environment where redis cache is provisioned"
}

variable "application_type" {
  type        = string
  description = "Type of application insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET."
}

variable "daily_data_cap_in_gb" {
  type        = string
  description = "Specifies the Application Insights component daily data volume cap in GB."
  default     = null
}

variable "daily_data_cap_notifications_disabled" {
  type        = bool
  description = "Specifies if a notification email will be send when the daily data volume cap is met."
  default     = false
}

variable "retention_in_days" {
  type        = number
  description = "Specifies the retention period in days."
  default     = 90
}

variable "sampling_percentage" {
  type        = number
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry."
  default     = 100
}

variable "workspace_id" {
  type        = string
  description = "Specifies the id of a log analytics workspace resource."
  default     = null
}

variable "local_authentication_disabled" {
  type        = bool
  description = "Disable Non-Azure AD based Auth."
  default     = true
}

variable "internet_ingestion_enabled" {
  type        = bool
  description = "Should the Application Insights component support ingestion over the Public Internet?"
  default     = false
}

variable "internet_query_enabled" {
  type        = bool
  description = "Should the Application Insights component support querying over the Public Internet?"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to the resources"
  default     = {}
}
