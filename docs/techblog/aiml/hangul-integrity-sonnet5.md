---
title: "Claude Sonnet 5 한글 출력 무결성 조사 - 1,200런 통제 실험"
title_en: "Claude Sonnet 5 Korean Output Integrity Investigation - A 1,200-Run Controlled Experiment"
layout: report
report_src: /docs/techblog/aiml/hangul-integrity-sonnet5-report.html
date: 2026-08-09
category: AIML
tags: [Claude, Bedrock, Unicode, Investigation]
icon: bedrock
minutes: 11
excerpt: "Claude Code에서 관찰된 한글 음절 손상의 근본 원인을 6개 데이터셋, 1,200여 런으로 추적한 조사 - 컨텍스트 점유율 가설 기각, 유니코드 이스케이프 오기 확정, 적대적 검증 패널 방법론을 다룹니다."
excerpt_en: "An investigation tracing the root cause of Hangul syllable corruption observed in Claude Code across 6 datasets and roughly 1,200 runs - rejecting the context-fill hypothesis, confirming Unicode escape miscoding, and covering the adversarial verification panel methodology."
---
