resource "google_iam_workload_identity_pool" "gh-pool" {
  workload_identity_pool_id = "gh-pool-${random_id.pool-id.hex}"
  display_name              = "Github Actions"
  description               = "Identity pool for XYZ Corp. demo"
}

resource "google_iam_workload_identity_pool_provider" "gh-provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.gh-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "gh-prvdr"
  display_name                       = "GH Actions Provider"
  description                        = "Allows GitHub Actions to assume a service account role in GCP"
  attribute_condition                = "assertion.repository == \"${var.app_repo}\""
  attribute_mapping                  = {
    "google.subject"       = "assertion.sub",
    "attribute.actor"      = "assertion.actor",
    "attribute.aud"        = "assertion.aud",
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "random_id" "pool-id" {
  byte_length = 4
}
