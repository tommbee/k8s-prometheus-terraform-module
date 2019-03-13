output "helm_service_account" {
  value = "${null_resource.helm_init.connection.0.service_account}"
}

output "helm_namespace" {
  value = "${null_resource.helm_init.connection.0.namespace}"
}
