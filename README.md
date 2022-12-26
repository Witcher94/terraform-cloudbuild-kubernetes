# terraform-cloudbuild-kubernetes
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.44.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.16.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.44.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_kubernetes-cluster"></a> [kubernetes-cluster](#module\_kubernetes-cluster) | ./modules/kubernetes-cluster | n/a |
| <a name="module_secret-manager"></a> [secret-manager](#module\_secret-manager) | ./modules/secret-manager | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnets | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/4.44.1/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Change for other id and display-name for SA, by default in format var.name-service-account | `string` | `""` | no |
| <a name="input_allocate_option"></a> [allocate\_option](#input\_allocate\_option) | nat\_ip\_allocate\_option - How external IPs should be allocated for this NAT. | `string` | `"AUTO_ONLY"` | no |
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field. Related to VPC module | `string` | `"kubernetes vpc"` | no |
| <a name="input_initial-node-count"></a> [initial-node-count](#input\_initial-node-count) | The number of nodes to create in this cluster's default node pool. | `number` | `1` | no |
| <a name="input_ip_ranges_to_nat"></a> [ip\_ranges\_to\_nat](#input\_ip\_ranges\_to\_nat) | source\_subnetwork\_ip\_ranges\_to\_nat - How NAT should be configured per Subnetwork | `string` | `"ALL_SUBNETWORKS_ALL_IP_RANGES"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Defined labels for the secret | `string` | `"redis"` | no |
| <a name="input_length"></a> [length](#input\_length) | The secret length | `number` | `10` | no |
| <a name="input_machine-type"></a> [machine-type](#input\_machine-type) | The name of a Google Compute Engine machine type. Defaults to e2-medium. | `string` | `"e2-micro"` | no |
| <a name="input_members"></a> [members](#input\_members) | Who will achieve the roles | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_min_lower"></a> [min\_lower](#input\_min\_lower) | min number of lower literals | `number` | `2` | no |
| <a name="input_min_numeric"></a> [min\_numeric](#input\_min\_numeric) | min number of numbers in secret | `number` | `2` | no |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | min number of special symbols in secret | `number` | `2` | no |
| <a name="input_min_upper"></a> [min\_upper](#input\_min\_upper) | Min number of upper literals | `number` | `2` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for all of the services | `string` | `"redis"` | no |
| <a name="input_node-count"></a> [node-count](#input\_node-count) | The number of nodes per instance group. | `number` | `1` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | A boolean that represents whether or not the underlying node VMs are preemptible. | `bool` | `false` | no |
| <a name="input_remove-default-node-pool"></a> [remove-default-node-pool](#input\_remove-default-node-pool) | If true, deletes the default node pool upon cluster creation.google\_container\_node\_pool resources with no value,default initial-node-count = 1 | `bool` | `true` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | defined roles | `set(string)` | <pre>[<br>  "roles/iap.tunnelResourceAccessor",<br>  "roles/compute.instanceAdmin.v1",<br>  "roles/iam.serviceAccountUser",<br>  "roles/storage.admin"<br>]</pre> | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL'), Related to VPC module | `string` | `"GLOBAL"` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | Coma separated map, to add new rule copy an example above | `map` | <pre>{<br>  "firewall-rule-1": {<br>    "allow": [<br>      {<br>        "ports": [<br>          "6379"<br>        ],<br>        "protocol": "tcp"<br>      }<br>    ],<br>    "deny": [],<br>    "description": null,<br>    "direction": "INGRESS",<br>    "name": "allow-http",<br>    "priority": 1000,<br>    "ranges": [<br>      "10.20.30.0/24"<br>    ],<br>    "source_service_accounts": null,<br>    "source_tags": null,<br>    "target_service_accounts": null,<br>    "target_tags": null<br>  },<br>  "firewall-rule-2": {<br>    "allow": [<br>      {<br>        "ports": [<br>          "22"<br>        ],<br>        "protocol": "tcp"<br>      }<br>    ],<br>    "deny": [],<br>    "description": null,<br>    "direction": "INGRESS",<br>    "name": "allow-iap",<br>    "priority": 1000,<br>    "ranges": [<br>      "35.235.240.0/20"<br>    ],<br>    "source_service_accounts": null,<br>    "source_tags": null,<br>    "target_service_accounts": null,<br>    "target_tags": null<br>  }<br>}</pre> | no |
| <a name="input_secret_id"></a> [secret\_id](#input\_secret\_id) | id of the secret | `string` | `"redis-node-secret"` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Input Variables for subnet module | `map` | <pre>{<br>  "subnet-1": {<br>    "ip": "10.20.30.0/24",<br>    "name": "public",<br>    "region": "europe-west3",<br>    "subnet_flow_logs": "true",<br>    "subnet_flow_logs_filter_expr": "true",<br>    "subnet_flow_logs_interval": "INTERVAL_10_MIN",<br>    "subnet_flow_logs_metadata": "INCLUDE_ALL_METADATA",<br>    "subnet_flow_logs_sampling": 0.7<br>  }<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->