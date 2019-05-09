output "host" {
  value = "${google_container_cluster.primary.endpoint}"
  sensitive = true
}

output "client_certificate" {
  value = "${base64decode(google_container_cluster.primary.master_auth.0.client_certificate)}"
  sensitive = true
}

output "client_key" {
  value = "${base64decode(google_container_cluster.primary.master_auth.0.client_key)}"
  sensitive = true
}

output "cluster_ca_certificate" {
  value = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  sensitive = true
}

output "username" {
  value = "${google_container_cluster.primary.0.master_auth.0.username}"
  sensitive = true
}

output "password" {
  value     = "${google_container_cluster.primary.0.master_auth.0.password}"
  sensitive = true
}

output "token" {
  value = "${data.google_client_config.default.access_token}"
  sensitive = true
}

output "kubeconfig" {
  value       = "${local_file.kubeconfig.filename}"
  sensitive   = true
}
