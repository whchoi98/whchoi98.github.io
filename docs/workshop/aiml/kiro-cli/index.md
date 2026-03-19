---
title: Kiro CLI Workshop
parent: AIML
grand_parent: Workshop
nav_order: 1
has_children: true
last_modified_date: "2026-03-19"
---

# Kiro CLI Workshop
{: .no_toc }

Kiro CLI 핸즈온 워크샵 — AI 보조 개발 도구(AI-Assisted Development Tool)를 활용한 실습 가이드.
{: .fs-6 .fw-300 }

*Update: 2025.12.20*
{: .fs-3 .text-grey-dk-000 }

---

## Kiro CLI란?

Kiro CLI는 터미널(커맨드라인)에서 동작하는 AI 보조 개발 도구(AI-Assisted Development Tool)입니다. GUI IDE 대신 셸(Shell) 환경에서 Kiro의 AI 에이전트(Agent)를 사용해 코드 생성(Code Generation), 수정, 테스트(Test), 인프라 코드(Infrastructure Code) 작성 등을 할 수 있게 해줍니다.

Kiro CLI는 기존 Amazon Q Developer CLI의 리브랜딩(Rebranding)된 AI 보조 개발 도구로, 2025년 정식 릴리스(Release)된 버전입니다.

## 주요 기능 & 특징

- **컨텍스트 유지(Context Persistence) & 커스텀 에이전트(Custom Agent)** — 프로젝트 루트(Root), 설정 파일(.kiro/steering 등), 컨텍스트 파일 등을 기반으로 AI 에이전트를 커스터마이즈(Customize)할 수 있습니다.
- **MCP 및 도구 연동(Tool Integration)** — 파일 읽기/쓰기, API 호출, Bash 명령 실행 등 로컬/원격 환경에서 다양한 작업을 수행할 수 있습니다.
- **유연한 개발 환경(Flexible Development)** — IDE 대신 터미널만 사용할 때, 또는 SSH / 서버 환경에서 빠르게 작업할 때 유용합니다.

## 설치(Installation)

```bash
curl -fsSL https://cli.kiro.dev/install | bash
```

## 워크샵 구성(Workshop Outline)

| LAB | 내용 | 소요 시간 |
|:----|:-----|:---------|
| **LAB 0** | VSCode 서버 구성하기 | 20분 |
| **LAB 1** | Kiro CLI 초기 구축 및 사용 | 30분 |
| **LAB 2** | Kiro CLI 고급 구성 | 30분 |
| **LAB 3** | Kiro CLI Part 1 | 40분 |
| **LAB 4** | Kiro CLI Part 2 | 40분 |
| **LAB 5** | Kiro CLI 고급 기능 | 40분 |
| **LAB 6** | Kiro CLI 기반 클라우드 운영 | 60분 |

{: .note }
> 원본 소스(Source): [whchoi98/awsmcp](https://github.com/whchoi98/awsmcp) (Gitbook)
