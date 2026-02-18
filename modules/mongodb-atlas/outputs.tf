output "atlas_connection_uri" {
  description = "Full connection string with credentials for Doppler"
  value       = "mongodb+srv://${var.atlas_database_username}:${urlencode(local.effective_database_user_password)}@${replace(mongodbatlas_cluster.this.connection_strings[0].standard_srv, "mongodb+srv://", "")}/${var.atlas_database_name}?retryWrites=true&w=majority"
  sensitive   = true
}
