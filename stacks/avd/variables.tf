variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type        = list(string)
}

variable "storage_accounts" {
  description = "Storage Account details"
  type = list(object({
    name           = string
    resource_group = string
    containers = list(object({
      name        = string
      access_type = string
    }))
    skuname = string
  }))
  default = []
}



variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The name of the location to create the resources in."
  type        = string
}


variable "sku" {
  default = "PerGB2018"
}