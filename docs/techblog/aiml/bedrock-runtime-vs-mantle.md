---
title: "Amazon Bedrock Runtime과 Mantle의 차이와 선택 기준"
title_en: "How Amazon Bedrock Runtime and Mantle differ, and which to choose"
layout: report
report_src: /docs/techblog/aiml/bedrock-runtime-vs-mantle-report.html
date: 2026-11-21
category: AIML
tags: ["Amazon Bedrock", "bedrock-runtime", "bedrock-mantle", "Project Mantle", "Responses API", "OpenAI-compatible API"]
icon: bedrock
minutes: 17
excerpt: "Amazon Bedrock에는 추론 요청을 받는 엔드포인트가 bedrock-runtime과 bedrock-mantle 두 개 있습니다. 두 엔드포인트는 같은 Mantle 추론 엔진을 사용하고 토큰 단가도 같습니다. 받는 API, 한쪽에만 있는 기능, 권한과 할당량과 관측, 모델과 리전의 차이를 AWS 문서 기준으로 정리하고 상황별 선택 기준을 제시합니다."
excerpt_en: "Amazon Bedrock has two endpoints that take inference requests, bedrock-runtime and bedrock-mantle. Both run on the same Mantle inference engine at the same per-token price. This post sets out how they differ in the APIs they accept, the features only one of them has, permissions, quotas and observability, and models and Regions, based on the AWS documentation, and gives criteria for choosing."
---
