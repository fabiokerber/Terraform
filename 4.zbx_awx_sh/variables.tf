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

variable "vm_image_publisher" {
  description = "image_publisher"
  type        = string
}

variable "vm_image_offer" {
  description = "image_offer"
  type        = string
}

variable "vm_image_sku" {
  description = "image_sku"
  type        = string
}

variable "vm_image_version" {
  description = "image_version"
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

# Storage Account
variable "sa_name" {
  description = "sa_name"
  type        = string
}

variable "allow_blob_public_access" {
  description = "allow_blob_public_access"
  type        = bool
}

variable "account_tier" {
  description = "account_tier"
  type        = string
}

variable "account_replication_type" {
  description = "account_replication_type"
  type        = string
}

variable "container_access_type" {
  description = "container_access_type"
  type        = string
}

variable "sc_name" {
  description = "sc_name"
  type        = string
}

variable "sb_name" {
  description = "sb_name"
  type        = string
}