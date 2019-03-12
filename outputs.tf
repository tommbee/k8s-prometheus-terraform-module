# output "token" {
#   value = "${data.google_client_config.default.access_token}"
# }

output "host" {
  value = "${module.gke_cluster.host}"
  sensitive = true
}

output "client_certificate" {
  value = "${base64decode(module.gke_cluster.client_certificate)}"
  sensitive = true
}

output "client_key" {
  value = "${base64decode(module.gke_cluster.client_key)}"
  sensitive = true
}

output "cluster_ca_certificate" {
  value = "${base64decode(module.gke_cluster.cluster_ca_certificate)}"
  sensitive = true
}

output "service_account" {
  value = "${module.k8s.helm_service_account}"
  sensitive = true
}
