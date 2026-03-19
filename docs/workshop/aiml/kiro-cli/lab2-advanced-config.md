---
title: "LAB 2. 고급 구성"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 3
last_modified_date: "2026-03-19"
---

# LAB 2. Kiro CLI 고급 구성
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

*Update: 2025.12.06*
{: .fs-3 .text-grey-dk-000 }

본 섹션은 선택(Optional) 항목으로, Kiro CLI의 내부 구조와 설정 방식을 보다 깊이 이해하고자 하는 사용자에게 제공됩니다.

{: .note }
> 기본 실습을 빠르게 진행하고자 한다면 본 섹션은 건너뛰어도 무방합니다.

---

## 1. Kiro CLI 구성 심층 탐색

Kiro CLI는 전역 설정(Global Configuration)과 프로젝트 기반 로컬 설정(Project-scoped Configuration)을 모두 지원하며, 이를 통해 사용자는 CLI의 행동과 모델(Model) 설정을 세밀하게 조정할 수 있습니다.

---

## 2. 디렉터리 구조 이해하기

Kiro CLI는 설정 파일(Configuration File)을 다음 두 위치에서 관리합니다.

### 2.1 전역 설정(Global Settings Directory)

- 위치:

```bash
~/.kiro
```

- 모든 Kiro CLI 세션(Session)에서 공통적으로 사용하는 전역 구성(Global Configuration) 저장소입니다.
- 예: `settings.json`, MCP 설정, 히스토리(History) 파일 등이 여기에 위치

### 2.2 프로젝트별 설정(Project Workspace Settings)

- Kiro CLI를 실행한 현재 디렉터리(Current Working Directory)가 자동으로 프로젝트 작업 공간(Project Workspace)으로 처리됩니다.
- 해당 디렉터리 아래에 다음 폴더가 생성될 수 있습니다:

```
my-project/
├── .kiro/
│   ├── settings.json        # 프로젝트별 설정
│   ├── steering/            # 커스텀 에이전트 설정
│   │   └── agent.md
│   ├── skills/              # 스킬 정의
│   │   └── aws-iam/
│   │       └── SKILL.md
│   └── mcp.json             # MCP 서버 설정
```

---

## 3. 주요 설정 항목

| 설정(Setting) | 위치 | 설명 |
|:-------------|:-----|:-----|
| **settings.json** | `~/.kiro/` 또는 `.kiro/` | 모델 선택, 권한, UI 설정 |
| **steering/** | `.kiro/steering/` | 커스텀 에이전트(Custom Agent) 동작 정의 |
| **skills/** | `.kiro/skills/` | 재사용 가능한 스킬(Skill) 정의 |
| **mcp.json** | `.kiro/` | MCP 서버 연결 설정 |

---

## 참고 자료(References)

- [원본 소스(Source): whchoi98/awsmcp](https://github.com/whchoi98/awsmcp/blob/main/kiro-cli/lab-2.-kiro-cli.md)
- [Kiro CLI Configuration 문서](https://kiro.dev/docs/configuration/)
