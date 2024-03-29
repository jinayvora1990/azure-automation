
variable "peering_to_hub_name" {
  default = "peer-avd-to-Hub"
}

variable "nsg_name" {
  default = "nsg-snet-avd-prod-uaenorth-001"
}

variable "vnet_address_spaces" {
  default = ["10.0.0.0.0/24"]
}