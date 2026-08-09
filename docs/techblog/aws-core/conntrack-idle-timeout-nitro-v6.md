---
title: "conntrack 유휴 타임아웃 기본값 변경 영향 분석 (Nitro V6)"
layout: report
report_src: /docs/techblog/aws-core/conntrack-idle-timeout-nitro-v6-impact-report.html
date: 2026-08-03
category: AWS Core
tags: [EC2, Networking, Security Group, conntrack]
icon: vpc
minutes: 11
excerpt: "Nitro V6(8세대)부터 Security Group 연결 추적의 TCP established 유휴 타임아웃 기본값이 432,000초(5일)에서 350초로 단축 - silent drop 메커니즘, 노출 경로, TCP keepalive 중심의 대응 가이드."
---
