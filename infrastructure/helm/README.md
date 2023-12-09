# infra-interview-test

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| app.deployStrategy.rollingUpdate.maxUnavailable | int | `1` |  |
| app.deployStrategy.type | string | `"RollingUpdate"` |  |
| app.hpa.behavior.scaleDown.stabilizationWindowSeconds | int | `180` |  |
| app.hpa.enabled | bool | `true` |  |
| app.hpa.maxReplicas | int | `5` |  |
| app.hpa.metrics[0].resource.name | string | `"cpu"` |  |
| app.hpa.metrics[0].resource.target.averageUtilization | int | `60` |  |
| app.hpa.metrics[0].resource.target.type | string | `"Utilization"` |  |
| app.hpa.metrics[0].type | string | `"Resource"` |  |
| app.hpa.minReplicas | int | `2` |  |
| app.image | string | `"talessrc/infrastructure-interview-app:1.0.0"` |  |
| app.imagePullPolicy | string | `"Always"` |  |
| app.livenessProbe.httpGetPath | string | `"/posts"` |  |
| app.livenessProbe.initialDelaySeconds | int | `30` |  |
| app.livenessProbe.periodSeconds | int | `10` |  |
| app.livenessProbe.timeoutSeconds | int | `2` |  |
| app.minAvailable | string | `"75%"` |  |
| app.port | int | `3000` |  |
| app.readinessProbe.httpGetPath | string | `"/posts"` |  |
| app.readinessProbe.initialDelaySeconds | int | `15` |  |
| app.readinessProbe.periodSeconds | int | `5` |  |
| app.readinessProbe.timeoutSeconds | int | `2` |  |
| app.replicas | int | `2` |  |
| app.resources.limits.cpu | string | `"0.5"` |  |
| app.resources.limits.memory | string | `"150Mi"` |  |
| app.resources.requests.cpu | string | `"0.2"` |  |
| app.resources.requests.memory | string | `"80Mi"` |  |
| app.securityContext.runAsUser | int | `100` |  |
| app.service.type | string | `"ClusterIP"` |  |
| app.tryToSchedulePodsInDifferentNodes | bool | `true` |  |
| database.dbName | string | `"interview"` |  |
| database.image | string | `"mariadb:5.5"` |  |
| database.livenessProbe.initialDelaySeconds | int | `20` |  |
| database.livenessProbe.periodSeconds | int | `10` |  |
| database.livenessProbe.timeoutSeconds | int | `5` |  |
| database.readinessProbe.initialDelaySeconds | int | `5` |  |
| database.readinessProbe.periodSeconds | int | `2` |  |
| database.readinessProbe.timeoutSeconds | int | `1` |  |
| database.securityContext.runAsUser | int | `999` |  |
| database.service.type | string | `"ClusterIP"` |  |
| database.type | string | `"mariadb"` |  |
| database.user.name | string | `"root"` |  |
| database.user.password | string | `"testpassword"` |  |
| imagePullSecret | string | `nil` |  |
| ingress.annotations | string | `nil` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].name | string | `"localhost"` |  |
| ingress.hosts[1].name | string | `"interview.local"` |  |
| ingress.tls | list | `[]` |  |
| networkPolicy.allowIngressOnlyWithinNamespace | bool | `true` |  |
| webserver.deployStrategy.rollingUpdate.maxUnavailable | int | `0` |  |
| webserver.deployStrategy.type | string | `"RollingUpdate"` |  |
| webserver.enabled | bool | `true` |  |
| webserver.hpa.behavior.scaleDown.stabilizationWindowSeconds | int | `180` |  |
| webserver.hpa.enabled | bool | `true` |  |
| webserver.hpa.maxReplicas | int | `3` |  |
| webserver.hpa.metrics[0].resource.name | string | `"cpu"` |  |
| webserver.hpa.metrics[0].resource.target.averageUtilization | int | `70` |  |
| webserver.hpa.metrics[0].resource.target.type | string | `"Utilization"` |  |
| webserver.hpa.metrics[0].type | string | `"Resource"` |  |
| webserver.hpa.minReplicas | int | `1` |  |
| webserver.image | string | `"nginx:1.25.3-alpine"` |  |
| webserver.livenessProbe.httpGetPath | string | `"/posts"` |  |
| webserver.livenessProbe.initialDelaySeconds | int | `30` |  |
| webserver.livenessProbe.periodSeconds | int | `10` |  |
| webserver.livenessProbe.timeoutSeconds | int | `5` |  |
| webserver.minAvailable | int | `1` |  |
| webserver.port | int | `80` |  |
| webserver.readinessProbe.httpGetPath | string | `"/posts"` |  |
| webserver.readinessProbe.initialDelaySeconds | int | `5` |  |
| webserver.readinessProbe.periodSeconds | int | `2` |  |
| webserver.readinessProbe.timeoutSeconds | int | `1` |  |
| webserver.replicas | int | `1` |  |
| webserver.resources.limits.cpu | string | `"0.15"` |  |
| webserver.resources.limits.memory | string | `"300Mi"` |  |
| webserver.resources.requests.cpu | string | `"0.05"` |  |
| webserver.resources.requests.memory | string | `"50Mi"` |  |
| webserver.securityContext.runAsUser | int | `0` |  |
| webserver.service.type | string | `"ClusterIP"` |  |
| webserver.tryToSchedulePodsInDifferentNodes | bool | `true` |  |

