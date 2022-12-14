tags:
  # enterprise is the main switch for the zadig version installed.
  enterprise: false
  # collie is the collie subchart switch
  collie: false
  # ci-support is the switch for installing sonarqube service. It is turned off by default.
  ci-support: false
  # mongodb is the switch for installing mongodb for zadig, if an external database is provided, set this to false
  mongodb: false
  # minio is the switch for installing minIO for zadig, if an external object storage is provided, set this to false
  minio: false
  ingressController: false
  # mysql is the switch for installing mysql for zadig, if an external database is provided, set this to false
  mysql: false
endpoint:
  # endpoint.type is the type of Zadig system endpoint. It can be of type FQDN or IP. By default the type is FQDN.
  type: IP
  # FQDN is the domain name the user choose to visit in. It must be set if endpoint is of type FQDN.
  FQDN:  
  # IP is the ip of one of the cluster's worker node. It must be set if the endpoint is of type IP. By default it is empty.
  IP: CHANGE_HERE_BY_YOURSELF
global:
  encryption:
    key: CHANGE_HERE_BY_YOURSELF
  image:
    registry: koderover.tencentcloudcr.com/koderover-public
  extensions:
    extAuth:
      extauthzServerRef:
        name: auth-server
        # Mandatory, set it to the namespace where the chart is installed.
        namespace: zadig
      requestTimeout: 5s
  builtInImage:
    ubuntuBase: koderover.tencentcloudcr.com/koderover-public/build-base:${BuildOS}-amd64
# protocol is the internet protocol used to access zadig
protocol: https
microservice:
  aslan:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/aslan
      tag: 1.13.0-amd64
      pullPolicy: Always
    serviceStartTimeout: 600
    resources:
      limits:
        cpu: 2
        memory: 4Gi
    nsqd:
      maxMsgTimeout: 60m
  cron:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/cron
      tag: 1.13.0-amd64
      pullPolicy: Always
  dind:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/docker
      tag: 20.10.14-dind
    resources:
      limits:
        cpu: 4
        memory: 8Gi
  hubAgent:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/hub-agent
      tag: 1.13.0-amd64
  hubServer:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/hub-server
      tag: 1.13.0-amd64
      pullPolicy: Always
  jenkins:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/jenkins-plugin
      tag: 1.13.0-amd64
  kodespace:
    version: v1.1.0
  podexec:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/podexec
      tag: 1.13.0-amd64
      pullPolicy: Always
  predator:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/predator-plugin
      tag: 1.13.0-amd64
  resourceServer:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/resource-server
      tag: 1.13.0-amd64
      pullPolicy: Always
  packager:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/packager-plugin
      tag: 1.13.0-amd64
  warpdrive:
    replicas: 2
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/warpdrive
      tag: 1.13.0-amd64
      pullPolicy: Always
    resources:
      limits:
        cpu: 1
        memory: 2Gi
  user:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/user
      tag: 1.13.0-amd64
      pullPolicy: Always
    resources: {}
    database: user
  picket:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/picket
      tag: 1.13.0-amd64
      pullPolicy: Always
    resources: {}
  policy:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/policy
      tag: 1.13.0-amd64
      pullPolicy: Always
    resources: {}
  config:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/config
      tag: 1.13.0-amd64
      pullPolicy: Always
    resources: {}
    dexDatabase: dex
  opa:
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/opa
      tag: 0.33.1-envoy-2
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
init:
  image:
    repository: koderover.tencentcloudcr.com/koderover-public/init
    tag: 1.13.0-amd64
    pullPolicy: Always
  adminPassword: CHANGE_HERE_BY_YOURSELF
  adminEmail: admin@example.com
nsqd:
  image:
    repository: koderover.tencentcloudcr.com/koderover-public/nsqio-nsq
    tag: v1.0.0-compat
    pullPolicy: Always
  resources:
    limits:
      cpu: 1
      memory: 512Mi
frontend:
  image:
    repository: koderover.tencentcloudcr.com/koderover-public/zadig-portal
    tag: 1.13.0-amd64
    pullPolicy: Always
  resources:
    limits:
      cpu: 1
      memory: 512Mi
ua:
  image:
    repository: koderover.tencentcloudcr.com/koderover-public/ua
    tag: 1.13.0-amd64
    pullPolicy: Always
