---
title: "Amazon EC2 Nitro V6 인스턴스의 TCP 연결 추적 유휴 타임아웃 변경 이해하고 대응하기"
title_en: "Understanding and Responding to the TCP Connection Tracking Idle Timeout Change on Amazon EC2 Nitro V6 Instances"
layout: report
report_src: /docs/techblog/aws-core/conntrack-idle-timeout-nitro-v6-impact-report.html
date: 2026-08-29
category: AWS Core
tags: [EC2, Networking, Security Group, conntrack]
icon: vpc
minutes: 13
excerpt: "Nitro V6 인스턴스부터 보안 그룹 연결 추적의 TCP established 유휴 타임아웃 기본값이 432,000초(5일)에서 350초로 단축 - silent drop 메커니즘, 의도하지 않은 세대 이관 리스크, TCP keepalive 중심의 대응과 탐지/모니터링 가이드."
excerpt_en: "Starting with Nitro V6 instances, the default TCP established idle timeout for security group connection tracking drops from 432,000 seconds (5 days) to 350 seconds - the silent drop mechanism, unintended generation migration risk, and a TCP keepalive-centered response and monitoring guide."
---
