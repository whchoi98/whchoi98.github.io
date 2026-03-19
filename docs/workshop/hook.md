---
title: "Hook"
parent: Workshop
nav_order: 31
last_modified_date: "2026-03-19"
---

# Hook
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

***

Hooks는 에이전트(agent) 생명주기(lifecycle) 및 도구(tool) 실행 과정의 특정 시점에 사용자 정의 명령(custom commands)을 실행할 수 있도록 하는 기능입니다.

이를 통해 다음과 같은 고급 동작을 구현할 수 있습니다:

* 보안 검증(Security Validation)
* 로깅 및 감사(Audit Logging)
* 코드 포매팅(Code Formatting)
* 추가 컨텍스트 수집(Context Gathering)
* 사용자 정의 후처리(Post-processing)

Hooks는 Kiro의 에이전트 기능을 조직·프로젝트 요구사항에 맞게 확장하는 핵심 메커니즘입니다.

***

## Hook 정의

Hooks는 에이전트 설정(agent configuration) 파일 내에서 정의됩니다.

***

## 1. Hook Event Structure

모든 Hook은 STDIN을 통해 JSON 형식의 이벤트(payload)를 전달받습니다.

### 1.1. 기본 이벤트 구조 예시

```
{
  "hook_event_name": "agentSpawn",
  "cwd": "/current/working/directory"
}
```

### 1.2. Tool 관련 Hook의 추가 필드

<table data-header-hidden><thead><tr><th width="248.93359375"></th><th></th></tr></thead><tbody><tr><td>필드명</td><td>의미</td></tr><tr><td>tool_name</td><td>실행되는 도구의 이름</td></tr><tr><td>tool_input</td><td>도구 실행에 전달된 입력 값</td></tr><tr><td>tool_response</td><td>PostToolUse 시점에서의 도구 실행 결과</td></tr></tbody></table>

***

## 2. Hook Output 규칙

<table data-header-hidden><thead><tr><th width="112.62890625"></th><th width="257.88671875"></th><th></th></tr></thead><tbody><tr><td>Exit Code</td><td>의미</td><td>동작</td></tr><tr><td>0</td><td>Hook 성공</td><td>STDOUT은 사용자에게 표시되지 않고 컨텍스트에 반영됨</td></tr><tr><td>2</td><td><em>(PreToolUse 전용)</em> 도구 실행 차단</td><td>STDERR 내용이 LLM에게 반환됨</td></tr><tr><td>기타 코드</td><td>Hook 실패</td><td>사용자에게 STDERR 경고 표시, 도구는 계속 실행됨 <em>(PreToolUse 제외)</em></td></tr></tbody></table>

***

## 3. 도구 매칭 규칙

matcher 필드를 통해 특정 도구에만 Hook이 적용되도록 지정할 수 있습니다.

#### matcher 예시

<table data-header-hidden><thead><tr><th width="186.57421875"></th><th></th></tr></thead><tbody><tr><td>matcher 값</td><td>적용 범위</td></tr><tr><td>"write"</td><td>built-in write 도구에만 적용</td></tr><tr><td>"@git"</td><td>git MCP 서버의 모든 도구</td></tr><tr><td>"@git/status"</td><td>git MCP 서버의 특정 도구</td></tr><tr><td>"*"</td><td>전 도구 (built-in + MCP)</td></tr><tr><td>"@builtin"</td><td>모든 built-in 도구</td></tr><tr><td><em>(생략)</em></td><td>모든 도구</td></tr></tbody></table>

도구 참조 형식은 Agent Configuration Reference와 동일합니다.

***

## 4. Hook 종류

### 4.1. AgentSpawn

에이전트가 초기화될 때 실행됩니다.

도구 관련 정보는 포함되지 않습니다.

#### Event Example

```
{
  "hook_event_name": "agentSpawn",
  "cwd": "/current/working/directory"
}
```

#### Exit Code 동작

* 0: STDOUT 결과가 에이전트 컨텍스트에 추가됨
* 기타: STDERR 경고가 사용자에게 표시됨

***

### 4.2. UserPromptSubmit

사용자가 프롬프트를 제출할 때마다 실행됩니다.

출력은 대화 컨텍스트에 추가되어 LLM이 참고할 수 있습니다.

#### Event Example

```
{
  "hook_event_name": "userPromptSubmit",
  "cwd": "/current/working/directory",
  "prompt": "user's input prompt"
}
```

#### Exit Code 동작

* 0: STDOUT이 대화 컨텍스트에 추가됨
* 기타: STDERR 경고 표시

***

### 4.3. PreToolUse

도구 실행 직전에 실행되며, 유효성 검사 및 보안 확인에 적합합니다.

_유일하게 도구 실행을 차단할 수 있는 Hook입니다._

#### Event Example

```
{
  "hook_event_name": "preToolUse",
  "cwd": "/current/working/directory",
  "tool_name": "read",
  "tool_input": {
    "operations": [
      {
        "mode": "Line",
        "path": "/current/working/directory/docs/hooks.md"
      }
    ]
  }
}
```

#### Exit Code 동작

<table data-header-hidden><thead><tr><th width="136.45703125"></th><th></th></tr></thead><tbody><tr><td>Exit Code</td><td>동작</td></tr><tr><td>0</td><td>도구 실행 허용</td></tr><tr><td>2</td><td>도구 실행 차단, STDERR이 LLM에 반환됨</td></tr><tr><td>기타</td><td>경고 표시 후 도구는 계속 실행됨</td></tr></tbody></table>

***

### 4.4. PostToolUse

도구 실행 완료 후 실행되며, 실행 결과(tool\_response)에 접근할 수 있습니다.

#### Event Example

```
{
  "hook_event_name": "postToolUse",
  "cwd": "/current/working/directory",
  "tool_name": "read",
  "tool_input": {
    "operations": [
      {
        "mode": "Line",
        "path": "/current/working/directory/docs/hooks.md"
      }
    ]
  },
  "tool_response": {
    "success": true,
    "result": ["# Hooks\n\nHooks allow you to execute..."]
  }
}
```

#### Exit Code 동작

* 0: Hook 성공
* 기타: STDERR 경고 표시 _(도구는 이미 실행됨)_

***

### 4.5. Stop

Assistant가 응답을 완료할 때마다 실행되는 Hook입니다.

포매팅, 테스트, 빌드, 정리 작업 등 후처리에 적합합니다.

#### Event Example

```
{
  "hook_event_name": "stop",
  "cwd": "/current/working/directory"
}
```

#### Exit Code 동작

* 0: 성공
* 기타: STDERR 경고 표시

> Stop Hook에는 matcher가 필요하지 않습니다. 특정 도구와 연결되지 않는 이벤트이기 때문입니다.

***

## 5. MCP 예

MCP 도구가 호출될 때는 tool\_name에 서버 네임스페이스가 포함됩니다.

#### Example

```
{
  "hook_event_name": "preToolUse",
  "cwd": "/current/working/directory",
  "tool_name": "@postgres/query",
  "tool_input": {
    "sql": "SELECT * FROM orders LIMIT 10;"
  }
}
```

***

## 6. Timeout

* 기본 Hook 실행 제한시간: 30초 (30,000ms)
* Hook별로 timeout\_ms로 재정의할 수 있습니다.

***

## 7. Caching

* 기본값: cache\_ttl\_seconds = 0 (캐시 없음)
* 0보다 큰 값 설정 시, 성공한 Hook 결과를 해당 시간 동안 재사용합니다.
* 단, AgentSpawn Hook은 캐싱되지 않습니다.
