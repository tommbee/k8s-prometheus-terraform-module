provider "kubernetes" {
  #client_certificate     = "${var.client_certificate}"
  #client_key             = "${var.client_key}"
  cluster_ca_certificate = "${var.cluster_ca_certificate}"
  host                   = "${var.host}"
  token                  = "${var.token}"

  load_config_file = false
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
  
  automount_service_account_token = true
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

variable "helm_version" {
  default = "v2.9.1"
}

provider "helm" {
  service_account = "${kubernetes_service_account.tiller.metadata.0.name}"
  namespace       = "${kubernetes_service_account.tiller.metadata.0.namespace}"
  #install_tiller  = false

  kubernetes {
    #client_certificate     = "${var.client_certificate}"
    #client_key             = "${var.client_key}"
    cluster_ca_certificate = "${var.cluster_ca_certificate}"
    host                   = "${var.host}"
    token                  = "${var.token}"
  }
}



# provider "kubernetes" {
#   #client_certificate     = "${var.client_certificate}"
#   #client_key             = "${var.client_key}"
#   cluster_ca_certificate = "${var.cluster_ca_certificate}"
#   host                   = "${var.host}"
#   token                  = "${var.token}"

#   load_config_file = false
# }

# resource "kubernetes_service_account" "tiller" {
#   metadata {
#     name      = "tiller"
#     namespace = "kube-system"
#   }
#   #automount_service_account_token = true
# }

# resource "kubernetes_cluster_role_binding" "tiller" {
#   metadata {
#     name = "tiller"
#   }

#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }

#   subject {
#     api_group = ""
#     kind      = "ServiceAccount"
#     name      = "tiller"
#     namespace = "kube-system"
#   }
# }

# provider "helm" {
#   version = "~> 0.6"
#   install_tiller = "true"
#   service_account = "tiller"

#   kubernetes {
#     #client_certificate     = "${var.client_certificate}"
#     #client_key             = "${var.client_key}"
#     cluster_ca_certificate = "${var.cluster_ca_certificate}"
#     host                   = "${var.host}"
#     token                  = "${var.token}"
#     config_context = "tiller"
#   }
# }

# resource "helm_release" "prometheus_operator" {
#   name  = "monitoring"
#   chart = "stable/prometheus-operator"
#   #namespace = "monitoring"

#   values = [
#     "${file("${path.module}/monitoring/prometheus/values.yml")}",
#   ]
# }
