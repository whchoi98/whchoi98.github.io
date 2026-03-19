---
title: "컨텍스트 관리(Context Management)"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 13
last_modified_date: "2026-03-19"
---

# 컨텍스트 관리
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. 컨텍스트 관리

Kiro는 컨텍스트를 제공하는 세 가지 방식을 지원하며, 각각의 방식은 특정 사용 목적에 최적화되어 있습니다.

| <p>접근 방식</p><p>(Approach)</p> | 컨텍스트 윈도우 영향(Context Window Impact) | <p>지속성</p><p>(Persistence)</p> | <p>최적 활용 대상</p><p>(Best For)</p> |
| ----------------------------- | ---------------------------------- | ------------------------------ | -------------------------------- |
| Agent Resources               | 항상 활성화됨(토큰 소모)                     | 세션 간 지속                        | 필수 프로젝트 파일, 표준 문서, 구성 파일         |
| Session Context               | 항상 활성화됨(토큰 소모)                     | 현 세션에서만 유지                     | 임시 파일, 실험적 작업                    |
| Knowledge Bases               | 검색 시에만 토큰 사용                       | 세션 간 지속                        | 대규모 코드베이스 및 광범위한 문서              |

***

### 1.1. 컨텍스트 선택 의사결정 흐름도

1. 컨텐츠가 10MB 이상이거나 수천 개 파일로 구성되어 있는가?
   * Yes → Knowledge Bases 사용
   * No → 다음 단계
2. 이 컨텍스트를 모든 대화에서 지속적으로 사용할 필요가 있는가?
   * Yes → Agent Resources 사용
   * No → Session Context 사용

***

### 1.2. 빠른 선택 기준

* 프로젝트 핵심 파일(README, 설정, 표준 문서) → Agent Resources
* 대규모 코드베이스 또는 방대한 문서 → Knowledge Bases
* 단기 작업을 위한 임시 파일 → Session Context

***

## 2. 컨텍스트 윈도우 영향 이해

Agent Resources 및 Session Context에 추가된 파일은 참조 여부와 관계없이 매 요청마다 컨텍스트 윈도우(token window)를 소모합니다.

```
> /context show
```

예시 출력:

```
Agent 
  - .kiro/steering/**/*.md  
    <project-root>/.kiro/steering/product.md
    <project-root>/.kiro/steering/structure.md
    <project-root>/.kiro/steering/tech.md
    <project-root>/.kiro/steering/testing.md
  - README.md  
    <project-root>/snake/README.md
  - ~/.kiro/steering/**/*.md (no matches)

Session (temporary)
  <none>

5 matched files in use
- …testing.md (0.1% of context window)
- …tech.md (0.1% of context window)
- …README.md (0.1% of context window)
- …structure.md (0.2% of context window)
- …product.md (0.1% of context window)

Context files total: 0.5% of context window
```

설명:

* Agent: 에이전트 설정에 지정된 지속적 컨텍스트
* Session: 현재 세션에서만 유효한 임시 컨텍스트
* 컨텍스트 파일은 모델 컨텍스트 윈도우의 최대 75%까지 사용 가능하며, 초과 시 자동 제거됩니다.

Knowledge Bases는 검색 시에만 컨텍스트를 사용하므로, 대용량 자료에 적합합니다.

***

## 3. 컨텍스트 관리 개요

컨텍스트 파일은 프로젝트 요구사항, 개발 규칙, 코딩 표준 등 Kiro가 응답을 생성할 때 고려해야 하는 정보를 제공합니다.

***

## 4. 에이전트 리소스 기반 지속적 컨텍스트 설정

가장 권장되는 방식은 에이전트 설정 파일의 resources 필드에 파일을 지정하는 것입니다.

이렇게 하면 매번 동일한 컨텍스트가 자동으로 로드됩니다.

```
{
  "name": "my-agent",
  "description": "My development agent",
  "resources": [
    "file://README.md",
    "file://docs/**/*.md",
    "file://src/config.py"
  ]
}
```

