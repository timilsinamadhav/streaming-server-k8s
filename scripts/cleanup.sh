#!/bin/bash

echo "Cleaning up Streaming Server deployment..."

kubectl delete -f ../kubernetes/

echo "Cleanup completed."