resource "google_artifact_registry_repository" "xyz-repo" {
  location      = var.region
  repository_id = "liatrio-demo"
  description   = "XYZ Corp. docker repository"
  format        = "DOCKER"
}
