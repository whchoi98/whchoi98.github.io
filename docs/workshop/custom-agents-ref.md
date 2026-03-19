---
title: "에이전트 구성 레퍼런스"
parent: Workshop
nav_order: 22
last_modified_date: "2026-03-19"
---

# 에이전트 구성 레퍼런스
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

에이전트 구성 파일(Agent Configuration File)에는 다음과 같은 섹션을 포함할 수 있습니다:

* name — 에이전트 이름(선택 사항, 생략 시 파일명에서 유추)
* description — 에이전트 역할 및 목적 설명
* prompt — 고수준 컨텍스트(System Prompt 역할)
* mcpServers — 에이전트가 접근할 수 있는 MCP 서버
* tools — 에이전트가 사용할 수 있는 도구 목록
* toolAliases — 도구 이름 충돌 해결을 위한 Alias 매핑
* allowedTools — 사용자 승인 없이 실행 가능한 도구
* toolsSettings — 개별 도구 설정
* resources — 에이전트가 사용할 수 있는 리소스 파일
* hooks — 특정 트리거 지점에서 실행될 명령
* includeMcpJson — MCP 설정 파일의 서버 포함 여부
* model — 에이전트가 사용할 모델 ID

***

## 1. Name Field 

에이전트 식별용 이름을 지정합니다.

```
{
  "name": "aws-expert"
}
```

***

## 2. Description Field 

에이전트의 역할을 설명하는 인간 친화적 텍스트입니다.

```
{
  "description": "An agent specialized for AWS infrastructure tasks"
}
```

***

## 3. Prompt Field 

에이전트에 고수준 지침을 부여하는 시스템 프롬프트 역할을 합니다.

텍스트 또는 file:// URI를 사용하여 외부 파일을 참조할 수 있습니다.

#### Inline 프롬프트 예시

```
{
  "prompt": "You are an expert AWS infrastructure specialist"
}
```

#### File URI 프롬프트 예시

```
{
  "prompt": "file://./my-agent-prompt.md"
}
```

#### 파일 경로 처리 규칙

* 상대 경로: 에이전트 설정 파일 기준으로 해석
  * "file://./prompt.md" → 동일 디렉토리
  * "file://../shared/prompt.md" → 상위 디렉토리
* 절대 경로: 그대로 사용
  * "file:///Users/dev/prompts/agent.md"

***

## 4. MCP Servers Field 

에이전트가 사용할 Model Context Protocol(MCP) 서버를 정의합니다.

```
{
  "mcpServers": {
    "fetch": {
      "command": "fetch3.1",
      "args": []
    },
    "git": {
      "command": "git-mcp",
      "args": [],
      "env": { "GIT_CONFIG_GLOBAL": "/dev/null" },
      "timeout": 120000
    }
  }
}
```

각 서버 설정 항목:

* command (필수) — MCP 서버 실행 명령
* args (선택) — 실행 시 전달할 인자
* env (선택) — 서버에 적용할 환경 변수
* timeout (선택) — 요청 타임아웃(ms), 기본값 120000

***

## 5. Tools Field 

에이전트가 사용할 수 있는 도구 목록을 정의합니다.

도구 참조 방식:

* 내장 도구(Built-in tools): "read", "write", "shell"
* MCP 전체 도구: "@git" (git 서버의 모든 도구)
* MCP 특정 도구: "@git/git\_status"
* 모든 도구 포함: "\*"
* 모든 Built-in 도구 포함: "@builtin"

예시:

```
{
  "tools": [
    "read",
    "write",
    "shell",
    "@git",
    "@rust-analyzer/check_code"
  ]
}
```

전체 도구 허용:

```
{
  "tools": ["*"]
}
```

***

## 6. ToolAliases Field 

서버 간 동일 이름 도구 충돌 해결 또는 보다 직관적인 도구 이름 제공을 위해 사용합니다.

```
{
  "toolAliases": {
    "@github-mcp/get_issues": "github_issues",
    "@gitlab-mcp/get_issues": "gitlab_issues"
  }
}
```

짧은 alias 생성 예시:

```
{
  "toolAliases": {
    "@aws-cloud-formation/deploy_stack_with_parameters": "deploy_cf",
    "@kubernetes-tools/get_pod_logs_with_namespace": "pod_logs"
  }
}
```

***

## 7. AllowedTools Field 

사용자 승인 없이 자동 실행을 허용할 도구를 지정합니다.

보안 기능이므로 신중하게 구성해야 합니다.

```
{
  "allowedTools": [
    "read",
    "write",
    "@git/git_status",
    "@server/read_*",
    "@fetch"
  ]
}
```

#### 패턴 매칭 (Wildcard) 지원

* "@server/read\_\*" → read\_file, read\_config 등
* "@git-\*/status" → git-mcp/status 등
* "@server/\*\_get" → \*\_get 도구
* "@git-\*/\*" → git-\* 서버의 모든 도구
* Built-in 도구 prefix 매칭: "r\*" → read

