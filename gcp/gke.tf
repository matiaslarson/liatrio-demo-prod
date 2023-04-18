# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-autopilot"
  location = var.region

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  ip_allocation_policy {
  }

  enable_autopilot = true
}
