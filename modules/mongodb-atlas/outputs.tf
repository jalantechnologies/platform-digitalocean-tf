output "atlas_project_id" {
  description = "MongoDB Atlas project ID"
  value       = mongodbatlas_project.this.id
}

output "atlas_cluster_name" {
  description = "MongoDB Atlas cluster name"
  value       = mongodbatlas_cluster.this.name
}

output "atlas_connection_uri" {
  description = "Connection string including credentials"
  value       = "mongodb+srv://${var.atlas_database_username}:${urlencode(local.effective_database_user_password)}@${replace(mongodbatlas_cluster.this.connection_strings[0].standard_srv, "mongodb+srv://", "")}/${var.atlas_database_name}?retryWrites=true&w=majority"
  sensitive   = true
}

output "atlas_connection_uri_srv" {
  description = "SRV connection string without credentials"
  value       = mongodbatlas_cluster.this.connection_strings[0].standard_srv
}

output "atlas_database_username" {
  description = "MongoDB Atlas database user"
  value       = var.atlas_database_username
}

output "atlas_database_user_password" {
  description = "MongoDB Atlas database user password"
  value       = local.effective_database_user_password
  sensitive   = true
}
