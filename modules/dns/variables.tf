variable "dns_zone_name" {
  type        = string
  description = "The name of the private dns zone"
}

variable "vnet_name" {
  type        = string
  description = "The virtual network name which contains the pep for the resource"
}

variable "resource_group" {
  type        = string
  description = "Existing resource group"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "User defined extra tags to be added to all resources created in the module"
  default     = {}
}