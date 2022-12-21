resource "google_container_cluster" "cluster" {
  name     = "${var.name}-gke-cluster"
  location = var.region
  network = var.network
  subnetwork = var.subnet
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = var.remove-default-node-pool
  initial_node_count       = var.initial-node-count
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER", "CONTROLLER_MANAGER", "SCHEDULER"]
  }
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "APISERVER", "CONTROLLER_MANAGER", "SCHEDULER", "WORKLOADS"]
  }
}

resource "google_container_node_pool" "cluster_nodes" {
  name       = "${var.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = var.remove-default-node-pool == true ? var.node-count : 0

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine-type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    #service_account = var.service-account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
