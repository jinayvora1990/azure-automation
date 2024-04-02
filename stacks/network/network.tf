module "base_network_setup" {
  source = "../../modules/network"
  #for_each = { for idx in var.network_setup : idx.env => idx }


  for_each = { for idx in var.network_setup : idx =>  {

    key1 = var.network_setup[env]
    key2 = var.nsg_name[name]
  }}

  app_name = each.value.name
  env = each.value.env
  nsg_name = each.value.nsg_name.name
  peering_to_hub_name = var.peering_to_hub_name
  vnet_address_spaces = var.vnet_address_spaces
  subnet_address_prefixes = each.value.subnet_name[*].address_prefixes

  subnet_name = each.value.subnet_name.name
}


# NSG, route Table, subnet.