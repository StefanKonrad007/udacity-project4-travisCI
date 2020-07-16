#!/bin/bash
docker-compose -f udacity-c3-deployment/docker/docker-compose.yaml build --parallel
docker push stko086/reverseproxy
docker push stko086/udacity-restapi-feed
docker push stko086/udacity-restapi-user
docker push stko086/frontend
kubectl apply -f udacity-c3-deployment/k8s/aws-secret.yaml
kubectl apply -f udacity-c3-deployment/k8s/env-configmap.yaml
kubectl apply -f udacity-c3-deployment/k8s/env-secret.yaml
kubectl apply -f udacity-c3-deployment/k8s/backend-feed-deployment.yaml
kubectl apply -f udacity-c3-deployment/k8s/backend-feed-service.yaml
kubectl apply -f udacity-c3-deployment/k8s/backend-user-deployment.yaml
kubectl apply -f udacity-c3-deployment/k8s/backend-user-service.yaml
kubectl apply -f udacity-c3-deployment/k8s/frontend-deployment.yaml
kubectl apply -f udacity-c3-deployment/k8s/frontend-service.yaml
kubectl apply -f udacity-c3-deployment/k8s/reverseproxy-deployment.yaml
kubectl apply -f udacity-c3-deployment/k8s/reverseproxy-service.yaml
kubectl apply -f udacity-c3-deployment/k8s/ingress-object.yaml
kubectl get pods

#kubectl port-forward pod/frontend-674d8f8885-bd5v7 :8080 


  eksctl utils associate-iam-oidc-provider \
    --region eu-central-1 \
    --cluster udacity \
    --approve