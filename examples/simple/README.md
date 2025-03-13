# Simple Configuration Store Example

This example demonstrates how to use the `terraform-azurerm-config-store` module to create an Azure Storage Account for storing configuration as JSON blobs.

## Usage

To run this example:

```bash
terraform init
terraform plan
terraform apply
```

You can also copy the included terraform.tfvars.example to terraform.tfvars and modify the values:

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your preferred values
terraform apply
```

## Features Demonstrated

- Creating a new Azure Resource Group
- Creating an Azure Storage Account with a computed name
- Storing JSON configuration objects as blobs
- Using the static website hosting capability to serve the configuration
- Proper provider configuration in the root module

## Outputs

| Name | Description |
|------|-------------|
| storage_account_name | The name of the created storage account |
| config_blob_urls | Map of URLs to access each configuration blob | 