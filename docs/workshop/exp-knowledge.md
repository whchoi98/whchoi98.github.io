---
title: "Knowledge Management"
parent: Workshop
nav_order: 35
last_modified_date: "2026-03-19"
---

# Knowledge Management
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

`/knowledge` 명령은 Kiro CLI에 영구적인 지식 저장소(Persistent Knowledge Base) 기능을 제공합니다.

이를 통해 사용자는 파일·문서·코드 기반의 컨텍스트를 장기적으로 저장하고, 의미 기반 검색을 통해 여러 세션에 걸쳐 일관된 분석 및 질의 응답을 수행할 수 있습니다.

***

## 1. 시작하

### Enable Knowledge Feature

Knowledge Management 기능은 현재 실험적 기능이므로, 먼저 활성화해야 합니다.

```
kiro-cli settings chat.enableKnowledge true
```

***

## 2. 기본 사용법

기능 활성화 후, /knowledge 명령을 사용하여 지식 저장소를 관리할 수 있습니다.

```
/knowledge add --name myproject --path /path/to/project
/knowledge show
```

***

## 3. Commands

### `/knowledge show`

\
현재 에이전트의 Knowledge Base에 저장된 모든 엔트리를 표시합니다.

제공 정보:

* 엔트리 이름
* 생성 일자
* 파일 개수 및 인덱싱 상태
* 지속성(Persistence) 여부
* 활성화된 백그라운드 인덱싱 작업의 진행률 및 ETA

```
/knowledge show
```

***

### `/knowledge add`

파일 또는 디렉터리를 지식 저장소에 추가합니다.

디렉터리를 지정하면 지원되는 모든 파일이 재귀적으로 인덱싱됩니다.

#### Syntax

```
/knowledge add --name <name> --path <path> \
               [--include pattern] [--exclude pattern] \
               [--index-type Fast|Best]
```

#### Required Parameters

| Parameter  | Description   |
| ---------- | ------------- |
| --name, -n | 지식 엔트리 이름     |
| --path, -p | 파일 또는 디렉터리 경로 |

#### Examples

```
/knowledge add --name "project-docs" --path /path/to/documentation
/knowledge add -n "config-files" -p /path/to/config.json
/knowledge add --name "fast-search" --path /path/to/logs --index-type Fast
/knowledge add -n "semantic-search" -p /path/to/docs --index-type Best
```

***

## 4.Index Types

#### Fast (Lexical - bm25)

키워드 기반 인덱싱 및 검색

장점

* 매우 빠른 인덱싱
* 즉시 검색 가능
* 낮은 CPU 및 메모리 사용량
* 로그, 설정 파일, 대규모 코드베이스에 적합

단점

* 의미 이해 없음
* 정확한 키워드 기반 검색만 가능

***

#### Best (Semantic - all-MiniLM-L6-v2)

문서 의미 기반 인덱싱 및 자연어 검색

장점

* 문맥·의미 이해
* 자연어 질의 지원
* 키워드 없이도 관련 개념 탐색
* 문서 및 기술 자료에 최적

단점

* 인덱싱 속도 느림
* CPU·메모리 사용량 증가

***

#### When to Use Each Type

| Use Case                | Recommended | Reason          |
| ----------------------- | ----------- | --------------- |
| Log files               | Fast        | 대량 로그·키워드 기반 탐색 |
| Config files            | Fast        | 파라미터/키 값 검색     |
| Large codebases         | Fast        | 심볼/함수 검색 최적     |
| Technical documentation | Best        | 자연어 기반 검색 가능    |
| Research papers         | Best        | 개념·문맥 중심 탐색     |
| Mixed documents         | Best        | 풍부한 검색 품질       |

***

## 5. Pattern Filtering

지식 저장소 구축 시 포함/제외 파일 패턴을 지정할 수 있습니다.

#### Examples

```
/knowledge add "rust-code" /path/to/project \
  --include "*.rs" --exclude "target/**"

/knowledge add "docs" /path/to/project \
  --include "**/*.md" --include "**/*.txt" \
  --exclude "node_modules/**"
```

#### Common Patterns

| Pattern            | Meaning            |
| ------------------ | ------------------ |
| \*.rs              | 모든 Rust 파일         |
| \*\*/\*.py         | 재귀적으로 모든 Python 파일 |
| target/\*\*        | target 디렉터리 전체     |
| node\_modules/\*\* | node\_modules 전체   |

#### Default Pattern Behavior<br>

설정된 기본 패턴이 존재하면 자동 적용됩니다.

