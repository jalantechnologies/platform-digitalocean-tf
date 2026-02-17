variable "atlas_org_id" {
  description = "MongoDB Atlas organization ID"
  type        = string
}

variable "atlas_public_key" {
  description = "MongoDB Atlas public API key"
  type        = string
  sensitive   = true
}

variable "atlas_private_key" {
  description = "MongoDB Atlas private API key"
  type        = string
  sensitive   = true
}

variable "atlas_project_name" {
  description = "MongoDB Atlas project name"
  type        = string
}

variable "atlas_cluster_name" {
  description = "MongoDB Atlas cluster name"
  type        = string
}

variable "atlas_provider_name" {
  description = "Atlas provider name"
  type        = string
  default     = "TENANT"
}

variable "atlas_backing_provider_name" {
  description = "Cloud provider for shared clusters"
  type        = string
  default     = "AWS"
}

variable "atlas_region" {
  description = "Atlas region for the cluster"
  type        = string
  default     = "US_EAST_1"
}

variable "atlas_instance_size_name" {
  description = "Atlas instance size (M0 for free tier)"
  type        = string
  default     = "M0"
}

variable "atlas_mongodb_major_version" {
  description = "MongoDB major version"
  type        = string
  default     = "7.0"
}

variable "atlas_database_name" {
  description = "Application database name"
  type        = string
  default     = "app"
}

variable "atlas_database_username" {
  description = "Application database username"
  type        = string
  default     = "app"
}

variable "atlas_database_user_password" {
  description = "Application database user password. If null, Terraform generates one"
  type        = string
  default     = null
  sensitive   = true
}

variable "atlas_access_list_cidrs" {
  description = "CIDR blocks allowed to connect to Atlas"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
