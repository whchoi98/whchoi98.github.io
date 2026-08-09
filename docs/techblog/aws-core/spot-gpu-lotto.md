---
title: "GPU Spot Lotto - 멀티 리전 GPU Spot 가격 모니터링과 워크로드 디스패치"
layout: report
report_src: /docs/techblog/aws-core/spot-gpu-lotto-report.html
date: 2026-08-09
category: AWS Core
tags: [EC2 Spot, GPU, EKS, FSx Lustre, AgentCore]
icon: eks
minutes: 11
excerpt: "서울 컨트롤 플레인이 3개 US 리전의 GPU Spot 가격을 60초 주기로 감시하고 최저가 리전 EKS로 작업을 디스패치하는 시스템 - Hub-and-Spoke 스토리지, Strands 에이전트 인터페이스를 코드 기준으로 분석합니다."
---
