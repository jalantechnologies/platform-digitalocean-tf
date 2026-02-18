output "do_cluster_id" {
  value = module.digital_ocean.do_cluster_id
}

output "ingress_nginx_service_external_ip" {
  value = module.kubernetes.ingress_nginx_service_external_ip
}

output "atlas_connection_uri" {
  description = "Full MongoDB URI with credentials for Doppler"
  value       = var.atlas_enabled ? module.atlas_mongodb[0].atlas_connection_uri : null
  sensitive   = true
}
