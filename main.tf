terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }

    local = {
      source  = "hashicorp/local"
    }

    random = {
      source  = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}
    use_cli = true
  }

# Generate random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}