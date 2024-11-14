#!/bin/bash

echo "Deploying Streaming Server to Kubernetes..."

for file in ../kubernetes/*.yaml; do
    echo "Applying $file..."
    kubectl apply -f $file
    sleep 2
done

echo "Waiting for deployment to be ready..."
kubectl rollout status deployment/streaming-server -n streaming-server

echo "Deployment completed. Checking pod status..."
kubectl get pods -n streaming-server

echo "Service details:"
kubectl get svc streaming-server -n streaming-server