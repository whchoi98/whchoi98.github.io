---
title: "LAB 3. Kiro CLI Part 1"
parent: AIML
grand_parent: Workshop
nav_order: 40
last_modified_date: "2026-03-19"
---

# LAB 03. Kiro CLI Part 1
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

***

## 01. Kiro CLI 탐색

이 실습에서는 Kiro CLI의 에이전트(Agentic) 기능을 본격적으로 탐색합니다.

본 실습은 모든 사전 요구 사항(prerequisites)을 충족하고 Kiro CLI 설치가 완료된 상태를 전제로 진행됩니다.

***

### 1.1 인터랙티브(Agentic) Chat 소개

Kiro CLI를 실행하면 터미널에서 AI와 자연스럽게 대화할 수 있는 대화형(interactive) Chat 모드가 활성화됩니다.

이 기능은 “AI 기반 개발 지원(Agentic Development)” 기능을 터미널로 가져와, 사용자의 워크플로우를 자연어 기반으로 확장할 수 있게 합니다.

또한 Kiro CLI는 영어뿐 아니라 여러 언어를 지원하며, 한국어로도 자연스러운 개발 대화를 수행할 수 있습니다.

***

### Task-01 — Kiro CLI 실행하기

1. 새로운 프로젝트 디렉터리를 생성합니다. 아래 예시는 사용자 홈 디렉터리에서 진행하는 예시이며 원하는 위치에서 생성해도 무방합니다:

```
cd
mkdir kiro-cli-workshop && cd kiro-cli-workshop
kiro-cli
```

2.  Kiro CLI가 실행되면 다음과 같은 “>” 프롬프트가 나타납니다. 이 프롬프트는 현재 대화 상태 또는 도구 신뢰 레벨 등을 시각적으로 알려주는 역할도 합니다.

    예:

    * \> : 기본 상태
    * !> : 모든 도구가 trusted 상태
3. 이제 아래 문장을 입력해 봅니다:

```
들여쓰기할 때 탭과 스페이스 중 어떤 것을 선호하나요?
```

4. 출력 결과를 확인하고, 프롬프트를 다시 관찰합니다.
5. Kiro CLI 종료:
   * /q 입력
   * 또는 Ctrl + C

```
/q
```

6. 이번에는 아래 방식으로 단일 프롬프트 채팅 모드를 실행합니다:

```
kiro-cli chat "들여쓰기할 때 탭과 스페이스 중 어떤 것을 선호하나요?"
```

→ 출력은 다를 수 있으나, 동일한 동작을 수행합니다.

> 다음 실습에서 계속 사용하므로 이 세션을 종료하지 말고 유지하세요.

***

### 1.2 Kiro CLI 내에서 도움말 확인하기

언제든지 /help를 입력하여 Kiro CLI의 모든 명령 및 사용법을 조회할 수 있습니다.

***

### 1.3 Kiro CLI 명령(Command) 구조

Kiro CLI의 명령은 모두 `/` 로 시작합니다.

예시: `/help`, `/reply`, `/editor`, `/model`, `/context show` 등

* `/help` : 모든 명령 목록 보기
* `Ctrl + S` : 명령어 퍼지 검색(Fuzzy Search)
  * 입력하면 명령 목록이 필터링되며
  * 원하는 명령을 선택하거나 ESC로 종료 가능

***

## 02. 멀티라인 프롬프트

지금까지는 단일 줄(single-line) 프롬프트를 입력해 보았습니다.

하지만 실제 개발 작업에서는 여러 줄로 구성된 요구사항, 코드 템플릿, 기술 지침 등을 전달해야 하는 경우가 많습니다.

Kiro CLI는 이러한 상황을 위해 다양한 방식의 멀티라인(Multi-line) 입력 모드를 지원합니다.

멀티라인 입력 방식 1: `Ctrl + J`

Kiro CLI의 Chat 세션에서 Ctrl + J(또는 Ctrl + Enter)를 누르면 프롬프트 내에서 줄바꿈(newline) 이 삽입됩니다.

예:

```
Python 코드를 작성할 때에는 다음의 지침을 따르십시오.
	•	웹 프레임워크(web framework)로 Flask를 사용하십시오.
	•	Flask 애플리케이션 팩토리 패턴(application factory pattern)을 준수하십시오.
	•	구성(configuration)에는 환경 변수(environment variables)를 사용하십시오.
	•	데이터베이스 작업(database operations)을 위해 Flask-SQLAlchemy를 구현하십시오.
```

***

멀티라인 입력 방식 2:  `\` (백슬래시) 사용

명령 줄 끝에 백슬래시 \ 를 입력하면, 다음 줄로 자연스럽게 이어서 작성할 수 있습니다.

예:

```
Python 코드를 작성할 때에는 다음의 지침을 따르십시오. \
	•	웹 프레임워크(web framework)로 Flask를 사용하십시오. \
	•	Flask 애플리케이션 팩토리 패턴(application factory pattern)을 준수하십시오. \
	•	구성(configuration)에는 환경 변수(environment variables)를 사용하십시오. \
	•	데이터베이스 작업(database operations)을 위해 Flask-SQLAlchemy를 구현하십시오.
