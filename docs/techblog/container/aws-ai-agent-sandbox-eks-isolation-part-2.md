---
title: "AWS에서 AI 에이전트 실행 환경 격리하기 2부: Amazon EKS와 Agent Sandbox, 개념과 구성"
title_en: "Isolating AI agent execution environments on AWS, Part 2: Amazon EKS and Agent Sandbox, concepts and setup"
layout: report
report_src: /docs/techblog/container/aws-ai-agent-sandbox-eks-isolation-part-2-report.html
date: 2026-10-18
category: Container
tags: ["Amazon EKS", "Agent Sandbox", "gVisor", "Kubernetes", "NetworkPolicy", "Amazon VPC CNI", "Amazon Route 53 Resolver", "Amazon Bedrock"]
icon: eks
minutes: 16
excerpt: "Amazon EKS에 Agent Sandbox와 gVisor를 올려 운영할 때 확인할 항목을 측정값과 함께 정리했습니다. NetworkPolicy 활성화, DNS 경로, Warm Pool 시작 지연, gVisor 성능 비용, 수명 주기, sandbox-router 보안을 다룹니다."
excerpt_en: "What to check before you run Agent Sandbox with gVisor on Amazon EKS in production, with measurements. Covers enabling NetworkPolicy, the DNS path, warm pool startup latency, the performance cost of gVisor, the lifecycle, and sandbox-router security."
---
