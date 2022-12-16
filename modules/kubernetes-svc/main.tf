resource "kubernetes_service" "example" {
  metadata {
    name = var.name
    namespace = var.name
  }
  spec {
    cluster_ip = "None"
    port {
      port        = 6379
      target_port = 6379
      name = var.name
    }

    selector = {
      app = var.name
    }
  }
}