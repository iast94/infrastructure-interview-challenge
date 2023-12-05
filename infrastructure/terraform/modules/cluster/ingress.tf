resource "helm_release" "ingress" {
  count = var.install_ingress ? 1 : 0
  name  = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  create_namespace = true
  namespace        = "nginx-ingress"

  depends_on = [kind_cluster.main]

  set {
    name  = "service.type"
    value = "NodePort"
  }
}
