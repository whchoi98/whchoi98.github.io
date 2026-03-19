---
title: "메시지에 응답하기(Responding)"
parent: Kiro CLI Workshop
nav_order: 14
last_modified_date: "2026-03-19"
---

# 메시지에 응답하기
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. 개요

Kiro CLI는 /reply 명령어를 통해 Kiro가 이전에 생성한 메시지의 특정 부분에 직접적으로 응답할 수 있는 기능을 제공합니다. 이 명령어는 최근 Assistant 메시지를 자동으로 가져와 각 줄 앞에 `>` 인용 접두어를 붙여 편집기에 로드하며, 사용자는 해당 인용문 사이에 답변을 추가하거나 아래에 구조화된 피드백을 작성할 수 있습니다.

시스템 기본 에디터가 사용되며, 설정된 에디터가 없을 경우 자동으로 `vi` 가 사용됩니다.

***

## 2. 동작 방식

1. Retrieves last response - 대화 내 가장 최근의 Assistant 메시지를 자동 탐색 및 로드합니다.
2. Formats with quotes - 메시지의 모든 줄 앞에 `>`가 붙어 명확하게 구분된 인용 구조로 변환합니다.
3. Opens editor - 시스템 기본 에디터가 열리며 인용된 콘텐츠가 미리 채워져 있습니다.
4. Edit and respond - 인용문 아래 또는 중간에 자유롭게 응답을 작성합니다.
5. Submit - 에디터를 저장 후 종료하면 해당 응답이 자동으로 제출됩니다.

***

## 3. 에디터 동작 방식

* Pre-populated content (사전 채워진 콘텐츠) - 에디터는 Assistant 응답이 `>` 인용 형식으로 이미 포함된 상태로 시작합니다.
* Quote format (인용 형식) - 각 줄에 `>`가 자동으로 추가되어 원문과 사용자의 응답을 명확히 구분할 수 있습니다.
* Flexible editing (유연한 편집) - 인용문 아래, 사이, 혹은 중첩하듯 삽입하는 등 자유로운 위치에 응답 가능.
* Auto-submission (자동 제출) - 에디터가 정상적으로 종료되면 그 내용이 즉시 메시지로 제출됩니다.

***

## 4. 활용 사례

### 4.1. 여러 질문에 개별적으로 응답

Kiro가 여러 개의 확인 질문을 한 경우:

```
> 어떤 프로그래밍 언어(programming language)를 사용하고 있습니까?
Python

> 어떤 프레임워크(framework)로 작업하고 있습니까?
Django

> 어떤 구체적인 에러(error)를 겪고 있습니까?
I'm getting a 404 error when trying to access my API endpoints.
```

### 4.2. 특정 항목에 대한 대응

Kiro가 여러 접근 방식을 제시했을 때:

```
> 다음은 사용할 수 있는 세 가지 접근 방식(approaches)입니다:
> 1. 데이터베이스 마이그레이션(database migration)을 사용
> 2. 모델(model)을 직접 업데이트
> 3. 커스텀 매니지먼트 커맨드(custom management command)를 생성

저는 1번 옵션을 선택하고 싶습니다. 마이그레이션(migration)을 생성하는 방법을 보여줄 수 있나요?

> 데이터를 먼저 백업(backup)하는 것을 잊지 마세요.
Already done - I have a full backup from this morning.
```

### 4.3. 구조화된 피드백 제공

Kiro가 다수의 개선점을 제안했을 때:

```
> 다음 개선 사항(improvements)을 권장합니다:
> - 네트워크 요청(network requests)에 대한 에러 핸들링(error handling) 추가
> - 입력 검증(input validation) 구현
> - 디버깅(debugging)을 위한 로깅(logging) 추가

Agreed on all points. For the error handling:
- try/catch 블록을 사용해야 할까요, 아니면 데코레이터 패턴(decorator pattern)을 사용해야 할까요?

For logging:
- 어느 정도 수준의 상세도(level of detail)를 추천하나요?
```

***

## 5. 상태 메시지

`/reply` 명령 실행 시 다음과 같은 상태 메시지가 표시됩니다:

* Success : “에디터(editor)에서 콘텐츠가 로드되었습니다. 프롬프트(prompt)를 제출합니다…”
* No changes : “에디터(editor)에서 변경 사항이 없어 제출하지 않습니다.”
* No message : “응답할 어시스턴트 메시지(assistant message)를 찾을 수 없습니다.”
* Editor error : "에디터 열기 오류: \[specific error details]"

***

## 6. 오류 처리

* No assistant message : 응답할 Assistant 메시지가 없으면 경고 메시지 표시
* Editor failures : 에디터 실행 실패 시 시스템 오류 메시지 포함 상세 안내 제공
* Empty content : 변경 사항이 없으면 요청을 제출하지 않음
* Unchanged content : 원본 인용문과 동일한 경우 제출을 방지하여 불필요한 메시지 생성 방지

***

## 7. 모범 사례

* Kiro의 응답이 여러 개의 항목으로 구성된 경우, /reply를 활용해 구조적으로 응답
* 인용문 사이에 명확하고 개별적인 답변을 작성
* 모든 인용문에 응답할 필요는 없음 — 필요한 부분만 선택
* 긴 대화에서 문맥 유지를 위해 인용 구조 활용
* 복잡한 주제는 인용문을 기준으로 소주제로 나누어 응답 작성

***

## 8. Tips 

* 응답이 필요 없는 인용 라인은 자유롭게 삭제 가능
* 가독성을 높이려면 응답 사이에 빈 줄 추가
* 인용 구조를 활용하여 긴 메시지를 작은 단위로 분리
* 특히 Kiro의 최근 메시지가 길거나 복잡할 때 /reply 기능이 가장 효과적
