---
title: "커스텀 에이전트 생성"
parent: Kiro CLI Workshop
nav_order: 21
last_modified_date: "2026-03-19"
---

# 커스텀 에이전트 생성
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

커스텀 에이전트(Custom Agents)는 특정 작업(Task)에 맞게 Kiro CLI의 동작 방식을 세밀하게 조정할 수 있도록 해주는 기능입니다. 이를 통해 다음을 정의할 수 있습니다:

* 사용 가능한 도구(Tools)
* 사전 부여할 권한(Permissions)
* 자동으로 포함될 컨텍스트(Context)
* 특정 모델(Model) 또는 프롬프트(Prompt) 구성

***

## 1. 빠른 시작

커스텀 에이전트는 Kiro CLI 채팅 세션 내 slash command 를 사용하여 빠르게 생성할 수 있습니다:

```
> /agent generate
```

실행하면 아래와 같은 단계별 설정 안내가 나타납니다:

```
✔ Enter agent name:  · backend-specialist
✔ Enter agent description:  · You are specialist in backend coding practices 
✔ Agent scope · Local (current workspace)

Select MCP servers (use Space to toggle, Enter to confirm):
  markdown-downloader (node)
  code-analysis (uv)

✓ Agent 'backend-specialist' has been created and saved successfully!
```

또는 CLI 명령어를 사용하여 생성할 수도 있습니다:

```
kiro-cli agent create --name my-agent
```

이 명령은 설정 과정을 안내하며, 생성된 에이전트 구성 파일은 다음 위치에 저장됩니다:

```
~/.kiro/agents/my-agent.json
```

***

## 2. 에이전트 구성 파일

커스텀 에이전트는 JSON 기반의 설정 파일로 정의됩니다.

아래는 기본적인 예시입니다:

```
{
  "name": "my-agent",
  "description": "A custom agent for my workflow",
  "tools": ["read", "write"],
  "allowedTools": ["read"],
  "resources": ["file://README.md", "file://.kiro/steering/**/*.md"],
  "prompt": "You are a helpful coding assistant",
  "model": "claude-sonnet-4"
}
```

#### 주요 필드 설명

| 필드           | 설명                     |
| ------------ | ---------------------- |
| name         | 에이전트 이름                |
| description  | 에이전트 목적 및 역할 설명        |
| tools        | 사용 가능한 도구 목록           |
| allowedTools | 사용자 승인 없이 자동 실행되는 도구   |
| resources    | 에이전트가 자동으로 로드할 컨텍스트 파일 |
| prompt       | 에이전트의 기본 시스템 프롬프트 설정   |
| model        | 사용할 LLM 모델 지정          |

***

## 3.커스텀 에이전트 사용하기

### 3.1. 새 채팅 세션에서 에이전트 전환하기

기본적으로 새 세션은 kiro\_default 에이전트로 시작됩니다.

아래 명령으로 에이전트를 교체할 수 있습니다:

```
> /agent swap
```

에이전트 선택 화면이 나타납니다:

```
Choose one of the following agents
❯ rust-developer-agent
  kiro_default
  backend-specialist
```

에이전트를 선택하면 다음과 같이 프롬프트가 변경됩니다:

```
✔ Choose one of the following agents · backend-specialist

[backend-specialist] >
```

***

### 3.2. 시작 시 특정 에이전트 지정하기

새로운 CLI 세션을 특정 에이전트로 바로 실행할 수도 있습니다:

```
kiro-cli --agent my-agent
```

이 경우 해당 에이전트 설정이 즉시 적용된 상태로 대화가 시작됩니다.
