#!/bin/bash
echo "Initializing Terraform with Azure backend..."
terraform init -reconfigure
echo "Backend initialization complete. Your state is now stored in Azure."
