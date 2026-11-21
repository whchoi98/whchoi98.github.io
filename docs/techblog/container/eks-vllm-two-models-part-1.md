---
title: "Amazon EKS에서 vLLM으로 두 모델 서빙하기 1부: 콜드 스타트 구간별 단축"
title_en: "Serving two models with vLLM on Amazon EKS, Part 1: Cutting cold start phase by phase"
layout: report
report_src: /docs/techblog/container/eks-vllm-two-models-part-1-report.html
date: 2026-11-21
category: Container
tags: ["Amazon EKS", "vLLM", "Karpenter", "LLM inference", "GPU", "Amazon S3"]
icon: eks
minutes: 21
excerpt: "GPU 노드에서 vLLM 파드가 Ready가 되기까지의 시간을 노드 프로비저닝, 이미지 pull, 가중치 로드, 엔진 초기화의 네 구간으로 나눠 쟀습니다. Gemma 4 31B의 콜드 스타트는 394초에서 260초로, 웜 재시작은 214초에서 86초로 줄었고 구간마다 다른 조치가 효과를 냈습니다."
excerpt_en: "I split the time a vLLM pod on a GPU node takes to become Ready into four phases: node provisioning, image pull, weight load and engine initialization. The Gemma 4 31B cold start fell from 394 s to 260 s and the warm restart from 214 s to 86 s, and a different action worked in each phase."
---
