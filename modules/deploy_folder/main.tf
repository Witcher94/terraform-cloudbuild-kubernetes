resource "kubernetes_manifest" "deploy_namespace_from_folder" {
  for_each = fileset(path.module, "../../${var.folder}/namespace/*.yaml")
  manifest = yamldecode(file(trim(each.key, "../../")))
}

resource "kubernetes_manifest" "deploy_folder" {
  for_each = fileset(path.module, "../../${var.folder}/*.yaml")
  manifest = yamldecode(file(trim(each.key, "../../")))
  depends_on = [
    kubernetes_manifest.deploy_namespace_from_folder
  ]
}