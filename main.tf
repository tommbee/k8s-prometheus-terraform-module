module "gke_cluster" {
  source = "gke"
  
  projet_name = "${var.projet_name}"
  region = "${var.region}"
  # config_file = "${var.config_file}"
  cluster_name = "${var.cluster_name}"
  machine_type = "${var.machine_type}"
}

module "k8s" {
  source = "k8s"
  #kubeconfig = "${module.gke_cluster.kubeconfig}"
  token =  "${module.gke_cluster.token}"
  cluster_ca_certificate =  "${module.gke_cluster.cluster_ca_certificate}"
  host =  "${module.gke_cluster.host}"
  email_address = "${module.gke_cluster.email}"
}

provider "google" {
  scopes = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
  ]

  credentials = "${file("${var.config_file}")}"
}

resource "google_storage_bucket_object" "kubeconfig" {
  name   = "kubeconfig"
  source = "${module.gke_cluster.kubeconfig}"
  bucket = "${var.gcs_bucket}"
}

module "helm" {
  source = "helm"

  helm_service_account = "default"
  helm_namespace = "${module.k8s.helm_namespace}"
  token =  "${module.gke_cluster.token}"
  cluster_ca_certificate =  "${module.gke_cluster.cluster_ca_certificate}"
  host =  "${module.gke_cluster.host}"
  # kubeconfig = "${module.gke_cluster.kubeconfig}"
}
