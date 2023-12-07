module "infra-interview-cluster" {
  source       = "../modules/cluster"
  cluster_name = "infra-interview-cluster-dev"

  number_of_master_nodes = 1
  number_of_worker_nodes = 2

  install_monitoring = true
}
