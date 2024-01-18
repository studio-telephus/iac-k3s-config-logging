resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
  }
}

resource "helm_release" "loki" {
  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  version          = "4.10.0"
  namespace        = "loki"
  create_namespace = "false"
  timeout          = "600"
  values = [
    <<-EOT
    loki:
      auth_enabled: false
      commonConfig:
        replication_factor: 1
      compactor:
        retention_enabled: true
      storage:
        type: filesystem
    singleBinary:
      replicas: 1
      persistence:
        size: 20Gi
    monitoring:
      dashboards:
        enabled: false
      rules:
        enabled: false
        alerting: false
      alerts:
        enabled: false
      serviceMonitor:
        enabled: false
      selfMonitoring:
        enabled: false
        grafanaAgent:
          installOperator: false
      lokiCanary:
        enabled: false
    test:
      enabled: false
    EOT
  ]

  depends_on = [
    kubernetes_namespace.loki
  ]
}