```

이 방식은 shell 환경에 익숙한 사용자들이 자주 사용하는 패턴입니다.

***

### Task-02 — 두 가지 방식으로 멀티라인 입력해보기

Kiro CLI Chat 세션에서 아래 내용을 두 방식 모두 사용해 입력해 보세요.

입력할 멀티라인 텍스트:

```
Python 코드를 작성할 때에는 다음의 지침을 따르십시오.
	•	웹 프레임워크(web framework)로 Flask를 사용하십시오.
	•	Flask 애플리케이션 팩토리 패턴(application factory pattern)을 준수하십시오.
	•	구성(configuration)에는 환경 변수(environment variables)를 사용하십시오.
	•	데이터베이스 작업(database operations)을 위해 Flask-SQLAlchemy를 구현하십시오.
```

권장 실습:

1. Ctrl + J 방식으로 입력
2. 줄 끝에 \ 추가하는 방식으로 입력

두 방식 모두 동일하게 멀티라인 프롬프트로 처리됩니다.

***

#### 참고: 멀티라인 입력이 필요한 상황

다음과 같은 경우 멀티라인 프롬프트가 특히 유용합니다:

* API 명세서 전체 전달
* SQL 스키마 또는 데이터 모델 정의
* Python/JavaScript 코드 블록 전달
* 긴 요구사항 또는 단계별 지시사항 입력
* 문서 생성 요청 시 구조화된 내용 제공

그러나 멀티라인 프롬프트도 추후 `/editor` 기능을 사용하면 훨씬 편리하게 다룰 수 있습니다.

***

## 03. 선호하는 텍스트 에디터 설정하기

Kiro CLI에서는 복잡한 멀티라인 프롬프트를 더 편리하게 작성하기 위해 외부 텍스트 에디터와 연동할 수 있습니다.

이는 개발자가 이미 익숙한 편집 환경을 그대로 활용할 수 있게 해주며, 긴 지침·코드·설계 문서를 입력해야 할 때 특히 효율적입니다.

***

### 3.1 기본 동작

기본적으로 Kiro CLI는 시스템에서 설정된 기본 에디터(예: vim, nano)를 사용합니다.

그러나 사용자가 원하는 에디터를 직접 지정할 수 있으며, 이를 위해 환경변수 EDITOR 를 설정합니다.

###  3.2 에디터 지정 방법

아래 명령을 터미널에서 실행하면 해당 에디터가 Kiro CLI의 기본 편집기로 사용됩니다.

예시: vim  사용

```
export EDITOR=vim
```

예시: VS Code 사용

```
export EDITOR="code -w"
```

* `-w` 옵션은 파일을 닫을 때까지 CLI가 기다리도록 하는 설정입니다.

예시: nano  사용

```
export EDITOR=nano
```

환경 변수를 설정한 후 Kiro CLI를 실행하면 /editor 명령을 통해 해당 에디터를 사용할 수 있습니다.

***

### 3.3 /editor 명령을 사용한 프롬프트 편집

Kiro CLI 실행 후 `>` 프롬프트에서 아래를 입력하면 설정된 에디터가 열립니다.

```
/editor
```

에디터에서 원하는 멀티라인 프롬프트를 작성하고 저장 후 종료하면, 해당 내용이 Chat 입력으로 처리되며 즉시 응답이 생성됩니다.

***

### Task-03 — 선호하는 에디터 설정 및 사용

1. 현재 Kiro CLI 세션을 종료합니다.
2. 터미널에서 EDITOR 환경변수를 본인이 선호하는 에디터로 설정합니다.

예시:

```
export EDITOR=vi
export EDITOR="code -w"
export EDITOR="nano"
```

3. 다시 Kiro CLI를 실행하고, `>` 프롬프트에서 아래 명령을 입력합니다:

```
/editor
```

4. 에디터가 열리면 아무 멀티라인 텍스트를 작성해 저장·종료합니다.
5. Kiro CLI가 편집된 입력을 받아 프롬프트를 실행하는 것을 확인합니다.

***

### 3.4  왜 에디터 연동이 중요한가?

긴 프롬프트나 구조화된 입력을 자주 사용하는 개발 워크플로우에서 다음과 같은 장점이 있습니다.

* 로컬 편집기에서 문법 강조(syntax highlighting)를 활용 가능
* 복잡한 코드 블록을 안정적으로 작성
* 장문의 기술 지침을 가독성 좋게 편집
* 자연스러운 버전 관리 및 로컬 파일 활용

앞서 살펴본 멀티라인 기능보다 훨씬 강력하고 실전적입니다.

***

## 05. `Reply` 기능 사용하기

Kiro CLI에서 `/reply` 명령은 직전 Assistant 응답을 기반으로 후속 메시지를 작성할 때 매우 유용합니다.

특히 긴 답변을 부분 수정하거나, 특정 내용을 인용해 추가 지시를 내릴 때 큰 효율을 제공합니다.

`/reply` 명령을 실행하면 설정된 텍스트 에디터가 열리며, 그 안에 가장 최근 Assistant 메시지가 자동으로 인용 형태로 포함됩니다.

사용자는 해당 내용을 편집하거나 그 아래에 새로운 지시사항을 덧붙인 뒤 저장·종료하면 됩니다.

###  5.1 Reply 기능 동작 방식

1. Kiro CLI가 직전에 출력한 AI 응답을 감지
2. /reply 실행 시 에디터가 열림
3. 에디터 내부에는 최근 Assistant 메시지가 자동으로 포함됨
4. 사용자는 이를 수정하거나 이어서 작성
5. 저장 후 종료하면 해당 내용이 새로운 사용자 메시지로 전달됨

이는 Slack, GitHub PR 리뷰, 이메일 스레드 등에서 인용(reply) 작성 방식과 유사해 개발자에게 익숙한 경험을 제공합니다.

***

### Task-04 — `Reply` 기능 실습

#### 1. 먼저 Kiro CLI에서 예시 프롬프트를 입력합니다:

```
JSON 날짜(Date) 데이터를 반환하는 코드를 보여줘.
```

#### 2. Assistant의 응답이 출력되면, 다음 명령을 입력합니다:

```
/reply
```

#### 3. 설정된 에디터가 열리며 아래와 같은 형태를 보게 됩니다(예시):

````
> JSON에서 날짜를 반환하는 간단한 예제입니다:
> 
> **JavaScript/Node.js:**
> ```javascript
> const data = {
>   timestamp: new Date().toISOString(),
>   date: new Date().toISOString().split('T')[0]
> };
> 
> console.log(JSON.stringify(data));
> // {"timestamp":"2025-12-07T05:49:34.328Z","date":"2025-12-07"}
> ```
> 
> **Python:**
> ```python
> import json
> from datetime import datetime
> 
> data = {
>     "timestamp": datetime.now().isoformat(),
>     "date": datetime.now().date().isoformat()
> }
> 
> print(json.dumps(data))
> # {"timestamp": "2025-12-07T05:49:34.328000", "date": "2025-12-07"}
> ```
> 
> **Java:**
> ```java
> import com.fasterxml.jackson.databind.ObjectMapper;
> import java.time.LocalDateTime;
> import java.util.Map;
> 
> ObjectMapper mapper = new ObjectMapper();
> Map<String, String> data = Map.of(
>     "timestamp", LocalDateTime.now().toString(),
>     "date", LocalDateTime.now().toLocalDate().toString()
> );
> 
> String json = mapper.writeValueAsString(data);
> ```
> 
> JSON은 네이티브 Date 타입이 없어서 ISO 8601 형식 문자열(`YYYY-MM-DDTHH:mm:ss.sssZ`)을 사용하는 게 표준입니다.
> [Tool uses: none]
````

4\. 원하는 내용을 편집한 후 저장 및 종료합니다.

5\. CLI가 자동으로 편집된 내용을 새로운 메시지로 처리하고 AI가 후속 응답을 제공합니다.

***

### 5.2 /reply  기능의 활용 사례

| 활용 상황                | 설명                                 |
| -------------------- | ---------------------------------- |
| 이전 답변을 일부 수정하고 싶을 때  | 생성된 코드 중 특정 함수만 변경 요청 등            |
| 긴 답변에 추가 지시를 하고 싶을 때 | “여기에 로그 추가해줘”, “이 부분을 async로 변경해줘” |
| 문서·아키텍처 초안 재작성       | 기존 제안에 수정 댓글 다는 방식으로 편하게 작성        |
| 비교·대조 요청             | “이전 코드와 비교해서 더 최적화된 버전으로 만들어줘”     |

***

### 5.3 Reply 기능의 장점

* 긴 컨텍스트를 복사·붙여넣기 할 필요 없음
* 원본 응답이 자동 포함되어 수정 근거가 명확
* 에디터 기반이므로 멀티라인 편집에 최적화
* 이후 커맨드 히스토리 관리가 용이

***

## 06. 이미지 기반 프롬프트 활용하기

Kiro CLI는 이미지를 프롬프트의 일부로 활용할 수 있도록 지원합니다.

이는 아키텍처 다이어그램, ERD(Entity Relationship Diagram), 디자인 시안, UI 스케치 등 비정형 시각 자료에서 정보를 추출해 코드·설계·문서화를 생성할 때 특히 강력합니다.

이미지는 다음 두 방식으로 CLI에 전달할 수 있습니다.

1. 파일 경로를 통한 이미지 참조
2. 클립보드 이미지 붙여넣기(/paste)

***

### 6.1  이미지 파일을 이용한 프롬프트 작성

Kiro CLI에 이미지 파일을 전달할 때는 프로젝트 디렉터리에 존재하는 이미지 파일을 이름으로 지정하면 됩니다.

예시:

```
data-model 디렉터리의 example-erd.png 다이어그램을 기반으로, Python에서 사용할 샘플 데이터 모델(sample data model)을 생성하세요.
```

Kiro CLI는 다음을 수행합니다:

* 이미지 파일 읽기
* 도형, 테이블, 연결 관계 등을 분석
* Python 기반 데이터 모델(예: SQLAlchemy) 생성 또는 설계 초안 반환

이미지를 기반으로 한 구조적 정보 분석은 데이터 모델링, 백엔드 스키마 설계, CI/CD 아키텍처 구축 등 다양한 영역에 활용 가능합니다.

***

### Task-05 — 이미지 파일 기반 프롬프트 실습

1. example-erd.png 파일을 가져오고, 아래 디렉토리를 생성해서 업로드 합니다.

<figure><img src="../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

2. 로컬 프로젝트에서 다음과 같은 디렉토리를 생성합니다.

```
mkdir ~/sample_project
```

3. Kiro CLI를 실행하고 아래 프롬프트를 입력합니다:

```
~/sample_project 디렉토리에 example-erd.png 다이어그램을 기반으로, Python에서 사용할 샘플 데이터 모델(sample data model)을 생성하세요.
```

4.  출력 결과를 검토합니다.

    이미지에서 엔티티, 관계, 속성 등을 추출하여 Python 모델을 자동 생성하는 것을 확인할 수 있습니다.

```
> ERD 다이어그램을 기반으로 ~/sample_project/models.py 파일에 Python 데이터 모델을 생성했습니다.

