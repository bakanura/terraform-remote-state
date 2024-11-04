# Create Resource Group
resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-storage-rg"
  location = "westeurope" # Change this to your preferred region
}