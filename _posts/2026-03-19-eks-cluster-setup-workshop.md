---
title: "EKS Workshop - Cluster Setup and Configuration"
date: 2026-03-19 10:00:00 +0900
categories: [Workshop]
tags: [Container, AWS-Core]
author: whchoi98
---

## Overview

This workshop guides you through setting up an Amazon EKS cluster from scratch.

## Prerequisites

- AWS Account with Administrator access
- AWS CLI v2 installed
- `kubectl` installed
- `eksctl` installed

## Step 1: Create EKS Cluster

```bash
eksctl create cluster \
  --name my-eks-cluster \
  --region ap-northeast-2 \
  --version 1.31 \
  --nodegroup-name standard-workers \
  --node-type t3.medium \
  --nodes 3
```

## Step 2: Verify Cluster

```bash
kubectl get nodes
kubectl get pods -A
```

## Step 3: Deploy Sample Application

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

## Summary

You now have a running EKS cluster with a sample application deployed.

> Next workshop: Configuring ALB Ingress Controller
{: .prompt-info }
