resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"                              # The release name for the Helm chart
  repository = "https://kubernetes.github.io/ingress-nginx" # Reference the repository URL from the helm_repository resource
  chart      = "ingress-nginx"                              # The chart name in the repository
  version    = "4.9.0"                                      # Specify a version if needed, or use "latest"

  # Set custom values using the provided values.yaml configuration
  values = [yamlencode({
    controller = {
      metrics = {
        enabled = true
      }
      podAnnotations = {
        "controller.metrics.service.servicePort" = "9090"
        "prometheus.io/port"                     = "10254"
        "prometheus.io/scrape"                   = "true"
      }
      replicaCount = 2
      service = {
        type = "LoadBalancer"
      }
    }
  })]

  # Optionally, specify the namespace (default is used if not specified)
  namespace = "default" # Adjust the namespace if needed
}


# # helm install kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring -f manifests/values.yml


# # apiVersion: monitoring.coreos.com/v1alpha1
# # kind: AlertmanagerConfig
# # metadata:
# #   name: global-alert-manager-configuration
# #   namespace: monitoring
# #   labels:
# #     release: kube-prometheus
# # spec:
# #   receivers:
# #     - name: slack-notifications
# #       slackConfigs:
# #         - channel: "#alerts" # your channel name that you have created
# #           sendResolved: true
# #           iconEmoji: ":bell:"
# #           text: "<!channel>  Alert in Environment: {{ (index .Alerts 0).Labels.env }}\nAffected Pods: {{ range .Alerts }}{{ .Labels.pod }}, {{ end }}"


# #   route:
# #     matchers:
# #       # name of the label to match
# #       - name: env
# #         value: staging
# #         matchType: =
# #     groupBy: ["job", "severity"]
# #     groupWait: 30s
# #     receiver: slack-notifications
# #     groupInterval: 1m
# #     repeatInterval: 1m





# # helm install kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring -f manifests/values.yml
# # apiVersion: monitoring.coreos.com/v1
# # kind: PrometheusRule
# # metadata:
# #   labels:
# #     release: kube-prometheus
# #   name: dev-rule
# #   namespace: monitoring
# # spec:
# #   groups:
# #     - name: "dev.rules"
# #       rules:
# #         - alert: PodDown
# #           for: 1m
# #           # expr: kube_pod_status_ready{condition="true",pod=~".*"}==0
# #           expr: sum by (namespace, pod) (kube_pod_status_phase{phase=~"Pending|Unknown|Failed"}) > 0
# #           labels:
# #             severity: critical
# #             env: staging
# # prometheus:
# #   prometheusSpec:
# #     podMonitorSelectorNilUsesHelmValues: false
# #     serviceMonitorSelectorNilUsesHelmValues: false

# # alertmanager:
# #   config:
# #     global:
# #       slack_api_url: https://hooks.slack.com/services/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
# #   alertmanagerSpec:
# #     alertmanagerConfigNamespaceSelector:
# #     alertmanagerConfigSelector:
# #     alertmanagerConfigMatcherStrategy:
# #       type: None
# # # custom-values.yaml
# # prometheus:
# #   service:
# #     type: NodePort
# # grafana:
# #   service:
# #     type: NodePort
# # # alertmanager:
# # #   service:
# # #     type: NodePort



# # resource "null_resource" "update_config" {
# #   depends_on = [helm_release.monitoring]
# #   provisioner "local-exec" {
# #     command = <<EOT
# #       echo  '${data.template_file.grafana_volume.rendered}' | kubectl apply -f -
# #       echo  '${data.template_file.grafana_ini.rendered}' | kubectl apply -f -
# #       echo  '${data.template_file.grafana_manifests.rendered}' | kubectl apply -f -
# #       kubectl rollout restart deployment -n monitoring-stack monitoring-grafana
# #     EOT
# #   }
# # }
