output "resource_group_name" {
  value = azurerm_resource_group.tfstate.name
  description = "The name of the resource group"
}

output "access_key" {
  value = azurerm_storage_account.tfstate.primary_access_key
  description = "The primary access key for the storage account"
  sensitive = true
}

# Output the backend configuration for easy copy-paste
output "backend_configuration" {
  description = "Backend configuration for remote state"
  value = 
  <<EOF

  terraform {
    backend "azurerm" {
      resource_group_name  = "${azurerm_resource_group.tfstate.name}"
      storage_account_name = "${azurerm_storage_account.tfstate.name}"
      container_name       = "${azurerm_storage_container.tfstate.name}"
      key                 = "terraform.tfstate"
    }
  }
  EOF
}