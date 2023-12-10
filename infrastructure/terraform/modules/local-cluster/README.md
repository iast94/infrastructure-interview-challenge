<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.12.1 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | 0.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.12.1 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | 0.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [helm_release.monitoring](https://registry.terraform.io/providers/hashicorp/helm/2.12.1/docs/resources/release) | resource |
| [kind_cluster.main](https://registry.terraform.io/providers/tehcyx/kind/0.2.1/docs/resources/cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_enable_hpa"></a> [enable\_hpa](#input\_enable\_hpa) | Enable horizontal pod autoscale? | `string` | `false` | no |
| <a name="input_install_monitoring"></a> [install\_monitoring](#input\_install\_monitoring) | Install monitoring stack? | `string` | `false` | no |
| <a name="input_node_image"></a> [node\_image](#input\_node\_image) | Container image used as a kubernetes node | `string` | `"kindest/node:v1.27.1"` | no |
| <a name="input_number_of_master_nodes"></a> [number\_of\_master\_nodes](#input\_number\_of\_master\_nodes) | Number of master nodes | `number` | `1` | no |
| <a name="input_number_of_worker_nodes"></a> [number\_of\_worker\_nodes](#input\_number\_of\_worker\_nodes) | Number of worker nodes | `number` | `1` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->