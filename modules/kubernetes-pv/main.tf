resource "kubernetes_persistent_volume" "first" {
  metadata {
    name = "local-pv1"
  }
  spec {
    storage_class_name = "local-storage"
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/storage/data1"
      }
      flex_volume {
        driver = "pd.csi.storage.gke.io"
        fs_type = "ext4"
        read_only = false
      }
    }
  }
}
resource "kubernetes_persistent_volume" "sec" {
  metadata {
    name = "local-pv2"
  }
  spec {
    storage_class_name = "local-storage"
    capacity = {
      storage = "1Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/storage/data2"
      }
      flex_volume {
        driver = "pd.csi.storage.gke.io"
        fs_type = "ext4"
        read_only = false
      }
    }
  }
}
resource "kubernetes_persistent_volume" "third" {
  metadata {
    name = "local-pv3"
  }
  spec {
    storage_class_name = "local-storage"
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/storage/data3"
      }
      flex_volume {
        driver = "pd.csi.storage.gke.io"
        fs_type = "ext4"
        read_only = false
      }
    }
  }
}