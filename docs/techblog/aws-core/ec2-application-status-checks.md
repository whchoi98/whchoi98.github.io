---
title: "EC2에 애플리케이션 계층 상태 검사가 생겼다 - Application Status Checks 실측 검증"
title_en: "EC2 Now Checks the Application Layer - Application Status Checks, Verified Hands-On"
layout: report
report_src: /docs/techblog/aws-core/ec2-application-status-checks-report.html
date: 2026-08-13
category: AWS Core
tags: [EC2, Auto Scaling, Health Check, CloudWatch, systemd]
icon: lambda
minutes: 13
excerpt: "2026-08-10 출시된 EC2 Application Status Checks를 테스트 ASG에 장애를 주입해 실측했습니다. 감지부터 자동 교체까지 5분 10초, 완전 복구 약 8.5분 - 기능 소개, 테스트 방법, 문서와 다르거나 문서에 없는 지점 6건을 정리합니다."
excerpt_en: "Hands-on verification of EC2 Application Status Checks (launched 2026-08-10) by injecting failures into a test ASG. Detection to automatic replacement in 5m 10s, full recovery in about 8.5 minutes - the feature, the test method, and 6 gaps between docs and measurement."
---
