module "infra-interview-cluster" {
  source       = "../../modules/local-cluster"
  cluster_name = "infra-interview-cluster-dev"

  number_of_master_nodes = 1
  number_of_worker_nodes = 3

  install_monitoring = false
  enable_hpa         = true
}
