---
title: "Amazon EKS에서 vLLM으로 두 모델 서빙하기 2부: L40S 한 장의 처리량과 SLO"
title_en: "Serving two models with vLLM on Amazon EKS, Part 2: Throughput and SLO on a single L40S"
layout: report
report_src: /docs/techblog/container/eks-vllm-two-models-part-2-report.html
date: 2026-11-21
category: Container
tags: ["Amazon EKS", "vLLM", "LLM inference", "GPU", "SLO", "Amazon Managed Service for Prometheus"]
icon: eks
minutes: 18
excerpt: "L40S 한 장에 올린 vLLM 파드가 요청을 동시에 몇 건까지 실행하는지를 Gemma 4 31B와 Qwen3.8-27B로 쟀습니다. 한도를 정한 것은 가중치를 빼고 남은 KV 캐시와 MTP 설정이었고 토큰 간격은 요청을 하나씩 보낼 때에도 목표 50ms를 넘었습니다."
excerpt_en: "I measured how many requests a vLLM pod on a single L40S runs at the same time, with Gemma 4 31B and Qwen3.8-27B. The limit was set by the KV cache left after the weights and by the MTP setting, and the gap between tokens was over the 50 ms target even with one request at a time."
---
