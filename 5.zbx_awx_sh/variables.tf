# Resource Group
variable "location" {
  description = "Location where the resources will be created"
  type        = string
}

variable "resource_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_resource_name" {
  description = "Name of the vm resource group"
  type        = string
}

# Key Vault
variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "kv_rg" {
  description = "Name of the Key Vault resource group"
  type        = string
}

# Network
variable "address_space" {
  description = "address_space"
  type        = list(any)
}

variable "address_prefixes" {
  description = "address_prefixes"
  type        = list(any)
}

variable "vnet_name" {
  description = "vnet_name"
  type        = string
}

variable "subnet_name" {
  description = "subnet_name"
  type        = string
}

variable "vnet_resource_group_name" {
  description = "vnet_resource_group_name"
  type        = string
}

variable "public_ip_name" {
  description = "public_ip_name"
  type        = string
}

variable "allocation_method" {
  description = "allocation_method"
  type        = string
}

variable "network_interface_name" {
  description = "network_interface_name"
  type        = string
}

variable "nic_configuration_name" {
  description = "nic_configuration_name"
  type        = string
}

variable "private_ip_address_allocation" {
  description = "private_ip_address_allocation"
  type        = string
}

variable "idle_timeout_in_minutes" {
  description = "idle_timeout_in_minutes"
  type        = number
}

variable "domain_name_label" {
  description = "domain_name_label"
  type        = string
}

# Security
variable "security_group_name" {
  description = "security_group_name"
  type        = string
}

variable "inbound_rules" {
  description = "inbound_rules"
  type        = map(any)
}

# Virtual Machine
variable "vm_name" {
  description = "vm_name"
  type        = string
}

variable "vm_size" {
  description = "vm_size"
  type        = string
}

variable "vm_disk_name" {
  description = "vm_disk_name"
  type        = string
}

variable "vm_disk_caching" {
  description = "vm_disk_caching"
  type        = string
}

variable "vm_disk_storage_account_type" {
  description = "vm_disk_storage_account_type"
  type        = string
}

variable "vm_computer_name" {
  description = "vm_computer_name"
  type        = string
}

variable "vm_admin_username" {
  description = "vm_admin_username"
  type        = string
}

variable "vm_admin_password" {
  description = "vm_admin_password"
  type        = string
}

variable "vm_disable_password_authentication" {
  description = "vm_disable_password_authentication"
  type        = bool
}

# Custom image
variable "image_name" {
  description = "Name of the VM Custom Image"
  type        = string
}

variable "image_rg" {
  description = "Resource Group of the VM Custom Image"
  type        = string
}

variable "image_id" {
  description = "ID of the VM Custom Image"
  type        = string
}