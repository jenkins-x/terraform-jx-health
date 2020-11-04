resource "helm_release" "kuberhealthy" {
  provider         = helm
  name             = "kuberhealthy"
  chart            = "kuberhealthy"
  namespace        = "kuberhealthy"
  repository       = "https://comcast.github.io/kuberhealthy/helm-repos"
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
  repository       = "https://storage.googleapis.com/jenkinsxio/charts"
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
  repository       = "https://storage.googleapis.com/jenkinsxio/charts"
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