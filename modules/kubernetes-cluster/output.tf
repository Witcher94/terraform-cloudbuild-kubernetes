output "cert" {
  value = google_container_cluster.cluster.master_auth[0].cluster_ca_certificate
}
output "endpoint" {
  value = google_container_cluster.cluster.endpoint
}