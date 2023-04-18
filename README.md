[![Build and Deploy to GKE](https://github.com/matiaslarson/liatrio-demo-prod/actions/workflows/google.yml/badge.svg)](https://github.com/matiaslarson/liatrio-demo-prod/actions/workflows/google.yml)

# XYZ Corp. Containerized App
Demo for XYZ Corp. deployment

### Requirements:
- A GCP project with the GKE, GAR, and CloudDNS APIs enabled
- Service Account for Terraform with permission to create/manage compute, network, and cluster resources
- Service Account for GitHub with permission to push to GAR and manage deployments on the GKE cluster

### Initialize environment:
- Clone/fork repo
- Create a Terraform account or log into an existing account. Download the Terraform service account credentials and add them as a Terraform Secret Variable called `GOOGLE_CREDENTIALS`
- Create a Workload Federation pool for GitHub to access GCP resources: [guide here](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)

### Run application locally with 

