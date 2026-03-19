---
title: "MCP Configuration"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 26
last_modified_date: "2026-03-19"
---

# Configuration
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Configuration

### 1.1 MCP (Model Context Protocol) 서버 구성 가이드

Kiro CLI에서 Model Context Protocol(MCP) 서버를 구성하는 방법을 상세히 설명합니다.

구성 파일 구조, 로컬 및 원격 서버 설정, 로딩 우선순위, 환경 변수 관리, 보안 고려 사항을 포함합니다.

***

### 2. MCP 설정 파일 구조 (Configuration File Structure)

MCP 설정 파일은 JSON 형식을 사용하며, 기본 구조는 다음과 같습니다.

```
{
  "mcpServers": {
    "local-server-name": {
      "command": "command-to-run-server",
      "args": ["arg1", "arg2"],
      "env": {
        "ENV_VAR1": "hard-coded-variable",
        "ENV_VAR2": "${EXPANDED_VARIABLE}"
      },
      "disabled": false,
      "disabledTools": ["tool_name3"]
    },
    "remote-server-name": {
      "url": "https://endpoint.to.connect.to",
      "headers": {
        "HEADER1": "value1",
        "HEADER2": "value2"
      },
      "disabled": false,
      "disabledTools": ["tool_name3"]
    }
  }
}
```

***

### 3. 구성 속성 설명 (Configuration Properties)

#### 3.1 로컬 MCP 서버 (Local Server)

| 속성            | 타입      | 필수 | 설명                      |
| ------------- | ------- | -- | ----------------------- |
| command       | String  | 필수 | MCP 서버를 실행할 명령          |
| args          | Array   | 필수 | 실행 시 전달할 인자             |
| env           | Object  | 선택 | 서버 프로세스에 전달할 환경 변수      |
| disabled      | Boolean | 선택 | 서버 비활성화 여부 (기본값: false) |
| autoApprove   | Array   | 선택 | 사용자 확인 없이 자동 승인할 도구     |
| disabledTools | Array   | 선택 | 에이전트 호출 시 제외할 도구        |

***

#### 3.2 원격 MCP 서버 (Remote Server)

| 속성            | 타입      | 필수 | 설명                                         |
| ------------- | ------- | -- | ------------------------------------------ |
| url           | String  | 필수 | 원격 MCP 서버 HTTPS 엔드포인트 (localhost는 HTTP 허용) |
| headers       | Object  | 선택 | 연결 시 전달할 HTTP 헤더                           |
| env           | Object  | 선택 | 서버 프로세스에 전달할 환경 변수                         |
| disabled      | Boolean | 선택 | 서버 비활성화 여부                                 |
| autoApprove   | Array   | 선택 | 자동 승인할 도구                                  |
| disabledTools | Array   | 선택 | 사용 금지할 도구                                  |

***

### 4. 설정 예제 (Example Configurations)

#### 4.1 로컬 서버와 환경 변수 사용

```
{
  "mcpServers": {
    "web-search": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-bravesearch"
      ],
      "env": {
        "BRAVE_API_KEY": "${BRAVE_API_KEY}"
      }
    }
  }
}
```

본 예제에서는 API 키를 하드코딩하지 않고, 환경 변수 참조 방식으로 관리합니다.

***

#### 4.2 원격 서버와 HTTP 헤더 설정

```
{
  "mcpServers": {
    "api-server": {
      "url": "https://api.example.com/mcp",
      "headers": {
        "Authorization": "Bearer ${API_TOKEN}",
        "X-Custom-Header": "value"
      }
    }
  }
}
```

***

#### 4.3 다중 MCP 서버 구성

```
{
  "mcpServers": {
    "fetch": {
      "command": "uvx",
      "args": ["mcp-server-fetch"]
    },
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git"],
      "env": {
        "GIT_CONFIG_GLOBAL": "/dev/null"
      }
    },
    "aws-docs": {
      "command": "npx",
      "args": ["-y", "@aws/aws-documentation-mcp-server"]
    }
  }
}
```

***

### 5. MCP 서버 로딩 우선순위 (Loading Priority)

동일한 MCP 서버가 여러 설정에 정의된 경우, 다음 우선순위에 따라 로딩됩니다.

1. Agent 설정 파일 (agent.json의 mcpServers)
2. 워크스페이스 설정 파일 (.kiro/settings/mcp.json)
3. 글로벌 설정 파일 (\~/.kiro/settings/mcp.json)

***

#### 5.1 완전 덮어쓰기(Override) 사례

Agent 설정에서 동일한 서버를 정의할 경우, 하위 설정은 무시됩니다.

***

#### 5.2 서버 추가(Additive) 사례

서버 이름이 서로 다를 경우, 모든 서버가 병합되어 로딩됩니다.

***

#### 5.3 비활성화 오버라이드 사례

상위 설정에서 disabled가 true로 설정되면 서버는 실행되지 않습니다.

***

### 6. 환경 변수 관리 (Environment Variables)

MCP 서버 인증 및 설정에는 환경 변수 사용을 권장합니다.

```
{
  "mcpServers": {
    "server-name": {
      "env": {
        "API_KEY": "${YOUR_API_KEY}",
        "DEBUG": "true",
        "TIMEOUT": "30000"
      }
    }
  }
}
```

쉘 환경에서 환경 변수를 사전에 설정해야 합니다.

```
export YOUR_API_KEY="your-actual-key"
export DEBUG="true"
```

***

### 7. MCP 서버 비활성화 (Disabling Servers)

서버 설정을 유지한 채 일시적으로 비활성화하려면 다음과 같이 설정합니다.

```
{
  "mcpServers": {
    "server-name": {
      "disabled": true
    }
  }
}
```

***

### 8. 특정 도구 비활성화 (Disabling Specific Tools)

특정 MCP 서버의 일부 도구만 제한할 수 있습니다.

```
{
  "mcpServers": {
    "server-name": {
      "disabledTools": [
        "delete_file",
        "execute_command"
      ]
    }
  }
}
```

***

### 9. 로드된 MCP 서버 확인 (Viewing Loaded Servers)

대화형 세션에서 현재 로드된 MCP 서버를 확인하려면 다음 명령을 사용합니다.

```
/mcp
```

***

### 10. 설정 트러블슈팅 (Troubleshooting Configuration)

#### 10.1 JSON 문법 오류

* 쉼표 누락
* 따옴표 또는 중괄호 불일치
* JSON Validator 또는 Linter 사용 권장

***

#### 10.2 명령 경로 오류

* command 항목이 PATH에 존재하는지 확인
* 터미널에서 직접 실행 테스트

***

#### 10.3 환경 변수 오류

* 필수 환경 변수 설정 여부 확인
* 변수명 오타 여부 확인

***

#### 10.4 설정 로딩 확인

```
cat .kiro/settings/mcp.json
cat ~/.kiro/settings/mcp.json
```

***

### 11. 보안 고려 사항 (Security Considerations)

MCP 서버 구성 시 다음 원칙을 준수해야 합니다.

1. 민감 정보 하드코딩 금지
2. 환경 변수 참조 방식 사용
3. 자격 증명이 포함된 설정 파일의 버전 관리 제외
4. 신뢰된 원격 MCP 서버만 사용
5. disabledTools를 통한 위험 작업 제한
