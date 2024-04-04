variable "rg_name" {
  type = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "environment" {
  description = "Application Environment"
  type        = string
}

variable "vnet_address_spaces" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}