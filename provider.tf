terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.44.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}
provider "google" {
  project = local.project
  region  = local.region
  zone    = "${local.region}-c"
}

provider "kubernetes" {
  cluster_ca_certificate = base64decode(module.kubernetes-cluster.cert)
  host                   = "https://${module.kubernetes-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
}

data "google_client_config" "default" {}