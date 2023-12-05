resource "kind_cluster" "main" {
  name       = var.cluster_name
  node_image = var.node_image

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = range(var.number_of_master_nodes)
      content {
        role = "control-plane"
      }
    }

    dynamic "node" {
      for_each = range(var.number_of_worker_nodes)
      content {
        role = "worker"
      }
    }
  }
}
