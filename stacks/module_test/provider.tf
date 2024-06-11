terraform {
  required_version = "~>1.7.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.51.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}