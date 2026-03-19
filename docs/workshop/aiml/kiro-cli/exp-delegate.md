---
title: "Delegate"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 39
last_modified_date: "2026-03-19"
---

# Delegate
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Delegate 기능은 비동기 백그라운드 태스크를 생성하고 관리하여, 메인 대화와는 독립적으로 병렬 Kiro 세션을 실행할 수 있도록 해주는 실험적 기능입니다.

이 기능을 사용하면 장시간 수행되는 분석 작업, 테스트 실행, 모니터링 등의 작업을 대화의 흐름을 방해하지 않고 처리할 수 있습니다.

***

## 1. Delegate 활성화

Delegate 기능 활성화:

```
kiro-cli settings chat.enableDelegate true
```

또는 실험 기능 메뉴에서:

```
/experiment
# "Delegate" 선택
```

***

## 2. 개요

Delegate 기능은 다음을 제공합니다:

* 자연어 기반 태스크 생성
* 다중 Kiro 에이전트 병렬 실행
* 백그라운드 태스크 상태 모니터링
* 메인 대화를 유지하면서 장시간 작업 수행

즉, 복잡하거나 장시간 실행되는 작업을 Kiro에게 위임(delegate)하고, 사용자는 주 흐름에 집중할 수 있습니다.

***

## 3. 동작 방식

### 3.1 Task 생성

자연어로 태스크를 요청합니다:

```
> Can you create a background task to analyze the performance of our API endpoints?
```

Kiro는 다음을 수행합니다:

1. 요청 분석
2. 필요 시 적합한 에이전트 선택
3. 에이전트 승인 요청
4. 백그라운드 태스크 시작
5. 메인 대화로 제어 반환

***

### 3.2 Agent Approval Flow

#### 에이전트를 사용하는 태스크

* 실행 전 반드시 사용자 승인 필요
* 에이전트 이름, 권한, 접근 리소스 등을 표시
* 사용자는 승인(y) 또는 거부(n)

####  에이전트 없이 실행되는 태스크

* trust-all 권한으로 실행될 수 있다는 경고 표시
* 시스템에 더 많은 접근 권한이 있을 수 있으므로 주의 필요

***

### 3.3 Task 관리

생성된 태스크는 다음이 가능합니다:

* 상태 조회
* 진행률 확인
* 결과 조회
* 불필요해진 태스크 삭제

태스크는 메인 대화와 독립적으로 동작합니다.

***

## 4. 사용 사례

### Example 1: API 성능 분석 태스크

```
> API 엔드포인트(API endpoints)의 성능을 분석하기 위한 백그라운드 작업(background task)을 생성해줄 수 있나요?
```

예시 응답:

```
I'll create a background task to analyze your API performance.

Agent: performance-analyzer
Tools: read, shell, aws
Resources: api-docs, performance-metrics

Approve this agent? (y/n): y

✓ Task created: api-performance-analysis
  Task ID: task-abc123
  Status: Running
```

메인 대화 유지:

```
> 이제 프런트엔드(frontend) 코드도 도와줘…
```

상태 확인:

```
> Check the status of my API analysis task

Task: api-performance-analysis (task-abc123)
Status: Complete
Duration: 2m 34s

Results:
- Analyzed 15 API endpoints
- Found 3 performance bottlenecks
- Generated optimization recommendations
```

***

### Example 2: 테스트 실행

```
> 새 기능(new feature)을 작업하는 동안, 테스트 스위트(test suite)를 백그라운드(background)에서 실행해줘
```

이후:

```
> 테스트 스위트(test suite) 진행 상태가 어떻습니까?

Status: Running (45% complete)
Progress: 127/283 tests passed
```

***

### Example 3: 문서 생성

```
> API 문서(API documentation)를 백그라운드(background)에서 생성해줘.
```

완료 후:

```
Generated documentation for:
- 23 API endpoints
- 15 data models
- 8 authentication methods

Saved to: docs/api/
```

***

## 5. Task Lifecycle

#### 1. Task Creation

요청 분석 → 에이전트 선택 → 승인 요청

#### 2. Approval

에이전트 사용 시 사용자 승인 필수

#### 3. Execution

백그라운드 실행, 메인 대화 병행 가능

#### 4. Monitoring

언제든지 상태 조회 가능:

* “Check on my task”
* “How is the background task doing?”
* “Show progress”

#### 5. Completion

결과를 요청해서 확인 가능

#### 6. Cleanup

필요 없다면 삭제 가능

***

## 6. 모범사례

### 6.1 Delegate 권장 사항

* 장시간 수행되는 작업
* 테스트 실행, 분석 작업
* 문서 생성
* 병렬로 진행 가능한 작업
* 지속 모니터링이 필요한 작업

### 6.2 Deleage 가 필요없는 경우

* 즉각적 결과가 필요한 작업
* 사용자 입력이 필요한 작업
* 메인 대화와 강하게 연결된 작업

### 6.3 Task Management Tips

* 명확한 태스크 이름 사용
* 주기적으로 상태 확인
* 완료된 태스크는 정리
* 동시에 너무 많은 태스크 실행 금지

***

## 7. Security 고려사항

### 7.1 Agent Approval

항상 다음을 확인하세요:

* 사용 가능한 Tools
* 접근 가능한 리소스
* 권한 범위

### 7.2 Agent-Free Tasks

trust-all 모드로 동작할 수 있으므로:

* 민감 작업에는 에이전트 사용 권장
* 최소 권한 원칙 적용

### 7.3 모범사례

* 세분화된 권한을 갖는 Custom Agent 생성
* 태스크 활동 주기적으로 모니터링
* 민감한 결과는 완료 후 삭제

***

## 8. 제약사항

* 동시 태스크 개수 제한
* 시스템 리소스에 영향 가능
* 태스크는 세션 범위 내에서만 존재
* 태스크와 메인 대화는 완전 분리
* 결과는 명시적으로 요청해야 확인 가능

***

## 9. 트러블슈팅

#### 태스크가 시작되지 않음

확인:

```
kiro-cli settings chat.enableDelegate
```

#### 상태 조회 불가

* Task ID 확인
* 태스크가 종료되어 자동 정리되었을 수 있음
* Kiro에게 “list all background tasks” 요청

#### Agent Approval 문제

* 에이전트 구성 확인
* 동일 작업을 에이전트 없이 요청해보기

***

## 10. 고급 활용 사례

### 10.1 Delegated Tasks 를 위한 Custom Agents

예시: test-suite용 경량 에이전트

```
{
  "name": "test-runner",
  "description": "Runs test suites in background",
  "tools": ["shell", "read"],
  "allowedTools": ["shell"],
  "toolsSettings": {
    "shell": {
      "allowedCommands": ["npm test", "pytest", "cargo test"]
    }
  }
}
```

### 10.2 공통 Task Patterns

#### 분석 태스크

* Code quality analysis
* Security scan
* Performance report generation

#### 빌드 태스크

* Build project
* Compile & test
* Bundle for production

#### 모니터링 태스크

* Log file watch
* File change tracking
* Resource usage monitoring