생성된 모델:
- User: user_id, username, email, created_at
- Product: product_id, name, price, stock  
- Order: order_id, user_id, product_id, quantity, order_date, status

dataclass를 사용해 간결하게 구현했으며, ERD의 관계(User → Order ← Product)를 외래 키(user_id, product_id)로 표현했습니다.
```

***

### 6.2 `/paste`  명령을 활용한 이미지 붙여넣기

CLI 세션에서 이미지 파일 없이도 클립보드에 복사된 이미지 자체를 바로 Kiro CLI로 전달할 수 있습니다.

#### 실습 절차:

1. 로컬 이미지 뷰어에서 원하는 이미지를 열고 “복사(Copy)” 합니다.
2. Kiro CLI 프롬프트에서 다음 명령을 실행합니다:

```
/paste
```

3. CLI는 임시 파일을 생성하고 다음과 같은 메시지를 출력합니다:

```
Reading images: /tmp/.tmpFeCK60.png
(using tool: read)
Allow this action? Use 't' to trust (always allow) this tool for the session. [y/n/t]:
```

4.  이미지 읽기 권한 요청이 나오면 y 또는 t 로 승인합니다.

    이후 Kiro CLI가 이미지의 시각적 요소를 분석하여 작업을 수행합니다.

***

### 6.3 /paste  기능의 활용 사례

| 사례                            | 설명                                |
| ----------------------------- | --------------------------------- |
| ERD·DB 스키마 자동 생성              | 관계형 데이터 모델 설계 자동화                 |
| 아키텍처 다이어그램 → IaC 코드           | AWS CDK, Terraform 등 초기 템플릿 생성 가능 |
| UI 스케치 → HTML/CSS/React 코드 초안 | 프로토타입 구현에 도움                      |
| 화이트보드 사진 → 구조적 문서화            | 회의 메모 정리 자동화                      |

#### 이미지 처리 시 주의사항

* 이미지 해상도가 너무 낮으면 분석 정확도가 떨어질 수 있음
* 복잡한 ERD나 흐름도는 단계별로 나누어 전달하는 것이 더 효과적
* CLI 내에서 이미지 처리를 위해 read Tool 권한이 필요

***

## 07. 대화 종료 및 재개

Kiro CLI는 자연어 기반의 작업 흐름을 중심으로 설계되어 있으며, 사용자가 언제든지 CLI 세션을 종료하고, 다시 돌아와 직전의 작업 문맥을 그대로 재개할 수 있도록 지원합니다.

이는 장시간 진행되는 개발 작업이나 프로젝트 기반 분석을 수행할 때 특히 유용합니다.

***

### 7.1 대화 종료

Kiro CLI에서 대화를 종료하는 방법은 두 가지입니다.

#### ① `/q` 명령어 사용

가장 명확한 종료 방식으로, CLI에게 종료 의도를 명시적으로 전달합니다.

```
/q
```

#### ② `CTRL + C`

일반적인 터미널 인터럽트 방식으로 즉시 종료합니다.

두 방식 모두 세션은 종료되며, 필요 시 후속 재개 기능을 통해 이전 맥락을 복원할 수 있습니다.

***

### 7.2 대화를 재개하는 방법

Kiro CLI는 디렉터리 기반의 세션 기억 기능(directory-based persistence)을 제공합니다.

즉, 특정 디렉터리에서 시작된 대화는 해당 디렉터리를 기준으로 자동으로 연결됩니다.

#### 실행 명령:

```
kiro-cli chat --resume
```

#### 재개 시 나타나는 예시 메시지:

```
$ kiro-cli chat --resume
Picking up where we left off...

