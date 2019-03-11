output "token" {
  value = "${data.google_client_config.default.access_token}"
}

output "host" {
  value = "${google_container_cluster.primary.endpoint}"
}

output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}

output "helm_service_account" {
  value = "${kubernetes_service_account.tiller.metadata.0.name}"
}
