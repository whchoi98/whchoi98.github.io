---
title: "Chat 대화모드"
parent: Workshop
nav_order: 8
last_modified_date: "2026-03-19"
---

# Chat/대화모드
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Chat / 대화 모드

Kiro CLI는 터미널 환경에서 대화형 AI(Conversational AI) 와 직접 상호작용할 수 있는 Chat 모드를 제공합니다.

이 기능을 통해 명령줄 기반 워크플로우 속에서 자연스러운 대화를 하며 작업을 수행할 수 있습니다.

***

## 2. Starting a Session / 세션 시작하기

### 2.1. 기본 세션 시작

```
kiro-cli
```

### 2.2. 지정된 컨텍스트(Context) 또는 에이전트(Agent)와 함께 시작

```
kiro-cli --agent myagent
```

지정한 에이전트는 해당 컨텍스트에 맞게 대화 흐름을 조정하며, 작업 목적에 따른 맞춤형 응답을 제공합니다.

***

## 2. Entering Multi-Line Statements / 멀티라인 입력하기

대화 중 여러 줄의 명령 또는 긴 메시지를 입력해야 할 경우 다음 기능을 사용할 수 있습니다.

***

### 2.1. /editor

```
/editor
```

이 명령을 실행하면 기본 설정된 텍스트 편집기(기본값: vi)가 열립니다.

여기서 여러 줄의 메시지를 작성하고 저장·종료하면, 해당 내용이 Kiro에게 메시지로 전송됩니다.

***

### 2.2. Ctrl + J (줄 삽입)

터미널에서 `Ctrl(^) + J` 를 입력하면 프롬프트 내에서 바로 새 줄을 삽입할 수 있습니다.

***

### 2.3. /reply

최근 AI 응답을 인용된 형태로 편집기에서 열기 위해 사용합니다.

```
/reply
```

이 기능은 이전 메시지에 대해 긴 답변을 작성할 때 유용합니다.

***

## 3. Conversation Persistence/ 대화 지속성

Kiro CLI는 대화를 폴더(디렉터리) 단위로 저장하여, 동일한 디렉터리에서 다시 Kiro를 실행하면 기존 대화를 이어갈 수 있습니다.

***

### 3.1. Directory-based Persistence / 디렉터리 기반 지속성

* 특정 디렉터리에서 처음 Kiro와 대화를 시작하는 경우 → 새로운 대화 생성
* 해당 디렉터리에서 이전 대화가 존재하는 경우 → 자동으로 로드 가능

### 3.2. 명시적으로 이전 대화 불러오기

```
kiro-cli chat --resume
```

현재 디렉터리에 저장된 대화를 찾아 이어서 진행합니다.

***

## 4. Manual Saving & Loading / 대화 수동 저장 및 로드

대화 중 다음 명령을 사용하여 JSON 파일로 대화를 저장 또는 불러올 수 있습니다.

***

### 4.1. /save \[path] — 대화 저장

```
/save ./my-project-conversation.json
```

옵션:  `-f` 또는 -`-force` : 기존 파일 덮어쓰기

예시:

```
/save ./my-project-conversation -f
/save /home/user/project/my-project-conversation.json
```

***

### 4.2. `/load` \[path]  — 대화 불러오기

```
/load ./my-project-conversation.json
```

저장된 JSON 대화를 현재 세션에 불러옵니다.

***

### 4.3. Info / 참고 <br>

/save 및 /load 명령은 대화가 저장된 디렉터리와 독립적으로 동작합니다.

특히 /load 명령을 실행하면 현재 대화가 완전히 대체되므로, 불러오기 전 주의가 필요합니다.

***
