variable "cluster_issuer_email" {
  description = "Email address used for ACME registration for Kubernetes CertManager service"
}

variable "enable_preview_pool" {
  description = "Terraform Cloud preview pool setting (organization-level)"
  type        = bool
  default     = false
}

variable "preview_node_size" {
  description = "Terraform Cloud preview node size (organization-level)"
  type        = string
  default     = ""
}

variable "do_cluster_name" {
  description = "Kubernetes cluster name on DigitalOcean"
}

variable "do_token" {
  description = "Access token for managing resources on DigitalOcean with write access"
}

variable "do_alert_email" {
  description = "Email address to be used for sending resource utilization alerts"
}

variable "do_cluster_version" {
  # list is available at https://slugs.do-api.dev/ on "Kubernetes Versions"
  description = "The slug identifier for the version of Kubernetes used for the cluster"
}

variable "atlas_enabled" {
  description = "Enable MongoDB Atlas provisioning"
  type        = bool
  default     = false
}

variable "atlas_org_id" {
  description = "MongoDB Atlas organization ID"
  type        = string
  default     = ""
}

variable "atlas_public_key" {
  description = "MongoDB Atlas public API key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "atlas_private_key" {
  description = "MongoDB Atlas private API key"
  type        = string
  default     = ""
  sensitive   = true
}

variable "atlas_project_name" {
  description = "MongoDB Atlas project name"
  type        = string
  default     = "platform-apps"
}

variable "atlas_cluster_name" {
  description = "MongoDB Atlas cluster name"
  type        = string
  default     = "Cluster0"
}

variable "atlas_provider_name" {
  description = "MongoDB Atlas provider name"
  type        = string
  default     = "TENANT"
}

variable "atlas_backing_provider_name" {
  description = "Cloud provider backing Atlas shared clusters"
  type        = string
  default     = "AWS"
}

variable "atlas_region" {
  description = "MongoDB Atlas region for the cluster"
  type        = string
  default     = "AP_SOUTH_1"
}

variable "atlas_instance_size_name" {
  description = "MongoDB Atlas instance size"
  type        = string
  default     = "M0"
}

variable "atlas_mongodb_major_version" {
  description = "MongoDB Atlas major version"
  type        = string
  default     = "7.0"
}

variable "atlas_database_name" {
  description = "MongoDB database name for app access"
  type        = string
  default     = "app"
}

variable "atlas_database_username" {
  description = "MongoDB database username for app access"
  type        = string
  default     = "app"
}

variable "atlas_database_user_password" {
  description = "MongoDB database user password. If null, Terraform generates one"
  type        = string
  default     = null
  sensitive   = true
}

variable "atlas_access_list_cidrs" {
  description = "CIDR blocks allowed to connect to MongoDB Atlas"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
