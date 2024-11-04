# Create Resource Group
resource "azurerm_resource_group" "state" {
  name     = "terraform-state-rg"
  location = "westeurope"  # Change this to your preferred region
}