╭─────────────────────────────── Did you know? ────────────────────────────────╮
│                                                                              │
│     You can resume the last conversation from your current directory by      │
│                    launching with kiro-cli chat --resume                     │
│                                                                              │
╰──────────────────────────────────────────────────────────────────────────────╯

Model: claude-sonnet-4.5 (/model to change) | Plan: KIRO POWER (/usage for more detail)


> Discussed code indentation preferences (spaces vs tabs), showed JSON date formatting examples in multiple languages, and created Python data models based on an ERD diagram with User, Product, and Order tables.
```

즉, 이전 대화 내용을 요약해 제공하며, 사용자는 즉시 이어서 업무를 진행할 수 있습니다.

***

### Task-06 — 대화 종료 및 재개 실습

#### ① 현재 Kiro CLI 세션 종료

CLI 내에서 다음 명령 실행:

```
/q
```

#### ② 세션 재개

터미널에서 다음 실행:

```
kiro-cli chat --resume
```

#### ③ 동작 확인

* CLI가 이전 대화 내용을 자동으로 불러오는지 확인합니다.
* 재개된 맥락이 올바르게 반영되는지 검토합니다.

### 7.3 기능 요약

| 기능            | 설명                     |
| ------------- | ---------------------- |
| 디렉터리 기반 세션 기억 | 동일 폴더에서 재시작 시 자동 문맥 연결 |
| 명령 기반 재개      | --resume 옵션으로 이전 대화 복귀 |
| 대화 흐름 유지      | 복잡한 개발 업무의 연속성 확보      |

이 기능은 장기 프로젝트, 코드 리뷰, 데이터 모델링, IaC 설계 등 “연속적인 맥락 유지가 중요한 작업”에서 매우 큰 효율을 제공합니다.

***

## 08. 대화 세션 저장 및 불러오기

Kiro CLI를 사용하다 보면, 특정 주제에 대해 장시간 논의하거나, 생성된 히스토리를 보관하여 추후 참고해야 하는 경우가 있습니다.

이때 Kiro CLI는 대화 상태를 JSON 형식으로 저장하고, 이후 이를 다시 불러와 세션 문맥을 그대로 재구성하는 기능을 제공합니다.<br>

이 기능은 다음과 같은 상황에서 특히 유용합니다:

* 긴 작업 문맥을 이후에 다시 이어가고 싶을 때
* 프로젝트 단위로 대화 기록을 버전 관리하고 싶을 때
* 특정 시점의 논의 내용을 회고 또는 공유할 때

### 8.1  대화 세션 저장하기

대화를 JSON 파일 형태로 저장하려면 /save {name} 명령을 사용합니다.

#### ① 기본 저장 명령:

```
/save my-conversation
```

저장이 성공하면 다음과 같은 메시지가 나타납니다:

```
✔ Exported conversation state to my-conversation
```

#### ② 특정 경로에 저장하기

저장 경로를 지정할 수도 있습니다.

```
/save /{your home directory}/kiro-chats/my-conversation
```

#### ③ 기존 파일 덮어쓰기

대상 파일이 이미 존재하는 경우, Kiro CLI는 기본적으로 덮어쓰기를 허용하지 않습니다.

오류 메시지 예:

```
File at customer-service already exists. To overwrite, use -f or --force
```

파일을 덮어쓰려면 다음과 같이 실행합니다:

```
/save customer-service -f
```

***

### 8.2  저장된 세션 불러오기

불러온 세션은 기존 세션을 대체하며, 이후의 대화는 불러온 문맥을 기반으로 진행됩니다.

#### 불러오기 명령:

```
/load my-conversation
```

성공 메시지 예:

```
✔ Imported conversation state from my-conversation
```

주의:

저장된 세션을 불러오면 현재 세션의 문맥은 완전히 대체됩니다. 즉, 불러오기 전의 히스토리는 유지되지 않습니다.

***

###  Task-07 — 대화 저장 및 불러오기 실습

아래 단계를 따라 저장 및 불러오기 기능을 직접 사용해봅니다.

#### ① Kiro CLI 세션 시작

```
kiro-cli
```

#### ② 다음 프롬프트를 입력하여 새 대화 히스토리를 생성

원문과 동일하게 다음과 같은 질문을 두 번 입력합니다:

```
고객 서비스 애플리케이션(customer service application)을 설계하려고 합니다. 이때 반드시 고려해야 할 상위 세 가지 요소(top three things)에 대해 알려줄 수 있을까요?

