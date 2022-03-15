# Resource Group
variable "location" {
  description = "Location where the resources will be created"
  type        = string
}

variable "resource_name" {
  description = "Name of the resource group"
  type        = string
}

# Network
variable "subnet_name" {
  description = "subnet_name"
  type        = string
}

variable "vnet_name" {
  description = "vnet_name"
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

variable "security_group_name" {
  description = "security_group_name"
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