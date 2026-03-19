---
title: "Chat Configuration"
parent: Kiro CLI Workshop
nav_order: 19
last_modified_date: "2026-03-19"
---

# Configuration
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Configuration

### 1.1 구성(Configuration) 개요

Kiro CLI는 개발자 개인의 선호(Preferences)와 팀 표준(Team standards)에 맞게 다양한 구성을 설정할 수 있도록 설계되어 있습니다.

구성(Configuration)은 적용 범위(Scope)에 따라 다음 세 가지 수준에서 정의할 수 있습니다.

1. 전역(Global) 구성
   * Kiro가 사용되는 모든 프로젝트에 공통으로 적용되는 구성
   * 경로: `<user-home>/.kiro/`
2. 프로젝트(Project) 구성
   * 특정 프로젝트에만 적용되는 구성
   * 경로: `<project-root>/.kiro/`
3. 에이전트(Agent) 구성
   * 특정 커스텀 에이전트(Custom agent)에만 적용되는 구성
   * 경로: `<user-home | project-root>/.kiro/agents`

***

### 1.2 구성 파일 경로(Configuration file paths)

다음 표는 구성 항목별로 전역(Global) 및 프로젝트(Project) 범위에서 사용되는 파일 및 디렉터리 경로를 나타냅니다.

| Configuration | Global Scope                | Project Scope           |
| ------------- | --------------------------- | ----------------------- |
| MCP servers   | `~/.kiro/settings/mcp.json` | .kiro/settings/mcp.json |
| Prompts       | `~/.kiro/prompts`           | .kiro/prompts           |
| Custom agents | `~/.kiro/agents`            | .kiro/agents            |
| Steering      | `~/.kiro/steering`          | .kiro/steering          |
| Settings      | `~/.kiro/settings/cli.json` |                         |

***

### 1.3 범위별 구성 가능 항목(What can you configure at these scopes)

아래 표는 각 구성 항목이 어느 범위(Scope)에서 정의될 수 있는지를 보여줍니다.

| Configuration | User Scope | Project Scope | Agent Scope |
| ------------- | ---------- | ------------- | ----------- |
| MCP servers   | Yes        | Yes           | Yes         |
| Prompts       | Yes        | Yes           | No          |
| Custom agents | Yes        | Yes           | N/A         |
| Steering      | Yes        | Yes           | Yes         |
| Settings      | Yes        | N/A           | N/A         |

***

### 1.4 구성 충돌 해결 방식(Resolving configuration conflicts)

Kiro CLI는 동일한 구성 항목이 여러 범위에 정의되어 있는 경우, 현재 사용자가 Kiro CLI와 상호작용하고 있는 위치(Location)에 가장 가까운 구성을 우선 적용합니다.

#### 1.4.1 예시

* 전역(Global)과 프로젝트(Project) 모두에 mcp.json 파일이 존재하는 경우
*   프로젝트 디렉터리에서 Kiro와 대화(Chat)하고 있다면

    → 프로젝트(Project) 범위의 MCP 구성이 적용됩니다.

***

### 1.5 에이전트 구성 우선 규칙(Agent override)

커스텀 에이전트(Custom agent)는 전역(Global)과 프로젝트(Project) 범위 모두에서 정의될 수 있습니다.

동일한 수준(Level)에서 구성 충돌이 발생할 경우, 에이전트 구성(Agent configuration) 이 항상 우선 적용됩니다.

즉, 에이전트에 명시적으로 정의된 구성은 동일 범위의 다른 구성보다 높은 우선순위를 가집니다.

***

### 1.6 구성 우선순위 (Configuration priority order)

아래 표는 구성 항목별 우선순위(Priority)를 정리한 것입니다.

| Configuration | Priority                 |
| ------------- | ------------------------ |
| MCP servers   | Agent > Project > Global |
| Prompts       | Project > Global         |
| Custom agents | Project > Global         |
| Steering      | Project > Global         |

***

### 1.7 MCP 서버 구성의 특수 처리

MCP 서버(Model Context Protocol servers)는 전역(Global), 프로젝트(Project), 에이전트(Agent) 총 세 가지 범위에서 모두 정의할 수 있기 때문에, 다른 구성 항목과는 약간 다른 방식으로 처리됩니다.

특히, 에이전트 구성 파일에는 includeMcpJson 설정이 존재하여:

* 에이전트 자체에 정의된 MCP 서버
* 전역 및 프로젝트 MCP 설정 파일

을 함께 포함하거나 제외할 수 있습니다.

이에 따른 상세 동작 방식은 MCP server loading priority 문서를 참조해야 합니다.

***

#### 요약 정리

1. Kiro CLI 구성은 Global / Project / Agent 세 가지 범위에서 정의된다.
2. 구성 충돌 시, 현재 작업 위치와 가장 가까운 범위가 우선 적용된다.
3. 동일 범위 내 충돌이 발생하면 에이전트 구성이 최우선이다.
4. MCP 서버 구성은 includeMcpJson 설정으로 인해 별도의 로딩 우선순위를 가진다.