또한, 고객 서비스 애플리케이션이 필요로 하는 데이터 모델(data model)은 어떤 형태가 되어야 하는지 보여주세요. 단, 코드는 생성하지 말아주세요.
```

#### ③ 세션 저장

```
/save customer-service
```

저장된 파일은 현재 디렉터리에 생성됩니다.

터미널에서 ls 명령으로 파일 생성 여부를 확인할 수 있습니다.

#### ④ 새로운 Kiro CLI 세션에서 불러오기

세션 종료:

```
/q
```

다시 시작:

```
kiro-cli
```

저장한 세션 불러오기:

```
/load customer-service
```

***

#### ⑤ 재개 동작 확인

이제 다음과 같은 질문을 입력해봅니다:

```
이 고객 서비스 애플리케이션(customer service application)을 스케일링(scaling)할 때 어떤 사항들을 고려해야 할까요?
```

Kiro CLI가 이전 대화 내용을 바탕으로 이어서 답변하는지 확인합니다.

***

## 09. 모델 선택(Choosing a Model)

Kiro CLI는 다양한 AI 모델을 지원하며, 사용자는 작업 성격에 맞추어 모델을 선택할 수 있습니다.

기본 설정에서는 Auto 모델 라우터가 활성화되어 있으며, 이는 여러 최신 모델을 상황에 따라 자동으로 조합하여 최적의 결과를 제공하도록 설계된 지능형 모델 선택 메커니즘입니다.

***

### 9.1 기본 모델: Auto

Kiro CLI를 시작하면 로고 아래에 현재 선택된 모델이 표시됩니다.

예:

```
Model: Auto (/model to change) | Plan: KIRO POWER (/usage for more detail)
```

Auto 모드는 다음과 같은 장점을 제공합니다:

* 작업 유형에 따라 적절한 모델을 자동 선택
* 코드 작성, 문제 해결, 분석 등에 맞는 최적 모델 조합
* 효율적 크레딧 사용 및 일관된 응답 품질

대부분의 사용 시나리오에서는 기본 Auto 설정이 가장 적합합니다.

### 9.2 모델 수동 변경

모델을 직접 선택하려면 /model 명령을 사용합니다.

#### 모델 변경 명령:

```
/model
```

화살표 키(↑↓)로 원하는 모델을 선택하고 Enter를 누릅니다.

예시 모델 목록:

* Auto (기본 / 1x 크레딧)
* claude-sonnet-4.5 (1.3x 크레딧 / 최신 Sonnet)
* claude-sonnet-4
* claude-haiku-4.5 (경량 / 빠른 응답)

### 9.3  Kiro CLI 실행 시 모델 지정

CLI 실행 시 바로 모델을 지정할 수도 있습니다.

```
kiro-cli chat --model claude-4-sonnet
```

### 9.4 기본 모델 설정하기

자주 사용하는 모델이 있다면 설정 파일에서 기본값으로 지정할 수 있습니다.

설정 파일 열기:

```
vi ~/.kiro/settings/cli.json
```

다음 설정 추가:

```
"chat.defaultModel": "claude-4-sonnet"
```

변경 후 Kiro CLI를 다시 시작하면 Sonnet이 자동으로 기본 모델로 사용됩니다.

### Task-08 — 모델 변경 실습

#### ① Kiro CLI 세션에서 모델 변경

```
/model
```

원하는 모델을 선택하고 간단한 프롬프트를 입력해 결과 차이를 관찰합니다.

#### ② 실행 시 모델 지정 테스트

Kiro CLI 종료 후 다음 실행:

```
kiro-cli chat --model claude-4-sonnet
```

모델이 Sonnet으로 적용된 것을 확인합니다.

#### ③ 기본 모델 재설정

cli.json 파일에 다음 내용을 추가:

```
"chat.defaultModel": "claude-4-sonnet"
```

저장 후 Kiro CLI 재시작 → Sonnet이 기본 모델로 활성화됩니다.

***

## 10. 명령 실행하기 

Kiro CLI는 기본적으로 대화(Chat) 기반 상호작용을 중심으로 동작하지만, 필요할 경우 대화 세션 내부에서 직접 시스템 명령을 실행할 수 있습니다.

이는 Kiro를 사용한 개발 워크플로우에서 매우 강력한 기능으로, 파일 확인 · 스크립트 실행 · 디렉터리 조회 등 다양한 작업을 즉시 수행할 수 있습니다.

명령 실행은 느낌표(!)를 활용합니다.

### 10.1  명령 실행 기본 규칙

#### ① 명령 실행 형식

```
! <command>
```

예:

```
! ls -altr
```

Kiro CLI는 명령을 실행한 뒤 출력 결과를 대화 흐름의 일부로 포함합니다.

### 10.2 실행은 “stateless” (상태 비저장)

명령 실행은 각 호출이 독립적으로 처리되며, 상태가 유지되지 않습니다.

예:

```
!cd ~/.kiro
```

```
!ls
```

위 ls 명령은 src 디렉터리가 아닌, Kiro CLI를 시작한 현재 작업 디렉터리에서 실행됩니다.

디렉터리를 이동한 상태는 유지되지 않기 때문입니다.

#### 이를 해결하는 방법:

```
!cd ~/.kiro && ls
```

여러 명령을 하나의 실행 흐름으로 연결해야 합니다.

***

### 10.3 출력은 “컨텍스트 창(context window)”를 소모

명령 출력은 Kiro의 컨텍스트로 포함되므로, 다음을 주의해야 합니다:

큰 파일을 출력하거나 대량의 로그를 출력하면 컨텍스트 창(token window)을 빠르게 소모할 수 있습니다.

컨텍스트 사용량은 `/context` 명령으로 확인할 수 있습니다.

### 10.4 요약

<table data-header-hidden><thead><tr><th width="184.109375"></th><th></th></tr></thead><tbody><tr><td>기능</td><td>설명</td></tr><tr><td>! 명령 실행</td><td>대화 중 임의의 쉘 명령 실행</td></tr><tr><td>상태 유지 X</td><td>각 명령은 분리되어 실행, 디렉터리 이동 상태 유지되지 않음</td></tr><tr><td>&#x26;&#x26; 활용</td><td>연속된 동작(디렉터리 이동 후 파일 확인 등)이 필요할 때 사용</td></tr><tr><td>컨텍스트 포함</td><td>명령 결과는 Kiro 컨텍스트 창을 소비</td></tr></tbody></table>

Kiro CLI를 활용하면 대화형 AI와 시스템 명령 실행을 단일 인터페이스에서 자연스럽게 통합할 수 있습니다.

***

## 11. 프롬프트 관리 

Kiro CLI는 자주 사용하는 지시문(prompt)을 마크다운 파일 형태로 저장하고 재사용할 수 있는 기능을 제공합니다.

이 기능을 활용하면 반복적인 지시를 매번 타이핑할 필요 없이, 통일된 품질의 지시문을 언제든 호출할 수 있으며, 팀 단위 협업 시 표준화된 작업 방식 구축에도 효과적입니다.

프롬프트는 글로벌(Global) 또는 프로젝트 단위(Local) 스코프로 저장할 수 있으며, 동일 이름이 충돌할 경우 로컬이 우선 적용됩니다.

***

### 11.1 프롬프트 목록 조회

현재 사용 가능한 모든 프롬프트는 다음 명령으로 확인할 수 있습니다:

```
/prompts list
```

출력 예:

```
Prompt                         Description       Arguments
-------------------------------------------------------------------
Global:
  ~/.kiro/prompts/Bootstrap-app-generation.md
  ~/.kiro/prompts/Generate-Entity-diagrams.md
  ~/.kiro/prompts/Add-UML-Sequence-diagram.md