{% hint style="info" %}
중요: 리소스는 반드시 file:// prefix 를 포함해야 컨텍스트 파일로 인식됩니다.
{% endhint %}

***

## 5. 임시 세션 컨텍스트 추가

/context add 명령어로 현재 세션에만 적용되는 컨텍스트를 추가할 수 있습니다.

```
> /context add README.md
Added 1 path(s) to context.
Note: Context modifications via slash command is temporary.
```

여러 파일을 추가하는 것도 가능합니다:

```
> /context add docs/*.md
Added 3 path(s) to context.
```

세션 종료 시 이 정보는 사라지므로, 영구적으로 유지하려면 resources 필드에 추가해야 합니다.

***

## 6. Knowledge Base Context (대규모 데이터셋 용 컨텍스트)

대규모 코드베이스 또는 문서가 컨텍스트 윈도우를 초과하는 경우 Knowledge Bases를 사용합니다.

Knowledge Bases는 온디맨드(on-demand) 검색 방식으로 동작하며, 검색 시에만 토큰을 소모합니다.

#### Enable Knowledge Bases

```
kiro-cli settings chat.enableKnowledge true
```

#### Add content to a knowledge base

```
kiro-cli chat

/knowledge add /path/to/large-codebase --include "/*.py" --exclude "node_modules/"
```

***

## 7. 컨텍스트 사용량 확인

```
> /context show
```

출력 예시:

```
Current context window (5.9% used)
|||████████████████████████████████████████████████████████████████ 5.9%

█ Context files 0.9%
█ Tools 0.5%
█ Kiro responses 0.7%
█ Your prompts 3.8%
```

***

## 8. 컨텍스트 제거

특정 파일 제거:

```
> /context remove src/temp-file.py
Removed 1 path(s) from context.
```

세션 컨텍스트 전체 초기화:

```
> /context clear
Cleared context
```

주의:

* /context 명령어로는 Agent Resources에 지정된 파일을 제거할 수 없습니다.
* 영구 제거는 에이전트 설정 파일에서 직접 수정해야 합니다.

***

## 9. 컨텍스트 관리가 필요한 상황

#### 1. 반복적으로 같은 파일을 /context add 하고 있는 경우 → Agent Resources에 추가하는 것이 권장됩니다.

```
# 매 세션마다 반복:
> /context add README.md
> /context add docs/*.md

# 한 번만 설정:
{
  "resources": [
    "file://README.md",
    "file://docs/**/*.md"
  ]
}
```

#### 2. 자주 사용하는 컨텍스트가 있는 경우 → 해당 에이전트를 기본 에이전트로 설정

```
> kiro-cli settings chat.defaultAgent my-project-agent
```

#### 3. 대용량 파일이 컨텍스트 윈도우를 많이 차지하는 경우 → Knowledge Base 사용을 고려

```
# 비효율적:
> /context add src/**/*.py

# 권장:
> /knowledge add src/ --include "**/*.py" --exclude "__pycache__/**"
```

***

## 10. 모범 사례

### 10.1. Context File Organization (파일 구성)

* 컨텍스트 파일은 목적에 맞게 정리하고 불필요한 내용을 제거
* 의미 있는 파일명 사용
* 대규모 문서는 논리적 폴더 구조로 정리
* 크기가 큰 파일은 토큰 소비에 유의

### 10.2. Performance Considerations (성능 고려사항)

* /context show로 토큰 사용량을 지속적으로 모니터링
* 지나치게 넓은 glob 패턴은 피하기
* 불필요한 컨텍스트 파일은 제거
* 대규모 파일은 소규모 파일로 분할 검토
* 방대한 데이터는 Knowledge Base 활용

### 10.3. Security Considerations (보안 고려사항)

* 민감한 정보를 컨텍스트에 포함하지 않기
* .gitignore로 민감 파일의 실수 커밋 방지
* 컨텍스트 파일을 주기적으로 검토
* 대화 시 어떤 정보가 공유되는지 항상 주의
