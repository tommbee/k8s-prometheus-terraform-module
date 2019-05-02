provider "kubernetes" {
  version = ">= 1.5.2"
  # cluster_ca_certificate = "${var.cluster_ca_certificate}"
  # host                   = "${var.host}"
  # token                  = "${var.token}"
  config_path = "${var.kubeconfig}"
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "terraform-tiller"
    namespace = "kube-system"
  }
  
  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "terraform-tiller"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = "terraform-tiller"
    namespace = "kube-system"
  }
}
