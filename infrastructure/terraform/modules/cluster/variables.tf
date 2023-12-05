variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "node_image" {
  type        = string
  description = "Container image used as a kubernetes node"
  default     = "kindest/node:v1.27.1"
}

variable "number_of_master_nodes" {
  type        = number
  description = "Number of master nodes"
  default     = 1
}

variable "number_of_worker_nodes" {
  type        = number
  description = "Number of worker nodes"
  default     = 1
}

variable "install_monitoring" {
  type        = string
  description = "Install monitoring stack?"
  default     = false
}

variable "install_ingress" {
  type        = bool
  description = "Install ingress stack?"
  default     = false
}
