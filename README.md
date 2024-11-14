# Streaming Server Kubernetes Deployment

This repository contains Kubernetes manifests for deploying an RTMP streaming server based on NGINX-RTMP module. The solution implements a streaming service with support for HLS and DASH protocols.

## Repository Structure

```
streaming-server-k8s/
├── README.md
├── kubernetes/
│   ├── 01-namespace.yaml
│   ├── 02-pvc.yaml
│   ├── 03-configmap.yaml
│   ├── 04-deployment.yaml
│   └── 05-service.yaml
└── scripts/
    ├── deploy.sh
    └── cleanup.sh
```

## Prerequisites

- Kubernetes cluster (v1.19+)
- kubectl CLI tool installed and configured
- Storage class available in your cluster

## Quick Start

1. Clone this repository:
```bash
git clone <repository-url>
cd streaming-server-k8s
```

2. Deploy using the script:
```bash
./scripts/deploy.sh
```

Or deploy manually:
```bash
kubectl apply -f kubernetes/01-namespace.yaml
kubectl apply -f kubernetes/02-pvc.yaml
kubectl apply -f kubernetes/03-configmap.yaml
kubectl apply -f kubernetes/04-deployment.yaml
kubectl apply -f kubernetes/05-service.yaml
```

3. Verify the deployment:
```bash
kubectl get all -n streaming-server
```

## Component Details

### Storage (PVC)
- 10GB storage allocation for streaming data
- Uses standard storage class

### Configuration (ConfigMap)
- NGINX-RTMP configuration
- HLS and DASH streaming support
- Configurable streaming paths

### Deployment
- Container image: `codeworksio/streaming-server:latest`
- Resource limits and requests:
  - Memory: 512Mi
  - CPU: 500m
- Health checks included
- Volume mounts for data and configuration

### Service (LoadBalancer)
Exposes the following ports:
- 1935 (RTMP)
- 8080 (HTTP)
- 8443 (HTTPS)

## Deployment Verification

1. Check if pods are running:
```bash
kubectl get pods -n streaming-server
```

2. Check service status:
```bash
kubectl get svc -n streaming-server
```

3. Get service external IP:
```bash
kubectl get svc streaming-server -n streaming-server -o wide
```

## Monitoring

### View Logs
```bash
# Get pod name
kubectl get pods -n streaming-server

# View logs
kubectl logs -f <pod-name> -n streaming-server
```

### Check Resources
```bash
kubectl top pods -n streaming-server
```

## Scaling

To scale the deployment:
```bash
kubectl scale deployment streaming-server -n streaming-server --replicas=<number>
```

## Cleanup

To remove all deployed resources:
```bash
./scripts/cleanup.sh
```

Or manually:
```bash
kubectl delete -f kubernetes/
```

## Common Issues and Solutions

1. **PVC not binding**
   - Check storage class availability
   - Verify cluster has available storage

2. **Pod not starting**
   - Check pod events: `kubectl describe pod <pod-name> -n streaming-server`
   - View logs: `kubectl logs <pod-name> -n streaming-server`

3. **Service not accessible**
   - Verify service external IP
   - Check pod readiness status
   - Confirm firewall rules

## Configuration Customization

To modify the configuration:

1. Edit the ConfigMap in `kubernetes/03-configmap.yaml`
2. Apply the changes:
```bash
kubectl apply -f kubernetes/03-configmap.yaml
```
3. Restart the pods to apply new configuration:
```bash
kubectl rollout restart deployment streaming-server -n streaming-server
```
