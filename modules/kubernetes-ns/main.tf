resource "kubernetes_namespace" "example" {
  metadata {
     name = var.name
    labels = {
      name = var.name
    }
  }
}