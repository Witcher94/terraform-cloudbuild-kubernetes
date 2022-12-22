module "vpc" {
  source                                 = "./modules/vpc"
  name                                   = var.name
  description                            = var.description
  auto_create_subnetworks                = var.auto_create_subnetworks
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  routing_mode                           = var.routing_mode
  mtu                                    = var.mtu
  allocate_option                        = var.allocate_option
  ip_ranges_to_nat                       = var.ip_ranges_to_nat
}
module "subnet" {
  source  = "./modules/subnets"
  network = module.vpc.network
  subnets = var.subnets
}
module "firewall" {
  source  = "./modules/firewall"
  network = module.vpc.network
  rules   = var.rules
}
module "secret-manager" {
  source      = "./modules/secret-manager"
  length      = var.length
  min_upper   = var.min_upper
  min_lower   = var.min_lower
  min_numeric = var.min_numeric
  min_special = var.min_special
  secret_id   = var.secret_id
  labels      = var.labels
}
module "kubernetes-cluster" {
  source                   = "./modules/kubernetes-cluster"
  name                     = var.name
  region                   = local.region
  remove-default-node-pool = var.remove-default-node-pool
  initial-node-count       = var.initial-node-count
  node-count               = var.node-count
  preemptible              = var.preemptible
  machine-type             = var.machine-type
  secret                   = module.secret-manager.secret
  network                  = module.vpc.network.id
  subnet                   = module.subnet.subnets["subnet-1"].id
}
module "deploy_folder" {
  source     = "./modules/deploy_folder"
  folder     = var.name
  depends_on = [module.kubernetes-cluster]
}
