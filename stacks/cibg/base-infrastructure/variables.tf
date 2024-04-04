variable "rg_name" {
  type = string
  default = "test_module"
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default = "cibg"
}

variable "environment" {
  description = "Application Environment"
  type        = string
  default = "sit"
}

variable "vnet_address_spaces" {
  description = "The address space to be used for the Azure virtual network."
  type        = list(string)
  default = ["10.0.0.0/24"]
}

variable "subnets" {
  description = "For each subnet, create an object that contain fields"
  default     = {}
}