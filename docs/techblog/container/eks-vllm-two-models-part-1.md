---
title: "OpenWeight on AWS GPU 1부: Amazon EKS와 vLLM의 LLM API 호출 8개 단계"
title_en: "OpenWeight on AWS GPU, Part 1: The eight stages of an LLM API call on Amazon EKS and vLLM"
layout: report
report_src: /docs/techblog/container/eks-vllm-two-models-part-1-report.html
date: 2026-11-21
category: Container
tags: ["Amazon EKS", "vLLM", "LLM inference", "Open-weight models", "Gateway API Inference Extension", "Amazon Bedrock AgentCore"]
icon: eks
minutes: 20
excerpt: "LLM API 호출 한 건을 8개 단계로 나누고 Amazon EKS와 vLLM으로 두 모델을 서빙하는 환경에서 단계마다 어떤 구성 요소가 그 일을 하는지 설명합니다. 첫 내용까지의 시간은 Gemma 4 31B 81.9ms, Qwen3.8-27B 177.5ms였고 그 가운데 77%와 83%를 vLLM이 사용했습니다."
excerpt_en: "One LLM API call split into 8 stages, with the component that does each stage in an environment that serves two models with vLLM on Amazon EKS. Time to first content was 81.9 ms for Gemma 4 31B and 177.5 ms for Qwen3.8-27B, and vLLM took 77% and 83% of it."
---
