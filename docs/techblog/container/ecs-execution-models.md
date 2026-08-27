---
title: "ECS는 무엇으로 어떻게 실행되나 - 컴퓨트, 배포, 네트워크 형태 전부 정리"
title_en: "What Runs ECS, and How - Compute, Deployment, and Network Models in One Place"
layout: report
report_src: /docs/techblog/container/ecs-execution-models-report.html
date: 2026-08-26
category: Container
tags: [ECS, Fargate, Managed Instances, Capacity Provider, Deployment]
icon: ecs
minutes: 14
excerpt: "가장 중요한 변화부터: launch type은 이제 호환성 선언용이고 실제 실행은 capacity provider가 권고 경로입니다. ECS Managed Instances가 채우는 Fargate와 EC2 사이, Express Mode, 3종에서 6종이 된 배포 전략, 네트워크 모드와 IPv6-only 제약까지 2026-08 기준으로 전부 정리합니다."
excerpt_en: "The biggest shift first: launch types are now compatibility declarations, and capacity providers are the recommended execution path. ECS Managed Instances filling the gap between Fargate and EC2, Express Mode, deployment strategies grown from 3 to 6, network modes, and IPv6-only constraints - all as of 2026-08."
---
