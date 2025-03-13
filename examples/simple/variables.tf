variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  type        = string
  default     = "example-config-rg"
}

variable "name" {
  description = "The name suffix to use for the storage account (will be concatenated with resource group name)"
  type        = string
  default     = "config"
}

variable "location" {
  description = "The Azure location where the resources should be created"
  type        = string
  default     = "West Europe"
}

variable "create_resource_group" {
  description = "Whether to create a new resource group or use an existing one"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {
    Environment = "Example"
    Owner       = "Terraform"
  }
}

variable "config_values" {
  description = "Map of configuration key-value pairs to store as JSON objects"
  type = map(object({
    noun_value      = string
    adjective_value = string
  }))
  default = {
    "app1" = {
      noun_value      = "system"
      adjective_value = "reliable"
    },
    "app2" = {
      noun_value      = "server"
      adjective_value = "fast"
    }
  }
} 