# Create Storage Account
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.storage_account_name.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  blob_properties {
    versioning_enabled = true
  }
}

# Create Container
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# Output the storage account key and other details needed for backend configuration
output "storage_account_name" {
  value = azurerm_storage_account.tfstate.name
  description = "The name of the storage account"
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
  description = "The name of the storage container"
}