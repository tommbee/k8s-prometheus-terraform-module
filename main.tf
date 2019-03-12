module "gke_cluster" {
  source = "gke"
  
  projet_name = "${var.projet_name}"
  region = "${var.region}"
  config_file = "${var.config_file}"
}

module "k8s" {
  source = "k8s"

  client_certificate = "${base64decode(module.gke_cluster.client_certificate)}"
  client_key = "${base64decode(module.gke_cluster.client_key)}"
  cluster_ca_certificate = "${base64decode(module.gke_cluster.cluster_ca_certificate)}"
  host = "${module.gke_cluster.host}"
}


module "helm" {
  source = "helm"
  
  client_certificate = "${base64decode(module.gke_cluster.client_certificate)}"
  client_key = "${base64decode(module.gke_cluster.client_key)}"
  cluster_ca_certificate = "${base64decode(module.gke_cluster.cluster_ca_certificate)}"
  host = "${module.gke_cluster.host}"
  sa_name = "${module.k8s.helm_service_account}"
}
