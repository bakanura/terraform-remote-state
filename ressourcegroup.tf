# Create Resource Group
resource "azurerm_resource_group" "state" {
  name     = "tfstate-storage-rg-${random_string.suffix.result}"
  location = "westeurope" # Change this to your preferred region
}