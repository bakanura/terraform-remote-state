terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

# Generate random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

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
  filename = "${path.module}/init-backend.sh"
  content  = <<EOF
#!/bin/bash
echo "Initializing Terraform with Azure backend..."
terraform init -reconfigure
echo "Backend initialization complete. Your state is now stored in Azure."
EOF

  provisioner "local-exec" {
    command = "chmod +x ${path.module}/init-backend.sh"
  }
}
