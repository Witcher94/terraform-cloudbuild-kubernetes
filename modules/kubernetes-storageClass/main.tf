resource "kubernetes_storage_class" "example" {
  metadata {
    name = "local-storage"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  parameters = {
    type = "pd-standard"
    replication-type= "none"
    fstype="ext4"
  }
  volume_binding_mode = "WaitForFirstConsumer"
  allow_volume_expansion = true
  reclaim_policy      = "Delete"
}