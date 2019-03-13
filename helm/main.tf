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

# resource "helm_repository" "coreos" {
#   name = "coreos"
#   url  = "https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/"
# }

# resource "helm_release" "prometheus_operator" {
#   name       = "prometheus-operator"
#   repository = "${helm_repository.coreos.metadata.0.name}"
#   chart      = "prometheus-operator"
#   namespace  = "monitoring"

#   depends_on = [
#       "null_resource.depends_on_hack",
#       "helm_repository.coreos",
#   ]

#   values = [
#     "${file("${path.module}/monitoring/prometheus/values.yml")}",
#   ]
# }
