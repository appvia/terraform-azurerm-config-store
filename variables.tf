variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  type        = string
  validation {
    condition     = length(replace(lower(var.resource_group_name), "/[^a-z0-9]/", "")) > 0
    error_message = "Resource group name must contain at least one alphanumeric character."
  }
}

variable "name" {
  description = "The name suffix to use for the storage account (will be concatenated with resource group name)"
  type        = string
  validation {
    condition     = length(replace(lower(var.name), "/[^a-z0-9]/", "")) > 0
    error_message = "Name must contain at least one alphanumeric character."
  }
}

variable "location" {
  description = "The Azure location where the resources should be created"
  type        = string
  default     = "West Europe"
}

variable "create_resource_group" {
  description = "Whether to create a new resource group or use an existing one"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "config_values" {
  description = "Map of configuration key-value pairs to store as JSON objects"
  type = map(object({
    noun_value      = string
    adjective_value = string
  }))
  default = {}
} 