Local:
  ./ .kiro/prompts/proj-setup.md
```

사용 형태는 다음과 같습니다:

```
@<prompt-name> [...args]
```

***

### 11.2  프롬프트 생성

새로운 프롬프트를 생성하려면 다음 명령을 사용합니다:

```
/prompts create --name proj-setup
```

설정된 기본 에디터가 열리며, 원하는 내용을 입력할 수 있습니다.

입력 예:

```
당신은 파이썬(Python) 으로 코드를 작성하는 것을 좋아합니다.
플라스크(Flask) 웹 애플리케이션 프레임워크(web application framework)를 선호합니다.
공백(space) 대신 탭(tab) 을 사용합니다.
모든 데이터 처리를 위해 PostgreSQL 을 사용합니다.
```

저장 후 /prompts list를 실행하면 새 프롬프트가 로컬 스코프로 생성된 것을 확인할 수 있습니다.

글로벌 프롬프트를 생성하려면:

```
/prompts create --name proj-setup --global
```

***

### 11.3 프롬프트 내용 확인

특정 프롬프트의 내용을 확인하려면:

```
/prompts details proj-setup
```

출력 예:

```
Name: proj-setup
Source: /home/ec2-user/.kiro/prompts/proj-setup.md

Usage: @proj-setup

Content Preview:
  당신은 파이썬(Python) 으로 코드를 작성하는 것을 좋아합니다.
  플라스크(Flask) 웹 애플리케이션 프레임워크(web application framework)를 선호합니다.
  공백(space) 대신 탭(tab) 을 사용합니다.
  모든 데이터 처리를 위해 PostgreSQL 을 사용합니다.
