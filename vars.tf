locals {
  username  = "pfaka"
  project   = "${local.username}-education-25433"
  region    = "europe-west3"
  zone      = "${local.region}-c"
  all-zones = ["${local.region}-a", "${local.region}-b", "${local.region}-c"]
}
variable "name" {
  type        = string
  description = "Name for all of the services"
  default     = "redis"
}
#Input Variables for VPC module
variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field. Related to VPC module"
  default     = "kubernetes vpc"
}
variable "routing_mode" {
  type        = string
  description = "The network routing mode (default 'GLOBAL'), Related to VPC module"
  default     = "GLOBAL"
}
variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}
variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}
variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460')."
  default     = 0
}
variable "allocate_option" {
  type        = string
  description = "nat_ip_allocate_option - How external IPs should be allocated for this NAT."
  default     = "AUTO_ONLY"
}
variable "ip_ranges_to_nat" {
  type        = string
  description = "source_subnetwork_ip_ranges_to_nat - How NAT should be configured per Subnetwork"
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
#Input Variables for subnet module
variable "subnets" {
  default = {
    subnet-1 = {
      ip                           = "10.20.30.0/24"
      region                       = "europe-west3"
      name                         = "public"
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling    = 0.7
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    }
  }
  description = ""
}
#Input Variables for firewall module
variable "rules" {
  default = {
    firewall-rule-1 = {
      name                    = "allow-http"
      description             = null
      direction               = "INGRESS"
      priority                = 1000
      ranges                  = ["10.20.30.0/24"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [
        {
          protocol = "tcp"
          ports    = ["6379"]
        }
      ]
      deny = []
    },
    firewall-rule-2 = {
      name                    = "allow-iap"
      description             = null
      direction               = "INGRESS"
      priority                = 1000
      ranges                  = ["35.235.240.0/20"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      deny = []
    }
  }
  description = "Coma separated map, to add new rule copy an example above"
}
#Input Variables for service-account module
variable "account_id" {
  type        = string
  description = "Change for other id and display-name for SA, by default in format var.name-service-account"
  default     = ""
}
variable "roles" {
  type        = set(string)
  description = "defined roles"
  default = ["roles/iap.tunnelResourceAccessor", "roles/compute.instanceAdmin.v1", "roles/iam.serviceAccountUser",
  "roles/storage.admin"]
}
variable "members" {
  type        = list(string)
  description = "Who will achieve the roles"
  default     = [""]
}
#input variables for secret-manager module
variable "length" {
  type        = number
  description = "The secret length"
  default     = 10
}
variable "min_upper" {
  type        = number
  description = "Min number of upper literals"
  default     = 2
}
variable "min_lower" {
  type        = number
  description = "min number of lower literals"
  default     = 2
}
variable "min_numeric" {
  type        = number
  description = "min number of numbers in secret"
  default     = 2
}
variable "min_special" {
  type        = number
  description = "min number of special symbols in secret"
  default     = 2
}
variable "secret_id" {
  type        = string
  description = "id of the secret"
  default     = "redis-node-secret"
}
variable "labels" {
  type        = string
  description = "Defined labels for the secret"
  default     = "redis"
}
# Kubernetes module variables
variable "remove-default-node-pool" {
  type        = bool
  description = "If true, deletes the default node pool upon cluster creation.google_container_node_pool resources with no value,default initial-node-count = 1"
  default     = true
}
variable "initial-node-count" {
  type        = number
  description = "The number of nodes to create in this cluster's default node pool."
  default     = 0
}
variable "node-count" {
  type        = number
  description = "The number of nodes per instance group."
  default     = 3
}
variable "preemptible" {
  type        = bool
  description = "A boolean that represents whether or not the underlying node VMs are preemptible."
  default     = false
}
variable "machine-type" {
  type        = string
  description = "The name of a Google Compute Engine machine type. Defaults to e2-medium."
  default     = "e2-micro"
}

