# Configure Azure Provider
provider "azurerm" {
  features {}
}

# Random string for unique storage account name
resource "random_string" "storage_account_name" {
  length  = 8
  special = false
  upper   = false
}