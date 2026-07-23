---
title: Claude Code Deep Dive Workshop
parent: Workshop
nav_order: 3
last_modified_date: "2026-07-23"
---

# Claude Code Deep Dive Workshop
{: .no_toc }

Claude Code 핸즈온 랩 — 설치와 첫 자동화부터 서브에이전트, Enterprise 배포, 설정 계층, CLI 파이프라인, Agent SDK, 그리고 4개의 캡스톤 미션과 3개의 참조 문서까지.
{: .fs-6 .fw-300 }

[랩 포털 열기](/hands-on-lab/index.html){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }

---

## 챕터 랩 (Chapter Labs)

각 랩은 40–80분 내외의 실습으로, 해당 챕터의 핵심 기능을 직접 다룹니다.

| Lab | 주제 | 구성 |
|:----|:-----|:-----|
| [CH 01 — 설치부터 Headless 자동화까지](/hands-on-lab/ClaudeCode_Ch1_HandsOnLab.html) | 설치와 인증, CLAUDE.md, 실제 버그 수정, 첫 헤드리스 파이프라인 실행 | 준비 + 6 Task |
| [CH 02 — Subagents, 전문 에이전트를 만들고 지휘하기](/hands-on-lab/ClaudeCode_Ch2_HandsOnLab.html) | code-reviewer 등 서브에이전트 3종 정의, 도구 권한 격리, 자동 위임과 병렬 실행 | 준비 + 5 Task |
| [CH 03 — Admin Setup, 통제 가능한 Enterprise 배포](/hands-on-lab/ClaudeCode_Ch3_HandsOnLab.html) | managed settings와 정책 배포, Bedrock 라우팅, 조직 단위 통제선 구축 | 준비 + 5 Task |
| [CH 04 — Settings, 나의 Claude Code를 팀의 플랫폼으로](/hands-on-lab/ClaudeCode_Ch4_HandsOnLab.html) | 설정 계층 실습(Part A)과 훅·스킬을 팀 자산으로 승격하는 슈퍼랩(Part B) | A 4 Task + B 4 Mission (80분) |
| [CH 05 — CLI Reference, 파이프라인의 부품으로](/hands-on-lab/ClaudeCode_Ch5_HandsOnLab.html) | 헤드리스 호출 5패턴, JSON 파싱, 로컬 리뷰 봇, 대시보드 파이프라인, GitHub Actions 통합 | 준비 + 4 Task |
| [CH 06 — Agent SDK, Claude Code를 코드에서 부른다](/hands-on-lab/ClaudeCode_Ch6_HandsOnLab.html) | query 함수, resume 대화 메모리, in-process 커스텀 도구, 미니 상주 점검원 | 준비 + 4 Task (60분) |

## 캡스톤 랩 (Capstone Labs)

각 미션은 135분 / 6 Mission 구성의 종합 실습입니다.

| Mission | 주제 | 핵심 |
|:--------|:-----|:-----|
| [MISSION A — 만드는 Claude: Ship It](/hands-on-lab/ClaudeCode_Capstone_HandsOnLab.html) | S3/CloudFront + API + Lambda + DynamoDB + Bedrock 질의 패널 풀스택 배포 | 도구가 자기 자신을 관측하는 훅 루프 |
| [MISSION B — 지키는 Claude: Self-Heal](/hands-on-lab/ClaudeCode_CapstoneB_HandsOnLab.html) | 장애 주입 → 헤드리스 메딕이 런북으로 감별 진단해 자가 복구 | PreToolUse 인터록의 파괴 명령 차단 |
| [MISSION C — 파는 Claude: Grand Open](/hands-on-lab/ClaudeCode_CapstoneC_HandsOnLab.html) | 자연어 주문을 Converse toolConfig로 구조화 추출하는 AI 카페 | 서버 영수증 로직의 메뉴판 재검증 |
| [MISSION D — 기억하는 Claude: Grounded](/hands-on-lab/ClaudeCode_CapstoneD_HandsOnLab.html) | Titan 임베딩과 DynamoDB 코사인 검색으로 RAG를 직접 구현 | 출처 인용과 환각 게이트 자격시험 |

## 참조 문서 (Reference)

랩 진행 중 찾아보는 선별 레퍼런스입니다.

| Reference | 주제 |
|:----------|:-----|
| [REF 1 — 슬래시 커맨드, 세션을 조종하는 30개의 레버](/hands-on-lab/ClaudeCode_Reference1_Commands.html) | 시작/설정, 작업 흐름, 병렬, 검수, 세션 이동, 상태로 묶은 선별 목록과 워크샵 등장 위치 |
| [REF 2 — 플러그인, 팀의 하네스를 배포하는 단위](/hands-on-lab/ClaudeCode_Reference2_Plugins.html) | 설치 3동사와 워크샵 3종(superpowers, project-init, harness-eval)의 역할, 신뢰 가드 |
| [REF 3 — 디렉토리 구조, 무엇이 어디 사는가](/hands-on-lab/ClaudeCode_Reference3_Directory.html) | `~/.claude`와 `.claude`, managed의 세 층 지도와 설정 우선순위, CLAUDE.md 계층 합산 |

---

{: .note }
랩 가이드는 독립 실행형 HTML 페이지로 제공됩니다. 위 링크를 클릭하면 새 스타일의 랩 페이지가 열리며, [랩 포털](/hands-on-lab/index.html)에서 전체 랩을 한눈에 볼 수 있습니다.
