---
title: "Amazon EKS에서 vLLM으로 두 모델 서빙하기 3부: 게이트웨이와 BFF의 모델 라우팅"
title_en: "Serving two models with vLLM on Amazon EKS, Part 3: Model routing with a gateway and a BFF"
layout: report
report_src: /docs/techblog/container/eks-vllm-two-models-part-3-report.html
date: 2026-11-21
category: Container
tags: ["Amazon EKS", "vLLM", "Gateway API Inference Extension", "agentgateway", "Amazon CloudFront", "LLM inference"]
icon: eks
minutes: 30
excerpt: "두 모델 앞에 엔드포인트를 하나만 두려면 요청을 어느 모델로 보낼지 정하는 곳이 필요합니다. BFF가 규칙과 Strands Decider 2B로 모델을 정하고 게이트웨이가 본문의 model 값으로 풀을 고르는 구성을 계층별로 설명하고 구간별 시간을 쟀습니다. 사용자가 본 첫 내용까지의 시간 가운데 77%에서 83%는 vLLM이 사용했습니다."
excerpt_en: "Putting one endpoint in front of two models needs a place that decides which model a request goes to. This post walks through a setup where the BFF picks the model with rules and Strands Decider 2B and the gateway selects the pool by the model value in the body, and it measures the time spent in each segment. vLLM took 77% to 83% of the time to the first content the user saw."
---
