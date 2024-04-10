variable "rg_name" {
  description = "(Mandatory) Name of the resource group"
  type        = list(string)
  default = ["aks-test-rg01"]
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
  default = [
    {
      name           = "example_storage_account"
      resource_group = "aks-test-rg"
      containers     = [
        {
          name        = "example-container"
          access_type = "private"
        }
      ]
      skuname = "Standard_LRS"
    }]
}



variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
  default = "aks-test-rg"
}

variable "location" {
  description = "The name of the location to create the resources in."
  type        = string
  default = "uaenorth"
}


variable "sku" {
  default = "PerGB2018"
}