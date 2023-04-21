# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE Cluster Host"
}

output "gke_service_account" {
  value       = google_service_account.gh-action-sa.email
  description = "Service account for GH Actions"
}

output "gke_workload_federation_provider" {
  value       = google_iam_workload_identity_pool_provider.gh-provider.name
  description = "Provider for Workload Identity Federation"
}
