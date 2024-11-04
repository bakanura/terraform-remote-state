#!/bin/bash
echo "Initializing Terraform with Azure backend..."
terraform init -reconfigure -force-copy -input=false
echo "Backend initialization complete. Your state is now stored in Azure."

# Remove local state files
rm -rf terraform.tfstate
rm -rf terraform.tfstate.backup