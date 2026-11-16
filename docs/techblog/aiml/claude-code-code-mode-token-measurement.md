---
title: "Claude Code의 Code Mode 기능 기반의 토큰 절감"
title_en: "Token savings with the Code Mode feature in Claude Code"
layout: report
report_src: /docs/techblog/aiml/claude-code-code-mode-token-measurement-report.html
date: 2026-11-16
category: AIML
tags: ["Claude Code", "Code Mode", "MCP", "Prompt Caching", "Token Economics"]
icon: bedrock
minutes: 15
excerpt: "Claude Code v2.1.325에서 Code Mode를 끈 세션과 켠 세션을 Sonnet 5.5로 54회 비교했습니다. 기본 도구 작업은 총 토큰이 42%, 비용이 13% 줄었고 MCP 도구 작업은 총 토큰이 19% 늘었습니다. 활성화 방법, Amazon Bedrock과 OpenTelemetry 제약, 측정 방법도 정리했습니다."
excerpt_en: "I compared sessions with Code Mode off and on in Claude Code v2.1.325, 54 runs on Sonnet 5.5. Tasks on built-in tools used 42% fewer total tokens and cost 13% less, and tasks on MCP tools used 19% more total tokens. The post also covers how to enable it, the Amazon Bedrock and OpenTelemetry limits, and the measurement method."
---
