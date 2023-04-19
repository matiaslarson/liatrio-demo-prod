resource "google_service_account" "gh-action-sa" {
  account_id   = "gh-actions"
  display_name = "Github Actions"
  description = "Service Account for deploying to GKE"
}


# resource "google_service_account_iam_binding" "gh-actions-gke-admin" {
#   service_account_id = google_service_account.gh-action-sa.name
#   role               = "roles/container.admin"
#
#   members = []
# }
#
# resource "google_service_account_iam_binding" "gh-actions-gar" {
#   service_account_id = google_service_account.gh-action-sa.name
#   role               = "roles/artifactregistry.writer"
#   members = []
# }

resource "google_project_iam_member" "gh-actions-gke" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.gh-action-sa.email}"
}

resource "google_project_iam_member" "gh-actions-gar" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.gh-action-sa.email}"
}

resource "google_service_account_iam_member" "gh-actions-wl" {
  service_account_id = google_service_account.gh-action-sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gh-pool.name}/*"
}
