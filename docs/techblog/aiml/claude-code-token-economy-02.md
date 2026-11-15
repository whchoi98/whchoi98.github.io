---
title: "Claude Code 토큰 비용 최적화하기 2부: 캐시 경제학과 Amazon Bedrock 조직 비용 관리"
title_en: "Optimizing Claude Code token costs, Part 2: Cache economics and organizational cost management on Amazon Bedrock"
layout: report
report_src: /docs/techblog/aiml/claude-code-token-economy-02-report.html
date: 2026-09-02
category: AIML
tags: ["Claude Code", "Amazon Bedrock", "Prompt Caching", "Cost Optimization", "OpenTelemetry", "Claude Console", "LLM Gateway"]
icon: bedrock
minutes: 9
excerpt: "자리를 비운 뒤 첫 응답이 느리고 비싼 이유와 Amazon Bedrock 조직에서 사용자별 지출이 보이지 않는 이유를 캐시 수명(TTL), 캐시 무효화 조건, 접속 방식별 비용 통제 지점으로 설명합니다."
excerpt_en: "Why the first response after a break is slow and expensive, and why per-user spend is not visible in an Amazon Bedrock organization, explained through cache lifetime (TTL), cache invalidation conditions, and the cost control points of each connection method."
---
