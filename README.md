# GKE prometheus terraform script 

A terraform module that provisions a GKE cluster with helm and prometheus.

Use by embedding into a terraform script as a module:

```
module "article-app" {
    source = "git@github.com:tommbee/article-app-terraform.git"
}
```
