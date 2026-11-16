---
title: "Claude Code 설정 우선순위와 권한규칙 Deep Dive"
title_en: "Claude Code settings precedence and permission rules: a deep dive"
layout: report
report_src: /docs/techblog/aiml/claude-code-settings-precedence-report.html
date: 2026-11-16
category: AIML
tags: ["Claude Code", "Settings", "Permissions", "Managed settings", "Workspace trust", "Hooks"]
icon: bedrock
minutes: 20
excerpt: "Claude Code의 설정 파일 다섯 곳(Managed, 명령줄, 프로젝트 로컬, 공유 프로젝트, 사용자) 가운데 어느 값이 적용되는지 정리했습니다. 권한 규칙이 deny, ask, allow 순서로 평가되는 방식, 폴더 신뢰, Managed 소스 사이의 순위를 회사 규정에 빗대어 설명합니다."
excerpt_en: "This post sorts out which value applies among the five places Claude Code reads settings from: managed, command line, project local, shared project, and user. It explains how permission rules are evaluated in deny, ask, allow order, how workspace trust works, and how managed sources rank, using a company's rulebooks as the analogy."
---
