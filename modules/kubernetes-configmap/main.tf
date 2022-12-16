resource "kubernetes_config_map" "example" {
  metadata {
    name = "${var.name}-config"
    namespace = "${var.name}"
  }

  data = { "redis.conf": templatefile(var.data-path, { password = var.secret } ) }

}