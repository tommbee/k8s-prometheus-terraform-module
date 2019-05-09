resource "null_resource" "helm_init" {
  provisioner "local-exec" {
    command = "helm init --client-only"
    #command = "helm init --service-account ${var.helm_service_account} --wait --kubeconfig ${var.kubeconfig}"
  }
}

provider "helm" {
  version = "~> 0.8.0"
  service_account = "${var.helm_service_account}"
  namespace       = "${var.helm_namespace}"
  install_tiller  = true
  debug           = true
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.13.0"

  kubernetes {
    cluster_ca_certificate  = "${var.cluster_ca_certificate}"
    host                    = "${var.host}"
    token                   = "${var.token}"

    load_config_file = false
    #config_path = "${var.kubeconfig}"
  }
}

resource "helm_release" "prometheus_operator" {
  name       = "prometheus-operator"
  chart      = "stable/prometheus-operator"
  namespace  = "monitoring"
  
  depends_on = ["null_resource.helm_init"]

  values = [
    "${file("${path.module}/monitoring/prometheus/values.yml")}",
  ]
}
