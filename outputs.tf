# output "token" {
#   value = "${data.google_client_config.default.access_token}"
# }

output "host" {
  value = "${module.gke_cluster.host}"
}

output "client_certificate" {
  value = "${base64decode(module.gke_cluster.client_certificate)}"
}

output "client_key" {
  value = "${base64decode(module.gke_cluster.client_key)}"
}

output "cluster_ca_certificate" {
  value = "${base64decode(module.gke_cluster.cluster_ca_certificate)}"
}
