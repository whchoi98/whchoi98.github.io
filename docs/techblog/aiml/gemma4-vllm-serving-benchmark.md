---
title: "Gemma-4-31B vLLM 서빙 PoC 벤치마크"
title_en: "Gemma-4-31B vLLM Serving PoC Benchmark"
layout: report
report_src: /docs/techblog/aiml/gemma4-vllm-serving-benchmark-report.html
date: 2026-08-09
category: AIML
tags: [vLLM, EKS, Karpenter, NVFP4, FP8, Benchmark]
icon: eks
minutes: 10
excerpt: "Gemma-4-31B를 EKS와 Karpenter 위 vLLM으로 서빙하며 처리량, 기동 시간, 한국어 수용률을 측정한 PoC. L40S 기준선 28조합부터 g7e 본판정(3.5~4.8배)까지 실측치를 정리합니다."
excerpt_en: "A PoC serving Gemma-4-31B with vLLM on EKS and Karpenter, measuring throughput, startup time, and Korean acceptance rate. It walks through the measured numbers from the 28-combination L40S baseline to the g7e final verdict (3.5-4.8x)."
---
