---
title: "OpenWeight on AWS GPU 2부: 두 모델을 서빙하는 구조와 Amazon EKS 최적화"
title_en: "OpenWeight on AWS GPU, Part 2: The architecture for serving two models and Amazon EKS optimizations"
layout: report
report_src: /docs/techblog/container/eks-vllm-two-models-part-2-report.html
date: 2026-11-21
category: Container
tags: ["Amazon EKS", "vLLM", "LLM inference", "GPU", "Karpenter", "Gateway API Inference Extension", "Open-weight models"]
icon: eks
minutes: 25
excerpt: "Amazon EKS에서 vLLM으로 Gemma 4 31B와 Qwen3.8-27B를 함께 서빙하는 환경의 구조를 6개 계층으로 나눠 설명합니다. 콜드 스타트, GPU 메모리와 동시 실행, 우선순위, sleep의 최적화 4가지를 측정한 값과 함께 정리했습니다."
excerpt_en: "The architecture of an environment that serves Gemma 4 31B and Qwen3.8-27B together with vLLM on Amazon EKS, explained in six layers. It also covers four optimizations (cold start, GPU memory and concurrent requests, priority, sleep) with their measured values."
---