connections:
  mysql:
    host: CHANGE_HERE_BY_YOURSELF
    auth:
      user: root
      password: CHANGE_HERE_BY_YOURSELF
  mongodb:
    connectionString: CHANGE_HERE_BY_YOURSELF
    db: zadig
imagePullSecrets:
  - name: qn-registry-secret
github:
  knownHost:
  sshKey:
kubernetes:
  server:
ingress-nginx:
  fullnameOverride: zadig-ingress-nginx
  imagePullSecrets:
    - name: qn-registry-secret
  controller:
    admissionWebhooks:
      # admission webhooks must be set to false if the cluster version is under 1.16
      enabled: false
    image:
      repository: koderover.tencentcloudcr.com/koderover-public/ingress-nginx-controller
      tag: v0.35.0
      digest: ""
    ingressClass: zadig-nginx
    service:
      type: NodePort
      nodePorts:
        # ingress-nginx.controller.service.nodePorts.http is the http port of the ingress-nginx controller service
        # if ingress-nginx.controller.service.type is set to Loadbalancer, this field should not be set.
        http: 31147
minio:
  # endpoint is the endpoint for the minio, if the user choose to provide their own minio
  endpoint: CHANGE_HERE_BY_YOURSELF
  # bucket is the bucket for zadig system to use.
  bucket: bucket
  # data persistence related parameter
  persistence:
    enabled: true
    size: 20Gi
    storageClass: nfs-client
  # the default buckets to create during init process, split by comma or semicolon
  defaultBuckets: "bucket"
  fullnameOverride: zadig-minio
  accessKey:
    password: CHANGE_HERE_BY_YOURSELF
  secretKey:
    password: CHANGE_HERE_BY_YOURSELF
  protocol: http
  image:
    registry: koderover.tencentcloudcr.com
    repository: koderover-public/minio
    tag: 2021.6.14-debian-10-r0
mongodb:
  persistence:
    enabled: true
    size: 20Gi
    storageClass: nfs-client
  auth:
    enabled: false
    rootPassword: CHANGE_HERE_BY_YOURSELF
  fullnameOverride: zadig-mongodb
  image:
    registry: koderover.tencentcloudcr.com
    repository: koderover-public/mongodb
    tag: 4.4.6-debian-10-r8
mysql:
  global:
    storageClass: nfs-client
  auth:
    database: dex
    rootPassword: CHANGE_HERE_BY_YOURSELF
  primary:
    persistence:
      enabled: true
      size: 20Gi
  fullnameOverride: zadig-mysql
  image:
    registry: koderover.tencentcloudcr.com
    repository: koderover-public/mysql
    tag: 8.0.27-debian-10-r8
dex:
  fullnameOverride: zadig-dex
  image:
    repository: koderover.tencentcloudcr.com/koderover-public/dex
    tag: 1.13.0-amd64
    pullPolicy: Always
  config:
    issuer: http://zadig-dex:5556/dex
    oauth2:
      skipApprovalScreen: true
    storage:
      type: mysql
      config:
        host: CHANGE_HERE_BY_YOURSELF
        port: 3306
        database: dex
        user: CHANGE_HERE_BY_YOURSELF
        password: CHANGE_HERE_BY_YOURSELF
        ssl:
          mode: "false"
    web:
      http: 0.0.0.0:5556
    staticClients:
      - id: zadig
        redirectURIs:
          - CHANGE_HERE_BY_YOURSELF
        name: 'zadig'
        secret: CHANGE_HERE_BY_YOURSELF
    enablePasswordDB: true
gloo:
  settings:
    singleNamespace: true
  gatewayProxies:
    gatewayProxy:
      service:
        type: NodePort
        httpNodePort: 31110
      gatewaySettings:
        customHttpGateway:
          options:
            httpConnectionManagerSettings:
              streamIdleTimeout: 60m
        customHttpsGateway:
          options:
            httpConnectionManagerSettings:
              streamIdleTimeout: 60m
      podTemplate:
        image:
          repository: gloo-envoy-wrapper
          tag: 1.9.1
  gateway:
    certGenJob:
      image:
        repository: certgen
        tag: 1.9.1
    deployment:
      image:
        repository: gateway
        tag: 1.9.1
  discovery:
    deployment:
      image:
        repository: discovery
        tag: 1.9.1
  gloo:
    deployment:
      image:
        repository: gloo
        tag: 1.9.1
