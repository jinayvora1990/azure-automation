
module "azure_key_vault" {
  source = "../../modules/key-vault"

  resource_group_name = module.resource_group.rg_name
  environment         = local.environment
  application_name    = var.application_name
  #  contacts = [
  #    {
  #      email = "random@abc.com"
  #      name  = "random test"
  #    }
  #  ]
}

#
#│ As the `contact` property requires reaching out to the dataplane, to better support private endpoints and keyvaults with public network access disabled,
#│ `contact` will be removed in favour of the `azurerm_key_vault_certificate_contacts` resource in version 4.0 of the AzureRM Provider.