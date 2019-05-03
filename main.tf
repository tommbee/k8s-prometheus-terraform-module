module "gke_cluster" {
  source = "gke"
  
  projet_name = "${var.projet_name}"
  region = "${var.region}"
  config_file = "${var.config_file}"
  cluster_name = "${var.cluster_name}"
  machine_type = "${var.machine_type}"
}

module "k8s" {
  source = "k8s"
  kubeconfig = "${module.gke_cluster.kubeconfig}"
  token =  "${module.gke_cluster.token}"
}

module "helm" {
  source = "helm"

  helm_service_account = "default"
  helm_namespace = "${module.k8s.helm_namespace}"
  kubeconfig = "${module.gke_cluster.kubeconfig}"
}
