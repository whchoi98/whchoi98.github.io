---
title: "AWS에서 AI 에이전트 실행 환경 격리하기 1부: Amazon EKS와 Agent Sandbox, 개념과 구성"
title_en: "Isolating AI agent execution environments on AWS, Part 1: Amazon EKS and Agent Sandbox, concepts and setup"
layout: report
report_src: /docs/techblog/container/aws-ai-agent-sandbox-eks-isolation-part-1-report.html
date: 2026-10-18
category: Container
tags: ["Amazon EKS", "Agent Sandbox", "gVisor", "Kubernetes", "NetworkPolicy", "Amazon VPC CNI", "AI agents"]
icon: eks
minutes: 15
excerpt: "Agent Sandbox v1.0.5와 gVisor를 EKS 1.36 클러스터에 구성하고 runc 샌드박스와 gVisor 샌드박스에서 같은 보안 점검을 실행했습니다. 1부는 Agent Sandbox의 구조와 설치 순서, 신뢰할 수 없는 코드를 막는 격리 계층을 다룹니다."
excerpt_en: "This post sets up Agent Sandbox v1.0.5 and gVisor on an EKS 1.36 cluster and runs the same security checks in runc sandboxes and gVisor sandboxes. Part 1 covers the architecture of Agent Sandbox, the installation order, and the isolation layers that stop untrusted code."
---
