---
title: "Amazon ElastiCache Distributed KV Caching"
title_en: "Amazon ElastiCache Distributed KV Caching"
layout: report
report_src: /docs/techblog/database/elasticache-distributed-kv-caching-report.html
date: 2026-11-23
category: Database
tags: ["Amazon ElastiCache", "Valkey", "KV cache", "LMCache", "vLLM", "EFA"]
icon: database
minutes: 12
excerpt: "Amazon ElastiCache의 distributed KV caching을 도쿄 리전의 GPU 서버 2대에 붙여 테스트했습니다. 다른 서버가 계산한 14,984토큰 프롬프트를 공유 캐시에서 읽으면 TTFT가 4,194.8ms에서 614.9ms가 됐고 982토큰에서는 거의 같았습니다."
excerpt_en: "I attached Amazon ElastiCache distributed KV caching to two GPU servers in the Tokyo Region. Reading a 14,984-token prompt that another server had computed brought TTFT from 4,194.8 ms to 614.9 ms, and at 982 tokens the two were about the same."
---
