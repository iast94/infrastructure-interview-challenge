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

  provisioner "local-exec" {
    command = "kubectl patch -n ingress-nginx deployment ingress-nginx-controller -p '{\"spec\":{\"template\":{\"spec\":{\"containers\":[{\"name\":\"controller\",\"resources\":{\"requests\":{\"cpu\":\"200m\",\"memory\":\"150Mi\"},\"limits\":{\"cpu\":\"500m\",\"memory\":\"300Mi\"}}}]}}}}'"
  }

  provisioner "local-exec" {
    command = "kubectl wait -n ingress-nginx --for=condition=ready --timeout=120s pod -l app.kubernetes.io/component=controller"
  }
}
