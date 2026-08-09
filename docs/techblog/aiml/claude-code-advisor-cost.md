---
title: "Claude Code Advisor 구성 비용 분석"
date: 2026-08-08
category: AIML
tags: [Claude Code, Advisor, FinOps]
icon: bedrock
minutes: 7
featured: true
excerpt: "Sonnet 5 + Opus 5 advisor vs Opus 5 고정 - 같은 과제를 실측한 토큰 비용 비교와 손익분기 분석. advisor 비용의 본체는 응답이 아니라 uncached input입니다."
---

# Claude Code advisor 구성 비용 분석 - Sonnet 5 + Opus 5 advisor vs Opus 5 고정

같은 과제를 **Sonnet 5 + Opus 5 advisor** 구성과 **Opus 5 고정** 구성으로 각각 실행해 실측한 토큰 비용 비교입니다. 과제 규모에 따라 어느 구성이 저렴한지, 그 손익분기가 어디서 갈리는지를 다룹니다.

[전체 분석 문서 보기 (HTML)](/assets/reports/claude-code-advisor-cost-analysis.html){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 }

---

## 요약
{: .no_toc }

- Sonnet 5 + Opus 5 advisor 구성은 짧은 과제에서 Opus 5 고정보다 **25% 비쌌고**($1.238 vs $0.993), 435줄 리팩토링 과제에서는 **15% 저렴**했습니다($3.094 vs $3.646).
- advisor 비용은 응답(output)이 아니라 입력에서 나옵니다. 호출할 때마다 전체 대화 트랜스크립트를 캐시 없이 새로 읽기 때문에(advisor 측 `cache_read` 0), 대화가 길수록 호출당 비용이 커집니다.
- advisor는 붙여놔도 호출이 보장되지 않습니다. 짧은 과제에서 미호출로 끝나면 오버헤드 0으로 Opus 고정 대비 43% 저렴했지만, 이번 실측에서는 호출이 1회 발생하자 총비용이 역전됐습니다.
- 짧고 평이한 과제는 Sonnet 단독으로 충분했고, 장기 다단계 작업은 advisor 구성이 유리했습니다.

## 실측 결과 한눈에 보기
{: .no_toc }

| 과제 | advisor 구성 | Opus 5 고정 | 차이 |
|:-----|:------------|:-----------|:-----|
| 짧은 과제 (가계부 CLI) | $1.238 (호출 1회) | $0.993 | advisor가 **+25%** |
| 대형 리팩토링 (435줄 모놀리스) | $3.094 (호출 2회) | $3.646 | advisor가 **-15%** |

두 실험 모두 총비용 대비 advisor 오버헤드 비율은 27~28%로 일정했습니다. 역전의 원인은 비율 희석이 아니라, output을 Sonnet 단가로 생성하는 절약분이 오버헤드 절대액보다 빨리 커진 데 있습니다.

전체 실험 설계, 비용 구조 분석, 상황별 권고는 [전체 분석 문서](/assets/reports/claude-code-advisor-cost-analysis.html)에서 확인하세요. 라이트/다크 테마와 인쇄를 지원하는 단일 파일 문서입니다.

## 참고 자료
{: .no_toc }

- [Claude Code Docs - Advisor](https://code.claude.com/docs/en/advisor)
- [Claude API Docs - Advisor tool](https://platform.claude.com/docs/en/agents-and-tools/tool-use/advisor-tool)
