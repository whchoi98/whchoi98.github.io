---
title: "SubAgent"
parent: Workshop
nav_order: 10
last_modified_date: "2026-03-19"
---

# SubAgent
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Subagents

### 1.1 개요(Overview)

Subagent(서브에이전트)는 사용자를 대신하여 복잡한 작업을 자율적으로 수행(Autonomous execution) 할 수 있도록 설계된 전문화된 에이전트(Specialized agents) 입니다.

각 Subagent는 독립적인 컨텍스트(Context), 도구 접근 권한(Tool access), 의사결정 능력(Decision-making capabilities) 을 보유하며, 다단계 작업에 특히 적합합니다.

***

### 1.2 핵심 기능(Key capabilities)

#### 1.2.1 자율 실행(Autonomous execution)

Subagent는 자체 컨텍스트를 기반으로 독립적으로 작업을 수행합니다.

자율성의 수준은 에이전트 구성(Agent configuration) 에 따라 달라집니다.

#### 1.2.2 실시간 진행 상황 추적(Live progress tracking)

작업이 진행되는 동안 Subagent의 현재 상태를 실시간으로 모니터링 할 수 있습니다.

#### 1.2.3 핵심 도구 접근(Core tool access)

Subagent는 다음과 같은 핵심 도구에 접근할 수 있습니다.

* 파일 읽기(Read)
* 명령 실행(Execute commands)
* 파일 생성 및 수정(Write files)
* MCP 도구(Model Context Protocol tools) 사용

#### 1.2.4 병렬 실행(Parallel execution)

여러 Subagent를 동시에 실행 하여 작업을 병렬로 처리함으로써 효율적인 실행이 가능합니다.

#### 1.2.5 결과 집계(Result aggregation)

작업이 완료되면 결과는 자동으로 메인 에이전트(Main agent) 에 반환됩니다.

***

### 1.3 기본 Subagent(Default subagent)

Kiro에는 범용 작업을 처리할 수 있는 기본 Subagent(Default subagent) 가 포함되어 있습니다.

작업을 Subagent에 할당할 때, 별도의 에이전트 구성을 명시하지 않으면 기본 Subagent가 사용됩니다.

***

### 1.4 커스텀 Subagent(Custom subagents)

사용자는 자신이 정의한 커스텀 에이전트(Custom agent) 구성을 Subagent로 사용할 수 있습니다. 이를 통해 특정 워크플로에 최적화된 Subagent를 생성할 수 있습니다.

예시:

```
> 결제 모듈을 리팩터링하기 위해 백엔드 에이전트를 사용하세요.
```

작업 할당 시 에이전트 이름을 명시하면, 해당 에이전트 구성에 정의된 도구 접근 권한 및 설정(Settings) 을 상속한 Subagent가 생성됩니다.

***

### 1.5 Subagent 동작 방식(How subagents work)

#### 1.5.1 작업 할당(Task assignment)

사용자가 작업을 설명하면, Kiro는 해당 작업에 Subagent 사용이 적합한지 판단합니다.

#### 1.5.2 Subagent 초기화(Subagent initialization)

Subagent는 자신의 컨텍스트(Context) 와 도구 접근 권한(Tool access) 을 포함하여 초기화됩니다.

이때 적용되는 설정은 해당 에이전트 구성에 따릅니다.

#### 1.5.3 자율 실행(Autonomous execution)

Subagent는 작업을 독립적으로 수행합니다.

일부 도구 사용 시에는 사용자 승인(User approval)을 요청할 수 있습니다.

#### 1.5.4 진행 상황 업데이트(Progress updates)

작업 중간중간 현재 수행 중인 작업 내용 이 실시간으로 사용자에게 전달됩니다.

#### 1.5.5 결과 반환(Result return)

작업이 완료되면 결과가 메인 에이전트로 반환됩니다.

***

### 1.6 도구 가용성(Tool availability)

Subagent는 별도의 런타임 환경(Separate runtime environment) 에서 실행됩니다.

따라서 일반 채팅 환경에서 사용 가능한 일부 도구는 Subagent에서 아직 지원되지 않습니다.

#### 1.6.1 사용 가능한 도구(Available tools)

* read – 파일 및 디렉터리 읽기
* write – 파일 생성 및 편집
* shell – Bash 명령 실행
* MCP 도구(Model Context Protocol tools)

#### 1.6.2 사용 불가 도구(Not available)

* web\_search – 웹 검색
* web\_fetch – URL 콘텐츠 가져오기
* introspect – CLI 정보 조회
* thinking – 추론 도구
* todo\_list – 작업 목록 관리
* use\_aws – AWS 명령
* grep – 파일 내용 검색
* glob – 패턴 기반 파일 검색

***

### 1.7 에이전트 구성(Agent configuration)

커스텀 에이전트 구성에 Subagent에서 지원되지 않는 도구가 포함되어 있더라도,

해당 도구만 비활성화된 상태로 제외 되고, Subagent 자체는 사용 가능한 도구 범위 내에서 정상적으로 동작합니다.

***

### 1.8 모범 사례

* 복잡한 작업에 활용 : 컨텍스트 격리가 필요한 다단계 작업에 특히 효과적입니다.
* 명확한 지시 제공 : 구체적이고 명확한 작업 설명이 결과 품질을 크게 향상시킵니다.
* 진행 상황 모니터링 : 장시간 실행되는 Subagent는 주기적으로 상태를 확인하는 것이 바람직합니다.
* 결과 검토 필수 : Subagent의 결과는 실제 적용 전에 반드시 검토해야 합니다.

***

### 1.9 문제 해결(Troubleshooting)

<table data-header-hidden><thead><tr><th width="228.96484375"></th><th></th></tr></thead><tbody><tr><td>Issue</td><td>Solution</td></tr><tr><td>Subagent가 시작되지 않음</td><td>작업 설명이 명확하고 실행 가능한지 확인</td></tr><tr><td>필요한 도구 접근 불가</td><td>해당 도구가 Subagent 런타임에서 지원되는지 확인</td></tr><tr><td>결과가 불완전함</td><td>지시를 더 구체화하거나 작업을 더 작은 단위로 분리</td></tr></tbody></table>
