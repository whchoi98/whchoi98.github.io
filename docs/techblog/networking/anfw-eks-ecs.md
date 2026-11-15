---
title: "AWS Network Firewall 컨테이너 속성 기반 규칙으로 EKS와 ECS 트래픽 제어하기"
title_en: "Controlling EKS and ECS traffic with AWS Network Firewall container attribute-based rules"
layout: report
report_src: /docs/techblog/networking/anfw-eks-ecs-report.html
date: 2026-09-16
category: Networking
tags: ["AWS Network Firewall", "Amazon EKS", "Amazon ECS", "AWS Fargate", "Amazon EventBridge", "AWS CloudTrail", "Suricata", "Amazon VPC CNI"]
icon: vpc
minutes: 18
excerpt: "AWS Network Firewall의 컨테이너 속성 기반 규칙을 서울 리전의 EKS와 ECS에 직접 구성했습니다. 커스텀 속성 필터 지원 여부, IP 수집 경로, 반영 지연을 측정한 결과와 권장 도입 순서를 정리합니다."
excerpt_en: "I set up AWS Network Firewall container attribute-based rules on EKS and ECS in the Seoul Region. This post covers custom filter support, the IP collection path, propagation delay, and adoption order."
---
