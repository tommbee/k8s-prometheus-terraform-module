output "helm_service_account" {
  value = "${var.helm_service_account}"
}

output "helm_namespace" {
  value = "${var.helm_namespace}"
}
output "helm_init_id" {
  value = "${null_resource.helm_init.id}"
}
