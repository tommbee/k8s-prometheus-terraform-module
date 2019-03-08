data "google_client_config" "default" {}

provider "google" {
  credentials = "${file("${var.config_file}")}"
  project = "${var.projet_name}"
}

resource "google_container_cluster" "primary" {
  name = "${var.projet_name}-initial-primary"

  zone = "${var.region}"
  initial_node_count = 2

  min_master_version = 1.11
  node_version = 1.11

  node_config {
    machine_type = "n1-standard-2"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

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