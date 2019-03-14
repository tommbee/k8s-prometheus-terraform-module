output "helm_service_account" {
  value = "${var.helm_service_account}"
}

output "helm_namespace" {
  value = "${var.helm_namespace}"
}
output "helm_init_id" {
  value = "${helm_release.prometheus_operator.id}"
}
