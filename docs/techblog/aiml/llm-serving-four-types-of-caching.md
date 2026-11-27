---
title: "LLM 서빙의 캐시 4가지"
title_en: "Four types of caching in LLM serving"
layout: report
report_src: /docs/techblog/aiml/llm-serving-four-types-of-caching-report.html
date: 2026-11-27
category: AIML
tags: ["LLM serving", "KV cache", "Prefix caching", "Prompt caching", "Semantic cache", "vLLM", "Amazon Bedrock", "Amazon ElastiCache"]
icon: bedrock
minutes: 10
excerpt: "LLM 서빙에서 캐시라고 부르는 KV 캐시, 프리픽스 캐시, 프롬프트 캐시, 시맨틱 캐시가 무엇을 저장하고 어디에서 동작하는지 정리하고 작은 실험으로 확인했습니다. 앞의 세 가지는 KV를 저장해 계산을 재사용하고 시맨틱 캐시만 응답을 저장합니다."
excerpt_en: "What the KV cache, prefix cache, prompt cache and semantic cache of LLM serving each store and where they work, checked with four small experiments. The first three store KV and reuse computation; only the semantic cache stores responses."
---
