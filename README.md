[![Build and Deploy to GKE](https://github.com/matiaslarson/liatrio-demo-prod/actions/workflows/google.yml/badge.svg)](https://github.com/matiaslarson/liatrio-demo-prod/actions/workflows/google.yml)

# XYZ Corp. Containerized App
Demo for XYZ Corp. deployment

### Requirements:
- Admin access to a GCP project with the GKE and GAR APIs enabled

### Initialize environment:
- Clone/fork repo
- Create a GCP service account for Terraform with permission to create/manage IAM, compute, network, and cluster resources (Owner can be used outside production).
- Create a Terraform account or log into an existing account. Create a VCS-backed Workspace pointed at your repository.
- Download the Terraform service account credentials and add them as a Terraform Secret Variable called `GOOGLE_CREDENTIALS`.
- Add your GCP project name, Github repository, and the region to deploy to in the `gcp/_terraform.tfvars` file, and queue a Plan/Apply
- After Terraform has created the cluster, copy the `gke_service_account` and `gke_workload_federation_provider` outputs into your Github repo (Settings > Secrets and variables > Actions).
- Optionally point DNS to the IP of the ingress load balancer.

### Run application locally with
`cd app && go run main` then connect at http://localhost:8080

### Cleanup
- Queue a Destroy plan in Terraform Cloud
- run `gcloud projects delete example-foo-bar-1` to delete the GCP project

### Gotchas:
- GCP archives workload federation pools for 30 days before permanently deleting them. You won't be able to recreate a pool with the same name as a deleted pool until it's permanently deleted. This repo uses a random 4byte hex identifying to work around this.
