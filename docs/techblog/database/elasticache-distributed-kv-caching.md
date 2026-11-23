---
title: "Amazon ElastiCache Distributed KV Caching"
title_en: "Amazon ElastiCache Distributed KV Caching"
layout: report
report_src: /docs/techblog/database/elasticache-distributed-kv-caching-report.html
date: 2026-11-23
category: Database
tags: ["Amazon ElastiCache", "Valkey", "KV cache", "LMCache", "vLLM", "EFA"]
icon: database
minutes: 14
excerpt: "Amazon ElastiCache의 distributed KV caching을 도쿄 리전의 GPU 서버 2대에 붙여 테스트했습니다. 긴 프롬프트와 메모리를 넘는 멀티턴 부하에서 TTFT와 처리량이 좋아졌지만 이 규모에서는 요청 1,000건당 비용이 1.36배에서 2.11배로 올랐고 계산으로는 GPU 서버 4대에서 8대부터 비용도 내려갑니다."
excerpt_en: "I attached Amazon ElastiCache distributed KV caching to two GPU servers in the Tokyo Region. TTFT and throughput improved for long prompts and multi-turn loads that outgrow memory, but at this scale the cost per 1,000 requests rose 1.36 to 2.11 times; by calculation the cost also falls from 4 to 8 GPU servers."
---
