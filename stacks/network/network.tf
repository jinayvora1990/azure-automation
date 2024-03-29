
module "network_setup" {
  source = "../../modules/network"
  app_name = "cibg-development"
  env = "sit"
  vnet_address_spaces = var.vnet_address_spaces
  nsg_name            = var.nsg_name
  peering_to_hub_name = var.peering_to_hub_name
  subnets = {
    subnet1 = {
      name                            = "subnet1"
      address_prefixes                = ["10.0.1.0/24"]
      private_endpoint_network_policies_enabled = true
    }
    subnet2 = {
      name                            = "subnet2"
      address_prefixes                = ["10.0.2.0/24"]
      private_endpoint_network_policies_enabled = false
    }
  }
  security_rules = []
}