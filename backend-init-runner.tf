# # Create the backend configuration file
# resource "local_file" "backend_config" {
#   filename = "${path.module}/backend.tf"
#   content  = <<EOF
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "${azurerm_resource_group.state.name}"
#     storage_account_name = "${azurerm_storage_account.state.name}"
#     container_name      = "${azurerm_storage_container.state.name}"
#     key                 = "terraform.tfstate"
#   }
# }
# EOF
# }

# Create a script to initialize the backend
resource "local_file" "init_script" {
  filename = "${path.module}/init-backend.sh"
  content  = <<EOF1
#!/bin/bash

# Create backend.tf configuration file
cat <<EOF2 > backend.tf
terraform {
   backend "azurerm" {
     resource_group_name  = "${azurerm_resource_group.state.name}"
     storage_account_name = "${azurerm_storage_account.state.name}"
     container_name       = "${azurerm_storage_container.state.name}"
     key                  = "terraform.tfstate"
   }
}
EOF2

# Initialize Terraform with Azure backend
echo "Initializing Terraform with Azure backend..."
terraform init -reconfigure -auto-approve
echo "Backend initialization complete. Your state is now stored in Azure."

# Clean up local state files
rm -rf terraform.tfstate
rm -rf terraform.tfstate.backup
EOF1

  provisioner "local-exec" {
    command = "chmod +x ${path.module}/init-backend.sh"
  }
}
