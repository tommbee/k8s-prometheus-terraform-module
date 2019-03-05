provider "google" {
  credentials = "${file("${var.projet_name}-google-account-creds.json")}"
  project = "${var.projet_name}"
}

terraform {
  backend "gcs" {
    bucket = "article-app-storage"
    prefix = "terraform/state"
    credentials = "article-app-google-account-creds.json"
  }
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
