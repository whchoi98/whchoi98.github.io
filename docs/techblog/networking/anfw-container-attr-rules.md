---
title: "AWS Network Firewall 컨테이너 속성 기반 규칙 실측 검증"
title_en: "AWS Network Firewall Container Attribute-Based Rules: Hands-On Verification"
layout: report
report_src: /docs/techblog/networking/anfw-container-attr-rules-report.html
date: 2026-08-12
category: Networking
tags: [Network Firewall, EKS, ECS, Suricata, VPC]
icon: vpc
minutes: 12
excerpt: "EKS와 ECS 두 트랙에 container association을 직접 만들어 허용/차단 12개 케이스와 IP set 전파 지연을 실측하고, 공식 문서가 답하지 않은 커스텀 속성 필터 지원 여부와 서비스 내부 동작 경로를 확인합니다."
excerpt_en: "Hands-on verification of container attribute-based rules on both EKS and ECS - 12 allow/block cases, measured IP set propagation delays, and answers the docs don't give about custom attribute filters and the service's internal behavior."
---
