resource "kubernetes_manifest" "test-configmap" {
  manifest = {
    "apiVersion" = var.apiversion
    "kind"       = var.kind
    "metadata" = {
      "name"      = var.name
    }
    "provisioner" = var.provisioner
    "volumeBindingMode" = var.bindingmode
    "allowVolumeExpansion" = var.allowvolumeexpans
    "reclaimPolicy" = var.reclaimPolicy
    }
}