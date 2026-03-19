---
title: "TODO Lists"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 37
last_modified_date: "2026-03-19"
---

# TODO Lists
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Kiro CLI의 TODO List 기능은 복잡한 작업을 자동으로 구조화하고, 단계별 진행 상황을 추적하며, 사용자가 여러 세션에 걸쳐 동일한 작업을 지속할 수 있도록 지원합니다.

Kiro는 필요한 경우 TODO 리스트를 스스로 생성하고, 사용자는 /todo 명령을 통해 관리할 수 있습니다.

***

## 1. TODO List 기능 활성화

TODO 리스트 기능은 실험적 기능이므로 먼저 활성화해야 합니다.

```
kiro-cli settings chat.enableTodoList true
```

활성화 이후, Kiro는 복잡한 요청이나 다단계 작업 분해가 필요한 상황에서 자동으로 TODO 리스트를 생성합니다.

***

## 2. 동작 방식

### 2.1 Automatic TODO 생성

Kiro는 다음과 같은 상황에서 자동으로 TODO 리스트를 생성합니다:

* 사용자가 다단계 작업을 요청한 경우
* 큰 문제를 작은 단계로 분해해야 할 때
* 사용자가 “TODO 리스트를 만들어 달라”고 명시적으로 요청한 경우

예시:

```
> Make a todo list with 3 read-only tasks.
```

Kiro는 즉시 리스트를 생성하고 도구를 사용하여 결과를 출력합니다.

***

### 2.2 작업 관리

Kiro는 다음 작업을 수행할 수 있습니다:

* TODO 리스트 생성
* Task 추가 및 삭제
* Task 완료 처리
* Task 목록 조회
* 특정 TODO 리스트 로드

사용자는 /todo 명령을 통해:

* 리스트 조회
* 리스트 재개(resume)
* 완료된 리스트 삭제
* 특정 리스트 제거

를 수행할 수 있습니다.

***

## 3. Commands

### 3.1. /todo view

저장된 TODO 리스트 목록을 표시합니다.

```
/todo view
```

인터페이스는 다음과 같이 상태를 표시합니다:

*  완료된 리스트 (green)
* 미완료 리스트 (red, 진행도 표시)

예시:

```
? Select a to-do list to view:
❯ ✗ Unfinished todo list (0/3)
  ✔ Completed todo list (3/3)
```

***

### 3.2. `/todo resume`

선택한 TODO 리스트를 현재 세션에 불러와 Kiro가 작업을 이어갈 수 있도록 합니다.

```
/todo resume
```

예시:

```
⟳ Resuming: Read-only tasks for information gathering

🛠️ Using tool: todo
 ● TODO:
[x] Review project documentation
[ ] Check system status
[ ] Read latest updates
```

***

### 3.3. `/todo clear-finished`

완료된 TODO 리스트를 모두 제거합니다.

```
/todo clear-finished
```

***

### 3.4. `/todo delete`

특정 TODO 리스트 또는 모든 TODO 리스트를 삭제합니다.

```
/todo delete         # 선택 후 삭제
/todo delete --all   # 모든 TODO 리스트 삭제
```

옵션:

<table data-header-hidden><thead><tr><th width="171.84375"></th><th></th></tr></thead><tbody><tr><td>옵션</td><td>설명</td></tr><tr><td>--all</td><td>모든 TODO 리스트를 즉시 삭제 (비대화형)</td></tr></tbody></table>

***

## 4. Storage 구조

TODO 리스트는 프로젝트별로 지속 저장되며 세션이 종료되어도 유지됩니다.

저장 구조:

```
my-project/
└── .kiro/
    └── cli-todo-lists/
        ├── 1234567890-task-list.json
        └── 1234567891-another-list.json
```

각 리스트 파일에는:

* 고유 ID
* Task 목록 및 상태
* 리스트 설명
* 관련 파일 수정 경로
* 컨텍스트 업데이트 정보

가 포함됩니다.

***

## 5. 사용 사례

### 5.1 복잡한 작업 분해

예:

```
I need to migrate our database from MySQL to PostgreSQL
```

Kiro는 자동으로 TODO 리스트를 생성하여 마이그레이션 단계를 정리합니다.

***

### 5.2 다단계 구현 진행

```
Help me implement user authentication
```

Kiro는 인증 시스템 구현을 위한 단계별 TODO를 생성합니다.

***

### 5.3 이전 작업 재개

```
/todo resume
```

중단했던 TODO 리스트를 선택하여 다시 이어갈 수 있습니다.

***

## 6. 모범사례

### 6.1 리스트 관리

* 완료된 리스트는 정기적으로 clear-finished로 정리
* 리스트는 반드시 /todo resume 후 사용
* 복잡한 작업의 경우 Kiro가 자동 생성하는 리스트를 활용

### 6.2 워크플로우 최적화

* 큰 작업을 작은 단계로 관리
* 멀티 세션 환경에서 작업 지속성 확보
* 프로젝트 폴더 내에서 TODO 리스트를 관리하면 맥락 유지에 유리

### 6.3 조직적 사용

* 명확한 리스트 제목 사용
* 과거 프로젝트의 오래된 리스트는 삭제
* 순서대로 작업하여 문맥 혼동 방지

***

## 7. 제약사항

현재 TODO 리스트 기능에는 다음 제약이 있습니다:

* JSON 파일을 수동 편집 불가
* TODO 리스트 병합/분할 불가
* 생성된 Task의 순서 변경 불가
* Kiro가 표시해주는 리스트 컨텍스트 내에서만 작업 가능

***

## 8. Troubleshooting

### 문제: Task가 업데이트되지 않음

해결:

1. 리스트를 먼저 /todo resume 되어 있는지 확인
2. JSON 파일을 수동으로 수정하지 않았는지 확인
3. 오류 메시지가 출력되지 않았는지 확인

***

### 문제: 기능이 동작하지 않음

* TODO 리스트 기능 활성화 여부 확인

```
kiro-cli settings chat.enableTodoList true
```

***

## 9. Tool vs Command 구분

<table data-header-hidden><thead><tr><th width="160.3359375"></th><th width="395.88671875"></th><th></th></tr></thead><tbody><tr><td>구분</td><td>목적</td><td>사용 주체</td></tr><tr><td>todo tool</td><td>Kiro가 TODO 리스트를 생성·수정·완료 시 자동 실행</td><td>Kiro</td></tr><tr><td>/todo command</td><td>사용자 측 리스트 조회·관리·삭제</td><td>사용자</td></tr></tbody></table>

***

## 10. Workflow 예제

1. 복잡한 작업 요청
2. Kiro가 자동 TODO 생성
3. 작업 진행
4. 다음 세션에서 /todo resume
5. 완료 후 /todo clear-finished로 정리
