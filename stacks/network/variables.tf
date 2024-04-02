
variable "peering_to_hub_name" {
  default = "peer-avd-to-Hub"
}

variable "nsg_name" {
  default = "nsg-snet-avd-prod-uaenorth-001"
}

variable "vnet_address_spaces" {
  default = ["10.0.0.0.0/24"]
}

#
variable "network_setup" {
  description = "Network setup details"
  type = list(object({
    app_name           = string
    env = string
    nsg_name = list(object({
      name        = string
       security_rules = list(object({
         name                         = string
         priority                     = number
         direction                    = string
         access                       = string
         protocol                     = string
         source_port_range            = string
         destination_port_range       = string
         source_address_prefixes      = list(string)
         destination_address_prefixes = list(string)
         description                  = string
       }))
    }))
    subnet_name = list(object({
      name        = string
      address_prefixes = list(string)
    }))
      }))

  default = [
    {
      app_name = "cibg"
      env = "sit"
      nsg_name = [
        {
          name = "cibg-nsg"
          security_rules = [
            {
              name                         = "default_rule"
              priority                     = 100
              direction                    = "Inbound"
              access                       = "Allow"
              protocol                     = "*"
              source_port_range            = "*"
              destination_port_range       = "*"
              source_address_prefixes      = ["*"]
              destination_address_prefixes = ["*"]
              description                  = "Default security rule"
            },
            {
              name                         = "default_rule_2"
              priority                     = 200
              direction                    = "Outbound"
              access                       = "Deny"
              protocol                     = "*"
              source_port_range            = "*"
              destination_port_range       = "*"
              source_address_prefixes      = ["*"]
              destination_address_prefixes = ["*"]
              description                  = "Default security rule 2"
            }
          ]
        }
      ]
      subnet_name = [
        {
          name = "subnet_1"
          address_prefixes = ["10.0.1.0/24"]
        },{
          name = "subnet_2"
          address_prefixes = ["10.0.2.0/24"]
        }
      ]
    }
  ]

}

