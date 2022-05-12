# Variables
variable "environment" {
  description = "Subscription que o recurso será criado"
  type        = string
}

variable "objective" {
  description = "Objetivo do sistema/recurso"
  type        = string
}

variable "owner" {
  description = "Responsável pelo sistema/recurso"
  type        = string
}

variable "system" {
  description = "Sistema"
  type        = string
}

variable "centro_custo" {
  description = "Centro de custo do recurso"
  type        = string
  default     = "opbk"
}

variable "repositorio" {
  description = "Repositório do código da infraestrutura"
  type        = string
  default     = ""
}

variable "backend_sa" {
  description = "Backend do tf state file"
  type        = string
  default     = ""
}

variable "backend_key" {
  description = "Nome do tf state file"
  type        = string
  default     = ""
}

variable "tags_custom" {
  description = "Tags customizadas"
  type        = map(any)
  default     = {}
}

# Module
module "tags" {
  source = "git::https://pusrdvop:OTA5OTk5OTQ5NjM5OnUGGcZ4iOMS5I6eMPBMKf+VRrtA@bitbucket.bradesco.com.br:8443/scm/tfmopban/opbk-tfm-tags-default.git?ref=latest"

  # Tags
  environment  = var.environment
  objective    = var.objective
  owner        = var.owner
  system       = var.system
  centro_custo = var.centro_custo
  repositorio  = var.repositorio
  backend_sa   = var.backend_sa
  backend_key  = var.backend_key
  tags_custom  = var.tags_custom
}

# Output
output "environment" {
  description = "Subscrição onde o recurso será criado"
  value       = var.environment
}

output "system" {
  description = "Sistema"
  value       = var.system
}

output "objective" {
  description = "Objetivo do sistema/recurso"
  value       = var.objective
}

output "owner" {
  description = "Responsável pelo sistema/recurso"
  value       = var.owner
}

output "centro_custo" {
  description = "Centro de custo do recurso"
  value       = var.centro_custo
}

output "repositorio" {
  description = "Repositório do código da infraestrutura"
  value       = var.repositorio
}

output "backend_sa" {
  description = "Backend do tf state file"
  value       = var.backend_sa
}

output "backend_key" {
  description = "Nome do tf state file"
  value       = var.backend_sa
}

output "tags_custom" {
  description = "Tags customizadas"
  value       = var.tags_custom
}
