data "google_client_config" "default" {}

provider "google" {
  credentials = "${file("${var.config_file}")}"
  project = "${var.projet_name}"
}

resource "google_container_cluster" "primary" {
  name = "${var.projet_name}-initial-primary"

  zone = "${var.region}"
  initial_node_count = 2

  min_master_version = 1.11
  node_version = 1.11

  node_config {
    machine_type = "n1-standard-2"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

provider "helm" {
  version = "~> 0.6"
  service_account = "${kubernetes_service_account.tiller.metadata.0.name}"

  kubernetes {
    host                   = "${google_container_cluster.primary.endpoint}"
    token                  = "${data.google_client_config.default.access_token}"
    cluster_ca_certificate = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
  }
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "helm_release" "prometheus_operator" {
  depends_on = ["kubernetes_service_account.tiller"]
  name  = "monitoring"
  chart = "stable/prometheus-operator"
  namespace = "monitoring"

  values = [
    "${file("${path.module}/monitoring/prometheus/values.yml")}",
  ]
}
