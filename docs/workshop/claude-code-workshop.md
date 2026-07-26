---
title: Claude Code Deep Dive Workshop
parent: Workshop
nav_order: 3
last_modified_date: "2026-07-26"
---

# Claude Code Deep Dive Workshop
{: .no_toc }

Claude Code 핸즈온 랩 — 설치와 첫 자동화부터 서브에이전트, Enterprise 배포, 설정 계층, CLI 파이프라인, Agent SDK, 그리고 3개의 캡스톤 미션과 3개의 참조 문서까지.
{: .fs-6 .fw-300 }

[랩 포털 열기](/ccw-hands-on-lab/index.html){: .btn .btn-primary .fs-5 .mb-4 .mb-md-0 .mr-2 }
[사전 점검](/ccw-hands-on-lab/ClaudeCode_Preflight_Check.html){: .btn .fs-5 .mb-4 .mb-md-0 }

---

## 시작 전 확인 (Preflight)

| Page | 주제 | 구성 |
|:-----|:-----|:-----|
| [PRE — 핸즈온 랩 시작 전 확인](/ccw-hands-on-lab/ClaudeCode_Preflight_Check.html) | Workshop Studio 접속, EC2 2대, 접속 주소, code-server, claude 기동까지 프리플라이트 | 5분 / 체크 5개 |

## 챕터 랩 (Chapter Labs)

각 랩은 40–80분 내외의 실습으로, 해당 챕터의 핵심 기능을 직접 다룹니다.

| Lab | 주제 | 구성 |
|:----|:-----|:-----|
| [CH 01 — 설치부터 Headless 자동화까지](/ccw-hands-on-lab/ClaudeCode_Ch1_HandsOnLab.html) | 설치와 인증, CLAUDE.md, 실제 버그 수정, 첫 헤드리스 파이프라인 실행 | 준비 + 6 Task |
| [CH 02 — Subagents, 전문 에이전트를 만들고 지휘하기](/ccw-hands-on-lab/ClaudeCode_Ch2_HandsOnLab.html) | code-reviewer 등 서브에이전트 3종 정의, 도구 권한 격리, 자동 위임과 병렬 실행 | 준비 + 5 Task |
| [CH 03 — Admin Setup, 통제 가능한 Enterprise 배포](/ccw-hands-on-lab/ClaudeCode_Ch3_HandsOnLab.html) | managed settings와 정책 배포, Bedrock 라우팅, 조직 단위 통제선 구축 | 준비 + 5 Task |
| [CH 04 — Settings, 나의 Claude Code를 팀의 플랫폼으로](/ccw-hands-on-lab/ClaudeCode_Ch4_HandsOnLab.html) | 설정 계층 실습(Part A)과 훅·스킬을 팀 자산으로 승격하는 슈퍼랩(Part B) | A 4 Task + B 4 Mission (80분) |
| [CH 05 — CLI Reference, 파이프라인의 부품으로](/ccw-hands-on-lab/ClaudeCode_Ch5_HandsOnLab.html) | 헤드리스 호출 5패턴, JSON 파싱, 로컬 리뷰 봇, 대시보드 파이프라인, GitHub Actions 통합 | 준비 + 4 Task |
| [CH 06 — Agent SDK, Claude Code를 코드에서 부른다](/ccw-hands-on-lab/ClaudeCode_Ch6_HandsOnLab.html) | query 함수, resume 대화 메모리, in-process 커스텀 도구, 미니 상주 점검원 | 준비 + 4 Task (60분) |

## 캡스톤 미션 (Capstone Missions)

설치 가이드로 환경을 갖춘 뒤, 세 가지 미션 중 선택해 진행합니다.

| Mission | 주제 | 구성 |
|:--------|:-----|:-----|
| [SETUP — Capstone 시작 전, 설치하면 좋은 것들](/ccw-hands-on-lab/ClaudeCode_Capstone_Setup.html) | Claude HUD 계기판, superpowers, Agent Toolkit for AWS 6종, 풀 스택 플러그인 32종 일괄 설치 | 15분 / 단계 4개 |
| [MISSION 1 — Press Start: Clawd Jump, 에이전틱 게임 개발](/ccw-hands-on-lab/ClaudeCode_Capstone1_HandsOnLab.html) | Clawd 마스코트의 슈퍼마리오풍 플랫포머를 superpowers로 만들어 CloudFront로 개장. Bedrock 미사용, API 키 불필요 | 135분 |
| [MISSION 2 — Market Desk: 터미널 주식 시황 데스크](/ccw-hands-on-lab/ClaudeCode_Capstone2_HandsOnLab.html) | Textual + yfinance + pykrx + Bedrock으로 지표 바, 골든크로스 차트, 호가창, 뉴스 AI 분석까지 풀스펙 빌드 | 135분 / 미션 5 + DoD |
| [MISSION 3 — Frame It: Generative Hours, 코드로 그린 전시](/ccw-hands-on-lab/ClaudeCode_Capstone3_HandsOnLab.html) | 제너러티브 아트 두 점으로 여는 인터랙티브 미디어 아트 전시 — 추상이 태어나는 순간을 직접 경험. Bedrock 미사용 | 120분 / 미션 6 + DoD |

## 참조 문서 (Reference)

랩 진행 중 찾아보는 선별 레퍼런스입니다.

| Reference | 주제 |
|:----------|:-----|
| [REF 1 — 디렉토리 구조, 무엇이 어디에 있는가](/ccw-hands-on-lab/ClaudeCode_Reference1_Directory.html) | `~/.claude`와 `.claude`, managed의 세 층 지도와 설정 우선순위, CLAUDE.md 계층 합산 |
| [REF 2 — 슬래시 커맨드, 세션을 조종하는 레버들](/ccw-hands-on-lab/ClaudeCode_Reference2_Commands.html) | 시작/설정, 작업 흐름, 병렬, 검수, 세션 이동, 상태로 묶은 선별 목록과 워크샵 등장 위치 |
| [REF 3 — 플러그인, 팀의 하네스를 배포하는 단위](/ccw-hands-on-lab/ClaudeCode_Reference3_Plugins.html) | 설치 3동사와 워크샵 3종(superpowers, project-init, harness-eval)의 역할, 신뢰 가드 |

---

{: .note }
랩 가이드는 독립 실행형 HTML 페이지로 제공됩니다. 위 링크를 클릭하면 새 스타일의 랩 페이지가 열리며, [랩 포털](/ccw-hands-on-lab/index.html)에서 전체 랩을 한눈에 볼 수 있습니다. 랩 원본과 강의자료는 [GitHub 저장소](https://github.com/whchoi98/claude-code-workshop)에서 관리됩니다.
