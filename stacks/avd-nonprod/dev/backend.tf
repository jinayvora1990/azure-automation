terraform {
  required_version = ">= 1.5.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "uanavddevtfbackend"
    resource_group_name  = "test-rg"
    container_name       = "tfstate"
    key                  = "/avd/nonprod_sub/dev/terraform.tfstate"
    use_azuread_auth     = true
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
