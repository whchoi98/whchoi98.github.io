---
title: "Planning Agent"
parent: Kiro CLI Workshop
nav_order: 11
last_modified_date: "2026-03-19"
---

# Planning Agent
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Plan 에이전트(Plan Agent) x1. 개요(Overview)

Plan 에이전트(Plan Agent)는 아이디어를 구조화된 구현 계획(structured implementation plan)으로 변환하는 데 특화된 내장 전문 에이전트(built-in specialized agent)입니다.

요구사항 수집(requirements gathering), 사전 조사(research), 작업 분해(task breakdown)를 체계적으로 지원하며, 실제 구현(execution) 단계로 전환하기 전에 명확하고 실행 가능한 계획을 수립하도록 안내합니다.

***

### 2. 시작하기(Getting Started)

#### 2.1 키보드 단축키(Keyboard Shortcut)

* `Shift + Tab` 키를 눌러 계획 모드(plan mode)와 실행 모드(execution mode)를 전환할 수 있습니다.

#### 2.2 슬래시 명령어(Slash Command)

```
> /plan
```

실행 시 다음과 같이 Plan 에이전트로 전환됩니다.

```
Switched to the Kiro [plan] agent. Transform any idea into fully working code.
What do you want to build today?

[plan] >
```

#### 2.3 즉시 프롬프트와 함께 실행(With Immediate Prompt)

```
> /plan Build a REST API for user authentication
```

활성화되면 다음과 같은 표시가 나타납니다.

* 프롬프트에 \[plan] 표시자
* 모드 전환 시 환영 메시지

***

### 3. 계획 워크플로우(Plan Workflow)

#### 3.1 요구사항 수집(Requirements Gathering)

Plan 에이전트는 초기 아이디어를 구체화하기 위해 구조화된 질문(structured questions)을 단계적으로 제시합니다.

```
[plan] > 할 일(todo) 관리 애플리케이션을 만들고 싶습니다.
```

```
할 일(todo) 애플리케이션을 구축하려는 의도를 이해했습니다. 구현 계획 수립을 지원하겠습니다.
```

이해한 내용(My Understanding): 작업 관리를 위한 할 일(todo) 애플리케이션을 만들고자 합니다.

이후 다음과 같은 질문이 이어집니다.

```
[1]: 이 todo 앱은 어떤 플랫폼을 대상으로 하나요?
a. Web Application – 브라우저 기반
b. Mobile App – iOS/Android 또는 크로스플랫폼
c. Desktop App – Electron, Tauri 등
d. CLI Tool – 커맨드라인 인터페이스
e. Other – 직접 입력
```

```
[2]: 이 앱의 주요 사용 목적은 무엇인가요?
a. 개인 작업 관리
b. 팀 협업
c. 프로젝트 관리
d. 기타
```

**기능 요약 표**

| Feature              | Description            |
| -------------------- | ---------------------- |
| Structured questions | 명확한 번호 체계와 객관식 기반 질문   |
| Flexible responses   | 일부 질문만 답변하거나 자유 서술 가능  |
| Iterative process    | 여러 라운드를 통해 점진적으로 이해 확장 |
| Context awareness    | 응답에 따라 후속 질문이 동적으로 변화  |

***

#### 3.2 조사 및 분석(Research and Analysis)

Plan 에이전트는 코드베이스와 기술 환경을 탐색합니다.

| Capability            | Description                    |
| --------------------- | ------------------------------ |
| Code exploration      | code, grep, glob 도구를 활용한 코드 분석 |
| Technology research   | 관련 프레임워크, 라이브러리, 패턴 조사         |
| Architecture analysis | 기존 프로젝트 구조 및 관례 분석             |

***

#### 3.3 구현 계획 수립(Implementation Plan)

명확한 목표와 데모 기준을 포함한 단계별 구현 계획(step-by-step plan)을 생성합니다.

```
Implementation Plan – Todo CLI Command
```

문제 정의(Problem Statement): 기존 Kiro CLI에 작업 관리 기능을 추가한다.

요구사항(Requirements):

* CRUD CLI 명령어
* 로컬 SQLite 저장소
* 우선순위 및 마감일 지원



작업 분해(Task Breakdown):



Task 1. 데이터베이스 스키마 및 모델 생성

* Todo 구조체 정의
* 마이그레이션 작성
* 데모: DB에 todo 생성 및 조회 가능



Task 2. CLI 명령 구조 구현

* add / list / complete 서브커맨드 추가
* 데모: CLI 도움말 및 명령 인식



Task 3. 고급 기능 추가

* 마감일 및 우선순위 정렬
* 데모: 전체 기능 동작 확인<br>

각 작업에는 다음 요소가 포함됩니다.

* 명확한 목표(Clear objectives)
* 구현 가이드(Implementation guidance)
* 데모 기준(Demo description)

***

#### 3.4 계획 승인 및 실행 인계(Plan Approval and Handoff)

구현 단계로 전환하기 전에 사용자 승인을 요청합니다.

```
Does this plan look good, or would you like me to adjust anything?
이 계획이 적절한지 검토해 주시겠습니까, 또는 수정이 필요한 사항이 있을까요?
```

```
Ready to exit [plan] agent to start your implementation? [y/n]
```

**인계 절차 요약**

1. 사용자가 계획 승인
2. 실행 모드 전환 확인
3. 이전 에이전트로 자동 복귀
4. 계획 내용이 실행 에이전트로 전달

***

### 4. 읽기 전용 설계(Read-only Design)<br>

Plan 에이전트는 계획에 집중하기 위해 읽기 전용(read-only)으로 동작합니다.

| Operation                        | Status |
| -------------------------------- | ------ |
| 파일 읽기(File reading)              | ✓      |
| 코드 인텔리전스(Code intelligence, LSP) | ✓      |
| 검색(grep, glob)                   | ✓      |
| 웹 검색(Web search)                 | ✓      |
| 파일 쓰기(File writing)              | ✗      |
| 명령 실행(Command execution)         | ✗      |
| MCP 도구(MCP tools)                | ✗      |

***

### 5. 모범 사례(Best Practices)

* 복잡한 작업에 사용: 다단계 구현에 최적
* 질문에 적극 응답: 계획 품질 향상
* 탐색 허용: 코드베이스 분석을 제한하지 않기
* 계획 검토 필수: 실행 전 기대사항 일치 확인
* 반복 개선: 필요 시 여러 차례 수정

***

### 6. 문제 해결(Troubleshooting)

| Issue           | Solution       |
| --------------- | -------------- |
| Plan 에이전트 종료 방법 | Shift + Tab 사용 |
| 계획 세션 중단        | /plan으로 재진입    |
| 실행 단계로 전환되지 않음  | 승인 질문에 y 입력 확인 |

***

### 7. 예시 워크플로우(Example Workflow)

```
> /plan Add user authentication to my web app
```

```
[1]: 인증 방식은 무엇을 선호하나요?
a. Email/Password
b. OAuth
c. Magic Links
d. Multi-factor
```

```
[2]: 현재 기술 스택은?
a. React + Node.js
b. Next.js
c. Django/Flask
d. Other
```

```
Rust + Axum 프레임워크
```

이후 Plan 에이전트는 Axum 기반 인증 패턴을 조사하고 상세 구현 계획을 생성합니다.

```
Ready to exit [plan] agent to start your implementation? [y/n]: y
```
