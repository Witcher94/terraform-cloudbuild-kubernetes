resource "kubernetes_stateful_set" "redis" {
  metadata {
    name = var.name
    namespace = var.name
  }

  spec {
    service_name = var.name
    replicas     = 3

    selector {
      match_labels = {
        app = var.name
      }
    }
    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        init_container {
          name  = "config"
          image = "redis:6.2.3-alpine"
          command = ["sh", "-c"]
          args  = [
            var.data
          ]
          volume_mount {
            name       = "redis-config"
            mount_path = "/etc/redis/"
            read_only = "false"
          }
          volume_mount {
            mount_path = "config"
            name       = "/tmp/redis/"
            read_only = "false"
          }
        }
        container {
          name  = var.name
          image = "redis:6.2.3-alpine"
          args  = ["/etc/redis/redis.conf"]
          port {
            container_port = 6379
            name           = var.name
          }

          volume_mount {
            name       = "data"
            mount_path = "/data"
            read_only = "false"
          }
          volume_mount {
            mount_path = "redis-config"
            name       = "/etc/redis/"
            read_only = "false"
          }

      }
        volume {
          name= "redis-config"
          empty_dir {}
        }
        volume {
          name = "config"
          config_map {
            name = "${var.name}-config"
          }
        }
      }
    }
    volume_claim_template {
      metadata {
        name = "data"
      }
      spec {
        access_modes = ["ReadWriteOnce"]
        storage_class_name = "local-storage"
        resources {
          requests = {
            storage = "500Mi"
          }
        }
      }
    }
        }
      }
