variable "application_name" {
  description = "Name of the application"
  type        = string
  default     = "cibg"
}

variable "environment" {
  description = "Application Environment"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "uaenorth"
}