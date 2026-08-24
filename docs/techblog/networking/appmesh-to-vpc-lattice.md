---
title: "App Mesh에서 VPC Lattice로 - EOL 5주 앞의 실측 마이그레이션"
title_en: "From App Mesh to VPC Lattice - A Hands-On Migration 5 Weeks Before EOL"
layout: report
report_src: /docs/techblog/networking/appmesh-to-vpc-lattice-report.html
date: 2026-08-24
category: Networking
tags: [VPC Lattice, App Mesh, EKS, Gateway API, SigV4]
icon: vpc
minutes: 15
excerpt: "App Mesh EOL(2026-09-30)을 앞두고 EKS 1.33에서 Envoy 사이드카 메시를 VPC Lattice + SigV4로 전환한 전 단계 실측 기록입니다. 최대 함정인 Cloud Map TTL발 DNS stale(실패 구간 4.5~5분 → 36초), mTLS 대체 범위, 평문 TCP의 한계까지 다룹니다."
excerpt_en: "A full hands-on migration from App Mesh (Envoy sidecars) to VPC Lattice + SigV4 on EKS 1.33, ahead of the 2026-09-30 EOL. Covers the biggest trap - Cloud Map TTL DNS staleness (4.5-5 min of failures cut to 36 s) - plus how far SigV4 replaces mTLS and where plain TCP hits the wall."
---
