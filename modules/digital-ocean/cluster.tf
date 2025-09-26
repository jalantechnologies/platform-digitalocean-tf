variable "do_cluster_name" {
  description = "Kubernetes cluster name on DigitalOcean"
}

variable "do_cluster_version" {
  description = "The slug identifier for the version of Kubernetes used for the cluster"
}

variable "do_cluster_region" {
  # list is available at https://slugs.do-api.dev/ on "Regions"
  # default is - New York 1
  description = "The slug identifier for the region where the Kubernetes cluster will be created"
  default     = "nyc1"
}

variable "do_cluster_node_size" {
  # list is available at https://slugs.do-api.dev/ on "Droplet Sizes"
  description = "The slug identifier for the type of Droplet to be used as workers in the node pool"
  default     = "s-2vcpu-4gb"
}

variable "enable_preview_pool" {
  description = "Whether to enable the preview node pool for PR environments"
  type        = bool
  default     = false
}

variable "preview_node_size" {
  description = "The slug identifier for the type of Droplet to be used in the preview node pool"
  type        = string
  default     = "s-2vcpu-4gb"
}

resource "digitalocean_kubernetes_cluster" "do_cluster" {
  name    = var.do_cluster_name
  region  = var.do_cluster_region
  version = var.do_cluster_version

  node_pool {
    name       = "${var.do_cluster_name}-production-pool"
    size       = var.do_cluster_node_size
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
  }

  lifecycle {
    ignore_changes = [
      node_pool[0].auto_scale,
      node_pool[0].min_nodes,
      node_pool[0].max_nodes
    ]
  }
}

resource "digitalocean_kubernetes_node_pool" "do_cluster_staging_pool" {
  count      = var.enable_preview_pool ? 1 : 0
  name       = "${var.do_cluster_name}-staging-pool"
  cluster_id = digitalocean_kubernetes_cluster.do_cluster.id
  size       = var.preview_node_size
  auto_scale = true
  min_nodes  = 1
  max_nodes  = 2

  lifecycle {
    ignore_changes = [
      auto_scale,
      min_nodes,
      max_nodes,
    ]
  }
}

output "do_cluster_id" {
  value = digitalocean_kubernetes_cluster.do_cluster.id
}

output "do_cluster_client_certificate" {
  value = base64decode(digitalocean_kubernetes_cluster.do_cluster.kube_config.0.client_certificate)
}

output "do_cluster_client_key" {
  value = base64decode(digitalocean_kubernetes_cluster.do_cluster.kube_config.0.client_key)
}

output "do_cluster_ca_certificate" {
  value = base64decode(digitalocean_kubernetes_cluster.do_cluster.kube_config.0.cluster_ca_certificate)
}

output "do_cluster_host" {
  value = digitalocean_kubernetes_cluster.do_cluster.kube_config.0.host
}

output "do_cluster_token" {
  value = digitalocean_kubernetes_cluster.do_cluster.kube_config.0.token
}
