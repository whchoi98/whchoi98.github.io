---
title: "Amazon EC2 Nitro V6의 Connection Tracking 유휴 타임아웃 변경 대응하기"
title_en: "Responding to the connection tracking idle timeout change in Amazon EC2 Nitro V6"
layout: report
report_src: /docs/techblog/aws-core/ec2-nitro-v6-connection-tracking-report.html
date: 2026-09-03
category: AWS Core
tags: ["Amazon EC2", "AWS Nitro System", "Connection Tracking", "Security Groups", "TCP Keepalive", "Amazon EKS", "Karpenter", "Network Load Balancer"]
icon: vpc
minutes: 14
excerpt: "Nitro V6 기반 EC2 인스턴스에서는 보안 그룹 Connection Tracking의 TCP established 유휴 타임아웃 기본값이 432,000초에서 350초로 짧아졌습니다. 영향받는 워크로드와 TCP keepalive 중심의 대응 방법을 정리합니다."
excerpt_en: "On Nitro V6 based EC2 instances, the default TCP established idle timeout for security group connection tracking was shortened from 432,000 seconds to 350 seconds. This post covers the affected workloads and how to respond, with TCP keepalive at the center."
---
