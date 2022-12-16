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
module "service-account" {
  source     = "./modules/service-account"
  project    = local.project
  account_id = var.account_id
  name       = var.name
  members    = var.members
  roles      = var.roles
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
  source = "./modules/kubernetes-cluster"
  name = var.name
  region = local.region
  remove-default-node-pool = var.remove-default-node-pool
  initial-node-count = var.initial-node-count
  node-count = var.node-count
  preemptible = var.preemptible
  machine-type = var.machine-type
  service-account = module.service-account.service-account
  secret = module.secret-manager.secret
  network = module.vpc.network.id
  subnet = module.subnet.subnets["public"].id
}
module "kubernetes-ns" {
  source = "./modules/kubernetes-ns"
  name = var.name
  depends_on = [module.kubernetes-cluster]
}
module "kubernetes-storageClass" {
  source = "./modules/kubernetes-storageClass"
  depends_on = [module.kubernetes-ns]
}
module "kubernetes-pv" {
  source = "./modules/kubernetes-pv"
  depends_on = [module.kubernetes-storageClass]
}
module "kubernetes-configmap" {
  source = "./modules/kubernetes-configmap"
  name = var.name
  secret = module.secret-manager.secret
  data-path = "./datas/config"
  depends_on = [module.kubernetes-pv]
}
module "kubernetes-statefulset" {
  source = "./modules/kubernetes-statefulset"
  name = var.name
  data = "./datas/statefulset"
  depends_on = [module.kubernetes-configmap]
}
module "kubernetes-service" {
  source = "./modules/kubernetes-svc"
  name = var.name
  depends_on = [module.kubernetes-statefulset]

}