```
kiro-cli settings knowledge.defaultIncludePatterns '["**/*.rs", "**/*.py"]'
kiro-cli settings knowledge.defaultExcludePatterns '["target/**", "__pycache__/**"]'

/knowledge add "my-project" /path/to/project
```

***

## 6. Supported File Types

#### Text & Markup

.txt, .md, .markdown, .log, .csv, .tsv, .html, .xml, .tex, .rst 등

#### Code

.rs, .py, .js, .ts, .go, .cpp, .java, .php, .kt, .swift, .cs, .sh, .sql, .yaml, .toml 등

#### Special

Dockerfile, Makefile, LICENSE, README (확장자 없이도 지원)

Note: 일부 바이너리 파일은 텍스트 추출 없이 메타데이터만 인덱싱됩니다.

***

## `/knowledge remove`

엔트리를 이름, 경로, 또는 Context ID로 제거합니다.

```
/knowledge remove "project-docs"
```

***

## `/knowledge update`

기존 엔트리를 다시 인덱싱합니다. 기존 include/exclude 규칙은 유지됩니다.

```
/knowledge update /path/to/project
```

***

## `/knowledge clear`

전체 Knowledge Base 삭제 (되돌릴 수 없음).

```
/knowledge clear
```

***

## `/knowledge cancel`

백그라운드 인덱싱 작업 취소.

```
/knowledge cancel abc12345
/knowledge cancel all
```

***

## 7. 구성 옵션

```
kiro-cli settings knowledge.maxFiles 10000
kiro-cli settings knowledge.chunkSize 1024
kiro-cli settings knowledge.chunkOverlap 256
kiro-cli settings knowledge.indexType Fast
kiro-cli settings knowledge.defaultIncludePatterns '["**/*.rs", "**/*.md"]'
kiro-cli settings knowledge.defaultExcludePatterns '["target/**", "node_modules/**"]'
```

***

## 8. Agent-Specific Knowledge Bases

Kiro는 에이전트별 독립적인 지식 저장소를 운영합니다.

#### 주요 특징

* 서로 다른 에이전트 간 지식 격리
* 에이전트 교체 시 자동 전환
* 에이전트마다 분리된 contexts.json 및 인덱싱 데이터 관리
* 기존(레거시) 지식 저장소는 자동으로 default agent로 마이그레이션

#### Directory Structure

```
~/.kiro/knowledge_bases/
├── kiro_cli_default/
│   ├── contexts.json
│   └── context-id-1/
│       └── data.json
└── my-custom-agent_XXXX/
    ├── contexts.json
    └── context-id-3/
        └── data.json
```

***

## 9. 동작방식

#### Indexing Pipeline

1. Pattern filtering
2. 파일 탐색 및 텍스트 추출
3. Chunking
4. Background 인덱싱
5. Semantic Embedding (Best 모드일 경우)

#### Search Capability

* 자연어 기반 질문
* 의미 기반 검색
* 관련 문서 수준 높은 우선순위 제공

***

## 10. Best Practices

#### Organizing Your Knowledge Base

* 의미 있는 엔트리명 사용: “api-docs”, “infra-guides”
* 포함/제외 패턴을 적극 활용
* 대규모 프로젝트는 디렉터리 단위로 추가
* 정기적으로 오래된 엔트리 정리

#### Searching Effectively

* 자연어로 질문
* 구체적 질의 사용
* 필요한 경우 표현 변경
* Kiro에게 명시적으로 지식 사용 요청 

```
“Use your knowledge base to find the database configuration.”
```

#### Large Project Management

* node\_modules, .git, target 등 제외
* 패턴 정교화
* 작업 상태 /knowledge show로 모니터링

***

## 11. 제약 사항

#### File Type

* 일부 바이너리 포맷은 텍스트 추출 제한
* 매우 큰 파일은 chunk 단위로 분할되어 문맥이 끊어질 수 있음

#### Performance

* 대규모 디렉터리는 인덱싱 시간이 길어질 수 있음
* 검색 성능은 데이터 크기에 따라 변동

#### Storage

* 자동 정리 기능 없음
* clear 시 복구 불가

***

## 12. 트러블슈팅

#### Files not indexed

* include/exclude 패턴 확인
* 경로 유효성 확인
* 파일 확장자 확인
* /knowledge show에서 에러 확인

#### Search not returning expected results

* 인덱싱 완료 여부 확인
* 다른 표현으로 재검색
* 파일이 실제로 인덱싱되었는지 검증

#### Performance Issues

* 불필요한 파일 제외
* 부분 디렉터리만 추가
* 패턴 개선