{: .note }
주의: allowedTools는 "\*" 로 전체 허용을 지원하지 않습니다. (보안 이유)

***

## 8. ToolsSettings Field 

개별 도구에 특화된 설정을 제공합니다.

```
{
  "toolsSettings": {
    "write": {
      "allowedPaths": ["~/**"]
    },
    "@git/git_status": {
      "git_user": "$GIT_USER"
    }
  }
}
```

***

## 9. Resources Field 

에이전트가 로드할 파일 기반 리소스를 지정합니다.

반드시 file:// 접두사 사용.

```
{
  "resources": [
    "file://AmazonQ.md",
    "file://README.md",
    "file://.amazonq/rules/**/*.md"
  ]
}
```

지원 기능:

* 단일 파일
* Glob 패턴
* 상대/절대 경로

***

## 10. Hooks Field 

에이전트 생명주기(Lifecycle) 및 도구 실행 시점에서 특정 명령을 실행합니다.

```
{
  "hooks": {
    "agentSpawn": [{ "command": "git status" }],
    "userPromptSubmit": [{ "command": "ls -la" }],
    "preToolUse": [
      {
        "matcher": "shell",
        "command": "{ echo \"$(date) - Bash command:\"; cat; } >> /tmp/bash_audit_log"
      }
    ],
    "postToolUse": [
      {
        "matcher": "write",
        "command": "cargo fmt --all"
      }
    ]
  }
}
```

#### Hook 타입

<table data-header-hidden><thead><tr><th width="200.23046875"></th><th></th></tr></thead><tbody><tr><td>Hook</td><td>설명</td></tr><tr><td>agentSpawn</td><td>에이전트 초기화 시 실행</td></tr><tr><td>userPromptSubmit</td><td>사용자가 메시지를 제출할 때</td></tr><tr><td>preToolUse</td><td>도구 실행 전(차단 가능)</td></tr><tr><td>postToolUse</td><td>도구 실행 후</td></tr><tr><td>stop</td><td>Assistant 응답 종료 시</td></tr></tbody></table>

***

## 11. includeMcpJson Field 

글로벌 및 로컬 MCP 설정 파일에 정의된 MCP 서버를 자동 포함할지 여부:

```
{
  "includeMcpJson": true
}
```

***

## 12. Model Field 

에이전트가 사용할 모델 ID를 지정합니다.

```
{
  "model": "claude-sonnet-4"
}
```

모델이 사용 가능하지 않으면 기본 모델로 폴백(fallback)되며 경고가 표시됩니다.

***

## 13. 전체 예시

```
{
  "name": "aws-rust-agent",
  "description": "Specialized agent for AWS and Rust development",
  "prompt": "file://./prompts/aws-rust-expert.md",
  "mcpServers": {
    "fetch": { "command": "fetch-server", "args": [] },
    "git": { "command": "git-mcp", "args": [] }
  },
  "tools": ["read", "write", "shell", "aws", "@git", "@fetch/fetch_url"],
  "toolAliases": {
    "@git/git_status": "status",
    "@fetch/fetch_url": "get"
  },
  "allowedTools": ["read", "@git/git_status"],
  "toolsSettings": {
    "write": { "allowedPaths": ["src/**", "tests/**", "Cargo.toml"] },
    "aws": { "allowedServices": ["s3", "lambda"], "autoAllowReadonly": true }
  },
  "resources": ["file://README.md", "file://docs/**/*.md"],
  "hooks": {
    "agentSpawn": [{ "command": "git status" }],
    "postToolUse": [
      { "matcher": "write", "command": "cargo fmt --all" }
    ]
  },
  "model": "claude-sonnet-4"
}
```

***

## 14. 에이전트 파일 위치

### Local Agents (프로젝트 전용)

```
.kiro/agents/
```

해당 워크스페이스에서만 사용 가능하며 팀과 버전 관리하기 용이합니다.

예시:

```
my-project/
  .kiro/
    agents/
      dev-agent.json
      aws-specialist.json
```

### Global Agents (사용자 전역)

```
~/.kiro/agents/
```

어디서든 사용 가능하며 개인화된 에이전트에 적합합니다.

***

## 15. 에이전트 우선순위

1. Local 에이전트 우선
2. 동일 이름이 존재할 경우 Global 에이전트는 무시되며 경고 표시

***

## 16. 모범 사례

#### 1. Security

* allowedTools는 최소 권한으로 시작
* 와일드카드 사용 시 주의
* toolsSettings로 민감 작업 제한

#### 2. Organization

* 의미 있는 에이전트 이름 사용
* prompt 파일은 별도 디렉터리에 구성
* 프로젝트 레포 안에서 에이전트 버전 관리

#### 3. Workflow

* 단일 작업 목적용 특화 에이전트 생성
* 컨텍스트(resources) 활용해 정확도 향상
* MCP 서버를 활용해 도구 확장
