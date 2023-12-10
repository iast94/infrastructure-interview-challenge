resource "helm_release" "metrics_server" {
  count = var.enable_hpa ? 1 : 0
  name  = "metrics-server"

  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = "3.11.0"

  namespace = "kube-system"

  depends_on = [kind_cluster.main]

  set_list {
    name  = "args"
    value = ["--kubelet-insecure-tls"]
  }

  lifecycle {
    replace_triggered_by = [kind_cluster.main]
  }
}