```

***

### 11.4 프롬프트 편집

프롬프트는 언제든지 수정할 수 있습니다.

```
/prompts edit proj-setup
```

설정된 기본 에디터가 열리며 내용을 자유롭게 변경할 수 있습니다.

***

### 11.5 프롬프트 실행

저장된 프롬프트를 호출하려면 @ 키워드를 사용합니다.

예:

```
@proj-setup
```

Kiro CLI는 해당 마크다운 파일 내용을 시스템 프롬프트처럼 해석하여 현재 세션 맥락에 반영합니다.

***

### Task-9 — 프롬프트 생성 및 활용 실습

#### ① Kiro CLI 세션에서 다음 명령 실행:

```
/prompts create --name proj-setup
```

#### ② 에디터가 열리면 다음 내용을 입력하고 저장:

```
You like to code in Python
You prefer Flask web application framework
Use tabs not spaces
Use PostgreSQL for all data
```

#### ③ 프롬프트 목록 확인 

```
/prompts list
```

#### ③  프롬프트 상세보기:

```
/prompts details proj-setup
```

#### ③  실사용 테스트:

```
@proj-setup
```

출력 예시:

```
> 이 프롬프트는 다음과 같은 개발 환경 설정과 선호사항을 정의하고 있습니다:

프로그래밍 언어 및 프레임워크:
- Python을 주 언어로 사용
- Flask를 웹 애플리케이션 프레임워크로 선택

코딩 스타일:
- 들여쓰기에 공백(space) 대신 탭(tab) 사용

데이터베이스:
- 모든 데이터 저장 및 처리에 PostgreSQL 사용

이 프롬프트는 제가 코드를 작성하거나 제안할 때 위의 기준을 따르도록 하는 지침입니다. 예를 들어, 웹 애플리케이션을 만들어야 한다면 Django나 FastAPI 대신 Flask를 사용하고, 데이터베이스가 필요하면 MySQL이나 MongoDB 대신 PostgreSQL을 사용하며, 코드 포맷팅 시 탭 문자를 사용하게 됩니다.

구체적으로 어떤 애플리케이션이나 기능을 만들고 싶으신가요?
```

###  11.6 요약

<table data-header-hidden><thead><tr><th width="205.640625"></th><th></th></tr></thead><tbody><tr><td>기능</td><td>설명</td></tr><tr><td>프롬프트 생성</td><td>반복적인 지시를 텍스트 파일로 관리</td></tr><tr><td>글로벌/로컬 구분</td><td>프로젝트별 맞춤 프롬프트 구성 가능</td></tr><tr><td>상세 보기 / 편집</td><td>Markdown 기반으로 자유롭게 관리</td></tr><tr><td>@prompt-name</td><td>프롬프트 호출로 빠른 지시 적용</td></tr></tbody></table>

프롬프트 관리는 개발 워크플로우의 품질과 일관성을 크게 높이는 핵심 기능입니다.

***

## 12. Tool

Kiro CLI는 외부 환경과 상호작용하기 위해 Tools(도구) 개념을 사용합니다.

Tools는 파일 읽기·쓰기, 명령 실행, 웹 검색, AWS 리소스 조회 등 다양한 작업을 수행하며, 이를 통해 Kiro CLI는 단순 대화형 에이전트를 넘어 실행 가능한 개발 도우미로 확장됩니다.

도구 사용 시 잠재적 위험이 존재하기 때문에, Kiro CLI는 Trust(신뢰 수준) 개념을 도입하여 사용자가 도구 실행 여부를 직접 제어할 수 있도록 디자인했습니다.

***

### 12.1  Tools 조회

현재 세션에서 사용 가능한 모든 도구와 신뢰 상태는 다음 명령으로 확인합니다.

```
/tools
```

출력 예:

```
> /tools

