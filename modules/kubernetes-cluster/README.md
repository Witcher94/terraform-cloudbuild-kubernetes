<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.cluster_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_initial-node-count"></a> [initial-node-count](#input\_initial-node-count) | n/a | `number` | n/a | yes |
| <a name="input_machine-type"></a> [machine-type](#input\_machine-type) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_network"></a> [network](#input\_network) | n/a | `string` | n/a | yes |
| <a name="input_node-count"></a> [node-count](#input\_node-count) | n/a | `number` | n/a | yes |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | n/a | `bool` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_remove-default-node-pool"></a> [remove-default-node-pool](#input\_remove-default-node-pool) | n/a | `bool` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | variable "service-account" { type = string } | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert"></a> [cert](#output\_cert) | n/a |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
<!-- END_TF_DOCS -->