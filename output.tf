# Outputs for backend configuration
output "storage_account_name" {
  value = azurerm_storage_account.state.name
}

output "container_name" {
  value = azurerm_storage_container.state.name
}

output "resource_group_name" {
  value = azurerm_resource_group.state.name
}

output "backend_config" {
  value = <<EOF

backend "azurerm" {
  resource_group_name  = "${azurerm_resource_group.state.name}"
  storage_account_name = "${azurerm_storage_account.state.name}"
  container_name       = "${azurerm_storage_container.state.name}"
  key                 = "terraform.tfstate"
}
EOF
}

output "next_steps" {
  value = <<EOF

=== BACKEND CREATED SUCCESSFULLY ===

Your Azure Storage backend has been created with:
- Resource Group: ${azurerm_resource_group.state.name}
- Storage Account: ${azurerm_storage_account.state.name}
- Container: ${azurerm_storage_container.state.name}

The backend.tf file has been created automatically.

To initialize the backend, run:
./init-backend.sh

After this, your state will be stored remotely in Azure.
EOF
}
