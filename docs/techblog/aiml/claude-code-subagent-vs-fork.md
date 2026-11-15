---
title: "Claude Code의 Subagent와 fork: 무엇을 물려받고 결과가 어디로 돌아오는가"
title_en: "Subagents and forks in Claude Code: what each one inherits and where its result goes"
layout: report
report_src: /docs/techblog/aiml/claude-code-subagent-vs-fork-report.html
date: 2026-11-15
category: AIML
tags: ["Claude Code", "Subagents", "Fork", "Agent view", "Prompt Caching", "Git worktree"]
icon: bedrock
minutes: 8
excerpt: "Claude Code의 일반 서브에이전트, fork 서브에이전트(/subtask), 세션 복사(/fork), 대화 분기(/branch)를 물려받는 컨텍스트와 결과가 돌아오는 곳으로 구분했습니다. 버전별 명령 변화와 선택 기준, fork 모드를 끄는 설정도 정리했습니다."
excerpt_en: "This post tells apart the regular subagent, the fork subagent (/subtask), the session copy (/fork), and the conversation branch (/branch) in Claude Code by the context each one inherits and where its result goes. It also covers how the commands changed across versions, how to choose, and how to turn fork mode off."
---
