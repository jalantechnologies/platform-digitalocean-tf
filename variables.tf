variable "cluster_issuer_email" {
  description = "Email address used for ACME registration for Kubernetes CertManager service"
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
