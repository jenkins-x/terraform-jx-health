resource "helm_release" "kuberhealthy" {
  provider         = helm
  name             = "kuberhealthy"
  chart            = "kuberhealthy"
  version          = "83"
  namespace        = "kuberhealthy"
  repository       = "https://kuberhealthy.github.io/kuberhealthy/helm-repos"
  create_namespace = true

  set {
    name  = "check.daemonset.enabled"
    value = true
  }
  set {
    name  = "check.deployment.enabled"
    value = true
  }
  set {
    name  = "check.dnsInternal.enabled"
    value = true
  }
  set {
    name  = "check.networkConnection.enabled"
    value = true
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "helm_release" "cluster-checks" {
  provider         = helm
  name             = "cluster-checks"
  chart            = "jx-kh-check"
  namespace        = "kuberhealthy"
  repository       = "https://jenkins-x-charts.github.io/repo"
  version          = var.jx_kh_check_version
  create_namespace = true

  set {
    name  = "jxPodStatus.enabled"
    value = true
  }
  set {
    name  = "jxPodStatus.cluster.enabled"
    value = true
  }
  set {
    name  = "check.podRestarts.enabled"
    value = true
  }
  set {
    name  = "check.podRestarts.allNamespaces"
    value = true
  }
  set {
    name  = "jxSecrets.enabled"
    value = true
  }
  set {
    name  = "jxSecrets.cluster.enabled"
    value = true
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [
    helm_release.kuberhealthy
  ]
}

resource "helm_release" "health-checks-install" {
  provider         = helm
  name             = "health-checks-install"
  chart            = "jx-kh-check"
  namespace        = "jx-git-operator"
  repository       = "https://jenkins-x-charts.github.io/repo"
  version          = var.jx_kh_check_version
  create_namespace = true

  set {
    name  = "jxInstall.enabled"
    value = true
  }

  lifecycle {
    ignore_changes = all
  }

  depends_on = [
    helm_release.kuberhealthy
  ]
}

# resource "helm_release" "terraform_drift_check" {
#   count            = var.jx_git_url != "" ? 1 : 0
#   provider         = helm
#   name             = "terraform-drift-check"
#   chart            = "kuberhealthy-terraform-drift-check"
#   namespace        = "jx-git-operator"
#   repository       = "https://github.com/jenkins-x-charts/repo"
#   version          = var.kuberhealthy_terraform_drift_check_version
#   create_namespace = true

#   set {
#     name  = "terraformHealth.git.url"
#     value = var.jx_git_url
#   }

#   set {
#     name  = "terraformHealth.git.username"
#     value = var.jx_bot_username
#   }

#   set_sensitive {
#     name  = "terraformHealth.secretEnv.GIT_TOKEN"
#     value = var.jx_bot_token
#   }

#   dynamic "set" {
#     for_each = var.tf_drift_secret_map
#     content {
#       name  = "terraformHealth.secretEnv.${set.key}"
#       value = set.value
#       type  = "string"
#     }
#   }

#   lifecycle {
#     ignore_changes = all
#   }

#   depends_on = [
#     helm_release.kuberhealthy
#   ]
# }