Tool              Permission
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔Built-in
- shell           not trusted
- read            trust working directory
- write           not trusted
- introspect      trusted
- report          not trusted
- aws             trust read-only commands
- web_fetch       not trusted
- web_search      not trusted
```

#### 핵심 규칙

* trusted: 즉시 실행 가능
* not trusted: 실행 전 매번 사용자의 승인 필요
* trust working directory: 특정 제한 조건에서만 자동 승인

### 12.2 Tools의 동작 방식

도구 실행은 항상 Kiro CLI의 결정에 따라 발생합니다.

사용자가 Kiro에게 요청한 작업을 수행하기 위해 필요한 경우 자동으로 도구 실행이 시도됩니다.

예를 들어, 파일을 생성하거나 수정해야 하는 경우 write 도구가 호출되며, 이 도구가 _`not trusted`_ 상태라면 다음과 같은 질문이 표시됩니다:

```
Allow this action? Use 't' to trust (always allow) this tool for the session. [y/n/t]:
```

옵션:

* y: 이번 한 번만 허용
* t: 세션이 유지되는 동안 항상 허용
* n: 실행 취소

세션이 종료되면 신뢰 설정은 기본값으로 초기화됩니다.

### Task 10 - Tool 신뢰 동작 이해하기

1. 다음 프롬프트 입력:

```
사용자로부터 이름을 입력(prompt)받은 뒤, 그들에게 도산 안창호 선생님의 지혜(wisdom)를 전하는 스크립트를 작성하라.
```

2. write 도구가 호출되며 다음과 같은 메시지가 표시됩니다:

```
I'll create the following file: /home/ec2-user/yoda_wisdom.py (using tool: write)
Purpose: 도산 안창호 선생님의 지혜를 전하는 Python 스크립트 생성
...
Allow this action? Use 't' to trust (always allow) this tool for the session. [y/n/t]:
```

여기서 t 입력 → 세션 동안 write 도구를 신뢰함.

3. 스크립트 생성 후 파일을 확인해 정상 생성되었는지 검증해 봅니다.

***

### 12.3 Tools와 신뢰 수준의 변화 요인

도구 목록 및 신뢰 수준은 여러 요소에 의해 변경될 수 있습니다:

#### ① Kiro CLI 버전 업데이트

예: v1.21.0에서 web\_fetch, web\_search 기본 제공.

#### ② MCP(Model Context Protocol) 서버 추가

MCP 서버는 추가적인 도구 세트를 제공하며, 기본적으로 모두 untrusted 상태로 시작됩니다.

#### ③ 실험 기능 활성화

일부 베타 기능은 신규 도구를 활성화하거나 도구 동작 방식을 변경할 수 있습니다.

***

### 12.4  Tool 신뢰 전략

Kiro CLI를 적극적으로 자동화 환경에서 활용하려면 Tools 설정이 매우 중요합니다.

#### 권장 전략

<table data-header-hidden><thead><tr><th width="173.6328125"></th><th></th></tr></thead><tbody><tr><td>작업 유형</td><td>신뢰 추천</td></tr><tr><td>파일 읽기</td><td>자동 신뢰(read-only)</td></tr><tr><td>파일 쓰기</td><td>사용자 승인 기반</td></tr><tr><td>쉘 명령 실행</td><td>보안상 기본적으로 미신뢰(not trusted) 유지</td></tr><tr><td>AWS 조회</td><td>read-only trust</td></tr><tr><td>외부 MCP 도구</td><td>최소 권한 부여 원칙 적용</td></tr></tbody></table>

### 12.5 요약

<table data-header-hidden><thead><tr><th width="179.89453125"></th><th></th></tr></thead><tbody><tr><td>개념</td><td>설명</td></tr><tr><td>Tools</td><td>Kiro CLI가 외부 작업을 수행하기 위한 실행 모듈</td></tr><tr><td>Trust Levels</td><td>trusted / not trusted / restricted</td></tr><tr><td>승인 흐름</td><td>도구 호출 시 사용자에게 허용 여부 요청</td></tr><tr><td>세션 기반 신뢰</td><td>세션 종료 시 기본 상태로 초기화</td></tr><tr><td>MCP 연계</td><td>서버별로 새로운 도구가 추가되며 기본적으로 untrusted</td></tr></tbody></table>

Tools는 Kiro CLI의 기능 확장 및 자동화의 핵심이며, 올바른 신뢰 관리가 안전하고 효율적인 워크플로우 구축에 필수적입니다.
