[![Build and Deploy to GKE](https://github.com/matiaslarson/liatrio-demo-prod/actions/workflows/google.yml/badge.svg)](https://github.com/matiaslarson/liatrio-demo-prod/actions/workflows/google.yml)

# XYZ Corp. Containerized App
Demo for XYZ Corp. deployment

### Requirements:
- Admin access to a GCP project with the GKE and GAR APIs enabled.
  - ```bash
    gcloud services enable "container.googleapis.com" && \
    gcloud services enable "artifactregistry.googleapis.com" && \
    gcloud services enable "dns.googleapis.com"
    ```
- A DNS zone (See [dns.tf](https://github.com/matiaslarson/liatrio-demo-prod/blob/main/gcp/dns.tf), uncomment the resource and remove the data block to have Terraform create this zone for you.)
- (Optional) [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed for general management/troubleshooting i.e. inspecting resources or retrieving cluster credentials. 
- (Optional) [Golang](https://go.dev/doc/install) to build/run the application locally.

### Initialize environment:
- Clone/fork repo
- Create a GCP service account for Terraform with permission to create/manage IAM, compute, network, and cluster resources (Owner can be used outside production).
- Create a Terraform account or log into an existing account. Create a VCS-backed Workspace pointed at your repository.
- Download the Terraform service account credentials and add them as a Terraform Secret Variable called `GOOGLE_CREDENTIALS`.
- Add your GCP project name, Github repository, and deployment region to the `gcp/terraform.tfvars` file, and queue a Plan/Apply
- After Terraform has created the cluster, copy the `gke_service_account` and `gke_workload_federation_provider` outputs into your Github repo - either directly into the [workflow file](https://github.com/matiaslarson/liatrio-demo-prod/blob/main/.github/workflows/google.yml) or as the relevant secrets (Settings > Secrets and variables > Actions).
  - Additionally set the other variables in the workflow file or as repository variables, i.e. `GAR_LOCATION`, `GKE_PROJECT`, `GKE_REGION` etc.
- Optionally point DNS to the IP of the ingress load balancer.

### Run application locally with
`cd app && go run main` then connect at http://localhost:8080

### Cleanup
- Queue a Destroy plan in Terraform Cloud
- run `gcloud projects delete example-foo-bar-1` to delete the GCP project

### Gotchas:
- GCP archives workload federation pools for 30 days before permanently deleting them. You won't be able to recreate a pool with the same name as a deleted pool until it's permanently deleted. This repo uses a random 4byte hex value appended to the provider name to work around this.
- Deleting or recreating the ingress resource may change the IP address assigned. A reserved IP can be used to avoid this:  
`gcloud compute addresses create demo-static-ip --global`  
then uncomment the annotation in the [ingress manifest](https://github.com/matiaslarson/liatrio-demo-prod/blob/main/deploy/ingress.yaml#L8)

### Things to improve:
- Better scoping of credentials in the workflow steps
- Sane defaults for most values
- Look at using https://github.com/terraform-google-modules/terraform-google-github-actions-runners/tree/master/modules/gh-oidc to set up workload federation
- Tests!
