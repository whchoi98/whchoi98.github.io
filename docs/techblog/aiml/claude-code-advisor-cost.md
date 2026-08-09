---
title: "Claude Code Advisor 구성 비용 분석"
layout: report
report_src: /assets/reports/claude-code-advisor-cost-analysis.html
date: 2026-08-08
category: AIML
tags: [Claude Code, Advisor, FinOps]
icon: bedrock
minutes: 7
featured: true
excerpt: "Sonnet 5 + Opus 5 advisor vs Opus 5 고정 - 같은 과제를 실측한 토큰 비용 비교와 손익분기 분석. advisor 비용의 본체는 응답이 아니라 uncached input입니다."
---

같은 과제를 Sonnet 5 + Opus 5 advisor 구성과 Opus 5 고정 구성으로 각각 실행해 실측한 토큰 비용 비교입니다. 짧은 과제에서는 advisor 구성이 25% 비쌌고($1.238 vs $0.993), 435줄 리팩토링 과제에서는 15% 저렴했습니다($3.094 vs $3.646). advisor 비용의 본체는 자문 응답이 아니라 호출마다 전체 트랜스크립트를 캐시 없이 읽는 uncached input이며, 역전의 원인은 비율 희석이 아니라 Sonnet 단가 절약분이 오버헤드 절대액보다 빨리 커지는 데 있습니다. 아래 전체 분석 문서에서 실험 설계, 비용 구조, 상황별 권고를 다룹니다.
