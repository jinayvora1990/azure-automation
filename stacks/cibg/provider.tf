terraform {
  required_version = "~>1.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
  }
  #  backend "azurerm" {
  #  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
