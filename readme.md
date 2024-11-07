# Azure Terraform Remote State Module

![Terraform Version](https://img.shields.io/badge/Terraform-%3E%3D1.0.0-blue)
![Azure Provider](https://img.shields.io/badge/Azure%20Provider-%3E%3D3.0-blue)

A comprehensive Terraform module for setting up and managing remote state storage in Azure. This module creates and configures all necessary Azure resources to store Terraform state files securely, including Storage Account, Container, and required access policies.

## 📋 Overview

This module provides a standardized way to:
- Create an Azure Storage Account optimized for Terraform state storage
- Configure secure access with encryption at rest and in transit
- Set up blob versioning for state file history
- Implement proper access controls and networking rules
- Enable diagnostic settings for auditing

## 🚀 Quick Start

```hcl
module "terraform_state" {
  source  = "github.com/bakanura/terraform-remote-state"
  
  resource_group_name  = "rg-terraform-state"
  location            = "eastus2"
  environment         = "prod"
  
  # Optional: Configure custom settings
  storage_account_tier = "Standard"
  replication_type    = "GRS"
  enable_versioning   = true
}
```

## 📝 Prerequisites

- Azure subscription
- Azure CLI installed and configured
- Terraform >= 1.0.0
- Azure Provider >= 3.0

## 🛠️ Module Resources

This module creates the following Azure resources:

- Resource Group (optional)
- Storage Account
- Storage Container
- Storage Account Network Rules (optional)
- Key Vault for access key storage (optional)
- Role Assignments for access control

## ⚙️ Module Configuration

### Basic Usage

```hcl
provider "azurerm" {
  features {}
}

module "terraform_state" {
  source = "github.com/bakanura/terraform-remote-state"

  resource_group_name  = "rg-terraform-state"
  location            = "eastus2"
  storage_account_name = "tfstate${random_string.suffix.result}"
  container_name      = "tfstate"
}

# Generate unique suffix for storage account name
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}
```

### Advanced Usage with All Options

```hcl
module "terraform_state" {
  source = "github.com/bakanura/terraform-remote-state"

  # Required Parameters
  resource_group_name  = "rg-terraform-state"
  location            = "eastus2"
  storage_account_name = "tfstate${random_string.suffix.result}"
  container_name      = "tfstate"

  # Optional Parameters
  tags = {
    Environment = "Production"
    Project     = "Terraform Infrastructure"
  }

  # Storage Account Configuration
  account_tier             = "Standard"
  account_replication_type = "GRS"
  enable_versioning        = true
  min_tls_version         = "TLS1_2"

  # Network Rules
  network_rules = {
    default_action = "Deny"
    ip_rules       = ["203.0.113.0/24"]
    bypass         = ["AzureServices"]
  }
}
```

## 📊 Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region for resources | `string` | n/a | yes |
| storage_account_name | Name of the storage account | `string` | n/a | yes |
| container_name | Name of the blob container | `string` | `"tfstate"` | no |
| account_tier | Tier of the storage account | `string` | `"Standard"` | no |
| account_replication_type | Replication type for the storage account | `string` | `"GRS"` | no |
| enable_versioning | Enable blob versioning | `bool` | `true` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## 📤 Outputs

| Name | Description |
|------|-------------|
| storage_account_id | ID of the created storage account |
| storage_account_name | Name of the created storage account |
| container_name | Name of the created container |
| resource_group_name | Name of the resource group |
| primary_access_key | Primary access key for the storage account (sensitive) |

## 🔒 Security Features

This module implements several security best practices:

- Encryption at rest enabled by default
- Secure transfer required (HTTPS)
- Network rules to restrict access
- Minimum TLS version 1.2
- Blob versioning for state file history
- Access keys stored in Key Vault (optional)

## 🔍 State Backend Configuration

After creating the storage account, configure your Terraform backend:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatexyz123"
    container_name      = "tfstate"
    key                = "prod.terraform.tfstate"
  }
}
```

## 📚 Examples

Check the [examples](./examples) directory for complete working examples:

- [Basic Configuration](./examples/basic)
- [Advanced Configuration with Network Rules](./examples/advanced)
- [Multi-Environment Setup](./examples/multi-environment)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Notes

- Ensure you have appropriate Azure permissions to create these resources
- Consider using service principals for production deployments
- Review the network rules configuration to match your security requirements
- Enable diagnostic logs in production environments

## 🆘 Support

For issues and feature requests, please [open an issue](https://github.com/bakanura/terraform-remote-state/issues) on GitHub.

---

Made with ❤️ by [bakanura](https://github.com/bakanura)