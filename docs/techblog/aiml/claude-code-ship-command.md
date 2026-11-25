---
title: "Claude Code /ship"
title_en: "Claude Code /ship"
layout: report
report_src: /docs/techblog/aiml/claude-code-ship-command-report.html
date: 2026-11-25
category: AIML
tags: ["Claude Code", "ship command", "Code Review", "Pull Request", "GitHub"]
icon: bedrock
minutes: 8
excerpt: "Claude Code의 /ship 명령을 결함 3개를 심은 PR 하나로 직접 테스트했습니다. 리뷰는 심어 둔 결함을 모두 찾았고 감시는 점검 4회, 합계 453초로 리뷰 코멘트와 base 브랜치 충돌을 처리했습니다. 감시 비용이 세션의 컨텍스트 크기에 비례한다는 점도 수치로 확인했습니다."
excerpt_en: "I tested the Claude Code /ship command on one pull request with three seeded defects. The review found all three, and the watch handled a review comment and a conflict with the base branch in four check-ins, 453 seconds in total. The numbers also show that the cost of a watch grows with the size of the session's context."
---
