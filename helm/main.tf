provider "helm" {
  version = "~> 0.8.0"
  service_account = "${var.helm_service_account}"
  namespace       = "${var.helm_namespace}"
  install_tiller  = false
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.12.1"

  kubernetes {
    #client_certificate     = "${var.client_certificate}"
    #client_key             = "${var.client_key}"
    cluster_ca_certificate = "${var.cluster_ca_certificate}"
    host                   = "${var.host}"
    token                  = "${var.token}"
  }
}

# resource "null_resource" "depends_on_hack" {
#   triggers {
#     version = "${timestamp()}"
#   }

#   connection {
#     service_account = "${var.helm_service_account}"
#     namespace       = "${var.helm_namespace}"
#   }
# }

resource "null_resource" "helm_init" {
  provisioner "local-exec" {
    command = "helm init --service-account ${var.helm_service_account} --wait"
  }

  connection {
    service_account = "${var.helm_service_account}"
    namespace       = "${var.helm_namespace}"
  }
}

resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  chart      = "stable/prometheus-operator"
  namespace  = "monitoring"

  depends_on = [
      "null_resource.helm_init",
  ]

  values = [
    "${file("${path.module}/monitoring/prometheus/values.yml")}",
  ]
}
