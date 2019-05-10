# GKE prometheus terraform script 

A terraform module that provisions a GKE cluster with helm and prometheus.

Use by embedding into a terraform script as a module:

```
module "app" {
    source = "git@github.com:tommbee/k8s-prometheus-terraform-module.git"

    config_file = "path/to/google-key.json"
    region = "[TARGET GKE REGION]"
    projet_name = "[GOOGLE PROJECT ID]"
    cluster_name = "[CREATE A NAME FOR YOUR CLUSTER]"
    machine_type = "[TARGET GKE MACHINE TYPE]"
    gcs_bucket = "[NAME OF GCP BUCKET]" // To store your kubeconfig
    node_count = [NO OF NODES FOR YOUR CLUSTER]
}
```
