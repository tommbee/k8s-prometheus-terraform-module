provider "helm" {
  service_account = "${var.helm_service_account}"
  namespace       = "${var.helm_namespace}"

  kubernetes {
    #client_certificate     = "${var.client_certificate}"
    #client_key             = "${var.client_key}"
    cluster_ca_certificate = "${var.cluster_ca_certificate}"
    host                   = "${var.host}"
    token                  = "${var.token}"
  }
}

resource "null_resource" "depends_on_hack" {
  triggers {
    version = "${timestamp()}"
  }

  connection {
    service_account = "${var.helm_service_account}"
    namespace       = "${var.helm_namespace}"
  }
}

resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  repository = "https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/"
  chart      = "prometheus-operator"
  namespace  = "monitoring"

  depends_on = [
      "null_resource.depends_on_hack",
  ]

  values = [
    "${file("${path.module}/monitoring/prometheus/values.yml")}",
  ]
}


# provider "helm" {
#   version = "~> 0.6"
#   service_account = "${var.sa_name}}"

#   kubernetes {
#     #client_certificate     = "${var.client_certificate}"
#     #client_key             = "${var.client_key}"
#     cluster_ca_certificate = "${var.cluster_ca_certificate}"
#     host                   = "${var.host}"
#     token                  = "${var.token}"
#   }
# }

# resource "helm_release" "prometheus_operator" {
#   name  = "monitoring"
#   chart = "stable/prometheus-operator"
#   namespace = "monitoring"
#   depends_on = ["var.sa_name"]

#   values = [
#     "${file("${path.module}/monitoring/prometheus/values.yml")}",
#   ]
# }
