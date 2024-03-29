terraform {
  required_version = ">= 1.5.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0"
    }
  }

#  backend "azurerm" {
#  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
