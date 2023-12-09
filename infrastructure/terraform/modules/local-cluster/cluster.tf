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
        kubeadm_config_patches = [
          "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
        ]

        extra_port_mappings {
            container_port = 80
            host_port      = 80
        }
        extra_port_mappings {
            container_port = 443
            host_port      = 443
        }
      }
    }

    dynamic "node" {
      for_each = range(var.number_of_worker_nodes)
      content {
        role = "worker"
      }
    }
  }

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml"
  }
}
