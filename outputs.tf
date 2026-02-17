output "do_cluster_id" {
  value = module.digital_ocean.do_cluster_id
}

output "ingress_nginx_service_external_ip" {
  value = module.kubernetes.ingress_nginx_service_external_ip
}

output "atlas_project_id" {
  value = var.atlas_enabled ? module.atlas_mongodb[0].atlas_project_id : null
}

output "atlas_cluster_name" {
  value = var.atlas_enabled ? module.atlas_mongodb[0].atlas_cluster_name : null
}

output "atlas_connection_uri" {
  value     = var.atlas_enabled ? module.atlas_mongodb[0].atlas_connection_uri : null
  sensitive = true
}

output "atlas_connection_uri_srv" {
  value = var.atlas_enabled ? module.atlas_mongodb[0].atlas_connection_uri_srv : null
}

output "atlas_database_username" {
  value = var.atlas_enabled ? module.atlas_mongodb[0].atlas_database_username : null
}

output "atlas_database_user_password" {
  value     = var.atlas_enabled ? module.atlas_mongodb[0].atlas_database_user_password : null
  sensitive = true
}
