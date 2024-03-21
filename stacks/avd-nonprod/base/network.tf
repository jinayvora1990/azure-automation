
module "baseNetworkSetup" {
  source = "../../../modules/network"
  app_name = var.app_name
  env = var.env
  vnet_address_spaces = ["10.0.0.0/24"]


  resource_group_name = "rg-vnet-avd-prod-uaenorth-01"
  virtual_network_name = "vnet-avd-uaenorth-01"

  subnets = {

    avd_subnet = {
      name                            = "snet-avd-prod-uaenorth-001"
      address_prefixes                = ["10.0.1.0/24"]
      private_endpoint_network_policies_enabled = false
    }
    # Add more subnets here if needed
  }

}