# Create Storage Account
resource "azurerm_storage_account" "state" {
  name                     = "tfstate${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.state.name
  location                 = azurerm_resource_group.state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

}

# Create Blob Container
resource "azurerm_storage_container" "state" {
  name                  = "tfstate${random_string.suffix.result}"
  storage_account_name  = azurerm_storage_account.state.name
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}
