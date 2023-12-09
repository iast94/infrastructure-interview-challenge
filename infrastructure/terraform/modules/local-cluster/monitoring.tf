resource "helm_release" "monitoring" {
  count = var.install_monitoring ? 1 : 0
  name  = "kube-prometheus"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"

  create_namespace = true
  namespace        = "monitoring"

  depends_on = [kind_cluster.main]

  lifecycle {
    replace_triggered_by = [kind_cluster.main]
  }
}
