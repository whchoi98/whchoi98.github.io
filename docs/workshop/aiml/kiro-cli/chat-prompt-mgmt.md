---
title: "프롬프트 관리(Prompt Management)"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 12
last_modified_date: "2026-03-19"
---

# 프롬프트 관리
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

***

Kiro CLI는 로컬(Local) 프롬프트, 글로벌(Global) 프롬프트, 그리고 Model Context Protocol(MCP) 기반 프롬프트를 모두 지원합니다. 이를 통해 개발 워크플로우 전반에서 재사용 가능한 프롬프트를 생성·수정·구성·활용할 수 있는 종합적인 프롬프트 관리 기능을 제공합니다.

***

### 1. 프롬프트 유형

프롬프트 시스템은 다음 세 가지 유형을 지원합니다:

*   로컬 프롬프트(Local Prompts)

    워크스페이스에 저장되는 프로젝트 단위 프롬프트
*   글로벌 프롬프트(Global Prompts)

    모든 프로젝트에서 공통으로 사용할 수 있는 사용자 단위 프롬프트
*   MCP 프롬프트(MCP Prompts)

    MCP 서버에서 제공되며 향상된 기능을 포함한 프롬프트

***

### 2. 명령어

프롬프트 관련 모든 기능은 /prompts 명령어의 다양한 서브커맨드를 통해 접근합니다.

***

### 3. 프롬프트 목록 조회

```
/prompts list
```



모든 사용 가능한 프롬프트를 이름(Name) · 설명(Description) · \*\*출처(Source)\*\*의 3열 형식으로 표시합니다.

또한 프롬프트 개수와 로컬/글로벌/MCP 중 어디에서 제공되는 프롬프트인지 명확히 나타냅니다.

***

### 4. 프롬프트 생성

```
/prompts create –name name [–content content]
```

현재 워크스페이스에 로컬 프롬프트(Local Prompt)를 생성합니다.

#### Parameters (매개변수)

* name _(필수) :_ 프롬프트 이름 (최대 50자)
* –content content _(선택) :_ 프롬프트 내용을 직접 지정

#### Behavior (동작 방식)

* \--content 제공 시 → 지정한 콘텐츠로 프롬프트 즉시 생성
* \--content 미제공 시 → 기본 에디터가 열려 프롬프트 내용을 입력
* 생성된 프롬프트는 워크스페이스의 .kiro/prompts/ 경로에 저장

***

### 5. 프롬프트 수정

```
/prompts edit name
```

기존 프롬프트를 기본 에디터에서 열어 수정합니다.

#### 지원 대상

* 로컬(Local) 프롬프트
* 글로벌(Global) 프롬프트
* MCP 프롬프트(서버가 수정 기능을 지원하는 경우)

***

### 6. 프롬프트 상세 정보 확인

```
/prompts details name
```



아래 항목을 포함한 상세 정보를 제공합니다:

* 메타데이터 및 매개변수 정보
* AI 처리 이전의 원본 프롬프트 전체 콘텐츠
* 파라미터 요구사항 및 예시
* 프롬프트 출처(로컬·글로벌·MCP)

***

### 7. 프롬프트 사용

생성한 프롬프트는 채팅에서 @ 프리픽스(prefix)를 통해 호출합니다.

```
@prompt-name
```

#### Examples

```
@code-review
# 로컬 'code-review' 프롬프트 사용

@team-standup
# 글로벌 또는 MCP 'team-standup' 프롬프트 사용
```

***

### 8. MCP 프롬프트에 인자 전달

MCP 서버 기반 프롬프트는 인수(arguments) 를 받아 동작을 커스터마이징할 수 있습니다.

단, 로컬/글로벌 파일 기반 프롬프트는 인자를 지원하지 않습니다.

#### MCP Prompt Argument Syntax

```
@server-name/prompt-name <required-arg> [optional-arg]
```

어떤 인자를 지원하는지 확인하려면:

```
/prompts details prompt-name
```

#### Examples

```
@dev-tools/analyze "performance issue" "detailed"
@security-tools/scan "web-app" "high-severity"
```

***

### 9. 저장 위치

#### Local Prompts (로컬 프롬프트)

* 위치: project/.kiro/prompts/
* 범위: 현재 프로젝트 내에서만 사용 가능
* 우선순위: 최상위(동일 이름 존재 시 글로벌·MCP보다 우선)

#### Global Prompts (글로벌 프롬프트)

* 위치: \~/.kiro/prompts/
* 범위: 모든 프로젝트에서 공통 사용
* 우선순위: 중간(MCP보다 우선)

#### MCP Prompts

* 출처: 연결된 MCP 서버
* 범위: 서버 설정에 따라 상이
* 우선순위: 최하위

***

### 10. 우선순위 체계

동일한 이름의 프롬프트가 여러 위치에 존재하는 경우 다음 순서로 우선 적용됩니다:

1. Local Prompts (최고 우선순위)
2. Global Prompts
3. MCP Prompts (최저 우선순위)

이를 통해 프로젝트 요구에 맞춰 MCP 또는 글로벌 프롬프트를 손쉽게 오버라이드할 수 있습니다.

***

### 11. 향상된 기능

#### Content Preview (콘텐츠 미리보기)

AI로 전달되기 이전의 완전한 프롬프트 내용을 표시해, 실제 처리되는 정보를 명확히 파악하도록 지원합니다.

#### Improved Error Handling (개선된 오류 처리)

* MCP 서버 오류를 사용자 친화적 메시지로 변환
* 메타데이터 기반의 사용 예시 자동 생성
* 잘못된 파라미터 및 요구사항 누락에 대한 명확한 안내 제공

#### Visual Formatting (시각적 포맷팅)

* 모든 프롬프트 작업에서 일관된 터미널 스타일
* 다양한 메시지 타입에 대한 적절한 렌더링
* 목록 정보에 3열 레이아웃 적용

#### MCP Integration (MCP 통합)

* 자동 탐색(Automatic Discovery)을 통한 MCP 프롬프트 로드
* 개선된 UX 기반의 MCP 관리 기능
* JSON 오류의 가독성 높은 메시지 변환
* 실행 전 전체 콘텐츠 미리보기

***

### 12. 예시

### 기본 파일 기반 프롬프트 생성 및 사용

```
# 인자를 필요로 하지 않는 단순 프롬프트 생성
/prompts create --name code-review --content “최적의 모범 사례(best practices), 보안 이슈(security issues), 그리고 잠재적 개선 사항(potential improvements)을 위해 이 코드를 검토해 주세요:”

# 프롬프트 사용 (파일 기반 프롬프트는 인수 미지원)
@code-review
```

***

### MCP 인자 기반 프롬프트 사용 예시

```
@dev-tools/analyze "performance bottleneck" "cpu usage"
@security-tools/scan "web-app" "high-severity"
@aws-tools/deploy "my-service" "production" "us-west-2"
```

***
