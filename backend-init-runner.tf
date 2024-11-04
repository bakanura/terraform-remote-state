# Create the backend configuration file
resource "local_file" "backend_config" {
  filename = "${path.module}/backend.tf"
  content  = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "${azurerm_resource_group.state.name}"
    storage_account_name = "${azurerm_storage_account.state.name}"
    container_name      = "${azurerm_storage_container.state.name}"
    key                 = "terraform.tfstate"
  }
}
EOF
}

# Create a script to initialize the backend
resource "local_file" "init_script" {
depends_on= [
  azurerm_storage_account.state,
  azurerm_storage_container.state
]
  filename = "${path.module}/init-backend.sh"
  content  = <<EOF
#!/bin/bash

echo "Initializing Terraform with Azure backend..."
# Using -auto-approve flag for reconfigure
terraform init -reconfigure -migrate-state -force-copy -input=false

echo "Backend initialization complete. Your state is now stored in Azure."

# Remove local state files
rm -rf terraform.tfstate
rm -rf terraform.tfstate.backup

# Optional: Add error handling
if [ $? -eq 0 ]; then
    echo "Successfully initialized and cleaned up local state files"
else
    echo "Error occurred during initialization"
    exit 1
fi
EOF

  provisioner "local-exec" {
    command = <<-EOF
      #!/bin/bash
      chmod +x ${path.module}/init-backend.sh
      ${path.module}/init-backend.sh
      EOF
      
  }
}
