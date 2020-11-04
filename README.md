# terraform-helm-jx

Terraform module for applying a base set of Helm charts used to setup Jenkins X on a cluster created by Terraform.

Helm charts that are installed
- [`jx-git-operator`](https://github.com/jenkins-x/jx-git-operator) - used to install and upgrade Jenkins X via GitOps
- [`kuberhealthy`](https://github.com/Comcast/kuberhealthy) - used to run and report health checks
- [`jx-kh-checks`](https://github.com/jenkins-x-plugins/jx-kh-check/tree/master/cmd) - base set of health checks used to verify the health of the cluster and Jenkins X installation.

# Prerequisites

This is a 

Ensure you have a helm provider authorisation configured:
```
provider "helm" {
  kubernetes {
    host     = "https://104.196.242.174"
    username = "ClusterMaster"
    password = "MindTheGap"

    client_certificate     = file("~/.kube/client-cert.pem")
    client_key             = file("~/.kube/client-key.pem")
    cluster_ca_certificate = file("~/.kube/cluster-ca-cert.pem")
  }
}
```

See https://registry.terraform.io/providers/hashicorp/helm/latest/docs#authentication for more details.


# Use

```
module "jx-health" {
  count  = var.jx2 ? 0 : 1
  source = "github.com/jenkins-x/terraform-jx-health?ref=main"

  depends_on = [
    google_container_cluster.jx_cluster
  ]
}

```

# Terraform

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| helm | n/a |

## Inputs

No input.

## Outputs

No output.

# Contributing

When adding new variables please regenerate the markdown table 
```sh
terraform-docs markdown table .
```
and replace the Inputs section above

## Formatting

When developing please remember to format codebase before raising a pull request
```sh
terraform fmt -check -diff -recursive
```
