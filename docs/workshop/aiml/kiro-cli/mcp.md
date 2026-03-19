---
title: "MCP"
parent: AIML
grand_parent: Workshop
nav_order: 25
last_modified_date: "2026-03-19"
---

# MCP
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Model Context Protocol (MCP)

Model Context Protocol(MCP) 은 외부 서버와의 통합을 통해 Kiro의 기능을 확장하는 프로토콜입니다.

MCP 서버는 전문 도메인 지식, 외부 API, 커스텀 도구 등을 제공하며, 이를 Kiro가 직접 호출하여 보다 풍부하고 정교한 개발 워크플로우를 수행할 수 있습니다.

{: .note }
Tip\
\
인터랙티브 채팅 세션에서는 /mcp 슬래시 명령을 사용하여 현재 로드된 MCP 서버 목록을 확인할 수 있습니다.\
자세한 내용은 _Slash Commands_ 문서를 참고하십시오.

***

## 2. MCP란?

MCP(Model Context Protocol)는 Kiro가 외부 서버와 통신하여 전문화된 도구 및 정보에 접근할 수 있도록 해주는 표준화된 프로토콜입니다.

예를 들어, AWS Documentation MCP 서버를 사용하면 AWS 문서를 검색하거나 읽거나 관련 추천을 받을 수 있습니다.

#### MCP를 사용하면 다음 작업이 가능합니다:

* 전문 지식베이스 및 문서 접근
* 외부 서비스(API, SaaS 등) 통합
* 도메인 특화(Domain-specific) 도구 확장
* 조직 또는 개인 워크플로우에 맞춘 커스텀 MCP 서버 구축

***

## 3. MCP 설정

### 사전 요구 사항

MCP 사용 전 다음을 확인하십시오:

* 최신 버전의 Kiro 설치
* 사용하려는 MCP 서버가 요구하는 개별 사전 설치 요소 (각 MCP 서버 문서에 명시)

***

## 4. MCP 서버 관리

Kiro CLI에서 MCP 서버를 통합하는 방법은 두 가지입니다:

***

### 4.1. CLI 명령어 기반 관리

```
# Add new MCP server
kiro-cli mcp add github \
  --url "mcp://github.com/api" \
  --auth-token "$GITHUB_TOKEN" \
  --type "http"
```

***

### 4.2. mcp.json 파일 기반 관리

워크스페이스 또는 사용자 설정 파일에 MCP 서버 구성을 정의할 수 있습니다.

* 워크스페이스: \<project-root>/.kiro/settings/mcp.json
* 사용자 레벨: \~/.kiro/settings/mcp.json

```
{
  "mcpServers": {
    "local-server-name": {
      "command": "command-to-run-server",
      "args": ["arg1", "arg2"],
      "env": {
        "ENV_VAR1": "value1",
        "ENV_VAR2": "value2"
      },
      "disabled": false
    },
    "remote-server-name": {
      "url": "https://endpoint.to.connect.to",
      "type": "http",
      "headers": {
        "HEADER1": "value1",
        "HEADER2": "value2"
      },
      "disabled": false
    }
  }
}
```

구성 방식은 다음 두 가지를 모두 지원합니다:

<table data-header-hidden><thead><tr><th width="229.63671875"></th><th></th></tr></thead><tbody><tr><td>유형</td><td>방식</td></tr><tr><td>Local MCP Server</td><td>command, args, env 등으로 로컬 프로세스를 직접 실행</td></tr><tr><td>Remote MCP Server</td><td>url, type, headers 로 HTTP/원격 서버와 통신</td></tr></tbody></table>

***

## 5. 에이전트 구성에서 MCP 사용

에이전트의 mcpServers 필드는 해당 에이전트가 사용할 MCP 서버를 명시합니다.

```
{
  "name": "myagent",
  "description": "My special agent",
  "mcpServers": {
    "fetch": {
      "command": "fetch3.1",
      "args": []
    },
    "git": {
      "command": "git-mcp",
      "args": [],
      "env": {
        "GIT_CONFIG_GLOBAL": "/dev/null"
      },
      "timeout": 120000
    }
  },
  "includeMcpJson": "false"
}
```

#### includeMcpJson 필드

* true → 워크스페이스 및 사용자 설정 파일의 MCP 서버 포함
* false → 에이전트 설정 파일에 명시된 서버만 로드

이 방식으로 에이전트별로 MCP 서버 접근 범위를 매우 정밀하게 제어할 수 있습니다.

***

## 6. 문제 해결

<table data-header-hidden><thead><tr><th width="264.4609375"></th><th></th></tr></thead><tbody><tr><td>문제</td><td>해결 방법</td></tr><tr><td>Connection failures</td><td>MCP 서버 요구 사항 및 사전 설치 요소 확인</td></tr><tr><td>Permission errors</td><td>인증 토큰/API 키 유효성 확인</td></tr><tr><td>Tool not responding</td><td>MCP 서버 로그 확인</td></tr><tr><td>Configuration not loading</td><td>JSON 문법 검증 후 파일 다시 저장</td></tr></tbody></table>
