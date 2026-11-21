---
title: "AWS에서 vLLM을 실행하는 플랫폼 여섯 가지와 선택 기준"
title_en: "Six AWS platforms for running vLLM and how to choose"
layout: report
report_src: /docs/techblog/aiml/vllm-on-aws-platform-selection-report.html
date: 2026-11-21
category: AIML
tags: ["vLLM", "LLM inference", "AWS Lambda", "Amazon ECS", "Amazon EKS", "Amazon SageMaker AI", "SageMaker HyperPod"]
icon: bedrock
minutes: 21
excerpt: "AWS에서 vLLM 컨테이너를 실행하는 플랫폼은 EC2, ECS, EKS, Lambda, SageMaker AI, SageMaker HyperPod 여섯 가지입니다. 여섯 곳 모두 같은 엔진과 같은 OpenAI 호환 API를 사용하므로 운영 범위, 요청 경로, 확장과 시작 시간, 요금 단위 네 가지 기준으로 비교하고 상황별 선택 순서를 정리했습니다."
excerpt_en: "There are six AWS platforms that run a vLLM container: EC2, ECS, EKS, Lambda, SageMaker AI and SageMaker HyperPod. All six run the same engine behind the same OpenAI-compatible API, so this post compares them on four criteria (who operates what, how requests arrive, scaling and start-up time, and what is billed) and gives an order in which to consider them."
---
