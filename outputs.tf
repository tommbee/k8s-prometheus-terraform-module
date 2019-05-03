# output "token" {
#   value = "${module.gke_cluster.token}"
#   sensitive = true
# }

# output "host" {
#   value = "${module.gke_cluster.host}"
#   sensitive = true
# }

# output "client_certificate" {
#   value = "${base64decode(module.gke_cluster.client_certificate)}"
#   sensitive = true
# }

# output "client_key" {
#   value = "${base64decode(module.gke_cluster.client_key)}"
#   sensitive = true
# }

# output "cluster_ca_certificate" {
#   value = "${base64decode(module.gke_cluster.cluster_ca_certificate)}"
#   sensitive = true
# }

output "helm_service_account" {
  value = "${module.k8s.helm_service_account}"
}

output "helm_namespace" {
  value = "${module.k8s.helm_namespace}"
}

output "kubeconfig" {
  value = "${module.gke_cluster.kubeconfig}"
}
