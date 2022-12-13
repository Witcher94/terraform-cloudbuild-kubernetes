resource "kubernetes_manifest" "test-configmap" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata"   = {
      "name"      = var.name
    }
  }
}
