module "example_subnets" {
  source = "../../modules/network"

  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
  virtual_network_name = "vnet-avd-uaenorth-01"

  subnets = {
    avd_subnet = {
      name                            = "snet-avd-prod-uaenorth-001"
      address_prefixes                = ["xxx.xxx8.0/24"]
      private_endpoint_network_policy = false
      depends_on                      = []
    },
    w365_subnet = {
      name                            = "snet-w365-prod-uaenorth-001"
      address_prefixes                = ["xxx.xxx9.0/24"]
      private_endpoint_network_policy = false
      depends_on                      = []
    },
    private_endpoint_subnet = {
      name                            = "snet-pe-prod-uaenorth-001"
      address_prefixes                = ["xxx.xxx11.224/27"]
      private_endpoint_network_policy = true
      depends_on                      = [
        azurerm_virtual_network.avd.name,
        azurerm_resource_group.avd.name
      ]
    },
    # Add more subnets here if needed
  }
}
