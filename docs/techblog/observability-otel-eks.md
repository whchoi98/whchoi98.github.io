---
title: Observability with OpenTelemetry on EKS
parent: Tech Blog
nav_order: 3
---

# End-to-End Observability with OpenTelemetry on EKS
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Introduction

Observability is critical for operating containerized workloads reliably.

{: .note }
> Tags: `Observability` `Container`

## Architecture

```
+-------------------------------------------+
|              Amazon EKS                    |
|                                            |
|  +------------+    +--------------------+  |
|  | App Pods   |--->| OTel Collector     |  |
|  | (with SDK) |    | (DaemonSet)        |  |
|  +------------+    +----------+---------+  |
+-----------------------------|---------------+
                              |
          +-------------------+-------------------+
          v                   v                   v
   +------------+     +------------+     +------------+
   | CloudWatch |     | AWS X-Ray  |     |    AMP     |
   |   Logs     |     |  (Traces)  |     | (Metrics)  |
   +------------+     +------------+     +------------+
                              |
                       +------v------+
                       |   Grafana   |
                       |    (AMG)    |
                       +-------------+
```

## Deploy OTel Collector

Install the AWS Distro for OpenTelemetry (ADOT) as a DaemonSet:

```bash
kubectl apply -f https://amazon-eks.s3.amazonaws.com/docs/addons-otel-permissions.yaml

aws eks create-addon \
  --cluster-name my-eks-cluster \
  --addon-name adot \
  --region ap-northeast-2
```

## Collector Configuration

```yaml
apiVersion: opentelemetry.io/v1alpha1
kind: OpenTelemetryCollector
metadata:
  name: adot-collector
spec:
  mode: daemonset
  config: |
    receivers:
      otlp:
        protocols:
          grpc:
            endpoint: 0.0.0.0:4317
          http:
            endpoint: 0.0.0.0:4318

    processors:
      batch:
        timeout: 10s

    exporters:
      awsxray:
        region: ap-northeast-2
      awsemf:
        region: ap-northeast-2
        namespace: EKS/Application

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: [batch]
          exporters: [awsxray]
        metrics:
          receivers: [otlp]
          processors: [batch]
          exporters: [awsemf]
```

## Key Metrics to Monitor

| Metric | Description | Alert Threshold |
|:-------|:------------|:----------------|
| Request latency (p99) | 99th percentile response time | > 500ms |
| Error rate | 5xx responses / total requests | > 1% |
| Pod restart count | Container crash frequency | > 3 in 5min |
| CPU/Memory utilization | Resource consumption | > 80% |

{: .important }
> Set up alerting rules in Amazon Managed Grafana for production workloads.

## Summary

OpenTelemetry provides a vendor-neutral observability framework. With ADOT on EKS, you get traces, metrics, and logs flowing into AWS-native services seamlessly.
