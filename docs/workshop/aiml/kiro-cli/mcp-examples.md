---
title: "MCP 예시(Examples)"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 27
last_modified_date: "2026-03-19"
---

# MCP 예시
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

본 가이드는 Model Context Protocol(MCP) 서버의 대표적인 예시, 제공 기능, 및 Kiro와의 설정 방법을 설명합니다.

{% hint style="danger" %}
경고\
MCP 서버는 반드시 신뢰할 수 있는 출처의 것만 추가해야 합니다.또한 해당 서버의 라이선스 및 문서를 반드시 검토하십시오.\
Kiro는 서드파티 MCP 서버 또는 외부 패키지에 대해 책임지지 않습니다.
{% endhint %}

***

## 1. AWS Documentation Server

AWS Documentation MCP 서버는 AWS 공식 문서에 대한 검색·조회·추천 기능을 제공합니다.

### 1.1. 기능

* AWS 서비스 전체 문서에 대한 검색(Search)
* AWS 문서 페이지를 Markdown 형식으로 읽기(Read)
* 특정 문서에 기반한 콘텐츠 추천(Recommendations)

***

### 1.2. 설치 및 설정

#### 사전 준비

1\. Astral의 uv 설치

```
# macOS / Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows PowerShell
irm https://astral.sh/uv/install.ps1 | iex
```

2\. Python 3.10 이상 설치

```
uv python install 3.10
```

***

### 1.3. 구성

#### macOS / Linux 설정 예시

```
{
  "mcpServers": {
    "aws-docs": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

#### Windows 설정 예시

```
{
  "mcpServers": {
    "aws-docs": {
      "command": "uv",
      "args": [
        "tool",
        "run",
        "--from",
        "awslabs.aws-documentation-mcp-server@latest",
        "awslabs.aws-documentation-mcp-server.exe"
      ],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

***

### 1.4. 제공 도구

| 도구명                                   | 설명                |
| ------------------------------------- | ----------------- |
| mcp\_aws\_docs\_search\_documentation | AWS 문서 검색         |
| mcp\_aws\_docs\_read\_documentation   | Markdown 형식 문서 조회 |
| mcp\_aws\_docs\_recommend             | 문서 기반 관련 콘텐츠 추천   |

***

### 1.5. 사용 예시

* S3 버킷 정책 관련 문서 검색 - “Search AWS documentation for S3 bucket policies”
* Lambda Function URLs 문서 읽기 - “Read the AWS Lambda function URLs documentation”
* ECS Task Definition 관련 추천 얻기 - “Find related content to AWS ECS task definitions”

***

## 2. GitHub MCP Server

GitHub MCP 서버는 Kiro가 GitHub 리포지토리·이슈·PR과 상호작용할 수 있도록 해줍니다.

### 2.1. 기능

* 리포지토리 파일·커밋·브랜치 조회
* 이슈 및 PR 생성·관리
* 코드/텍스트 기반 검색

***

### 2.2. 설치 및 설정

{% hint style="danger" %}
주의\
\
기존에 권장되던 @modelcontextprotocol/server-github 패키지는 더 이상 유지되지 않습니다.\
GitHub는 공식 Docker 기반 MCP 서버 사용을 권장합니다.
{% endhint %}

#### 1. Docker 설치

* macOS/Windows → Docker Desktop
* Linux → Docker Engine

#### 2. GitHub Personal Access Token 생성

GitHub → Settings → Developer settings → Personal access tokens

권한은 필요한 API 범위에 맞게 최소화 설정 권장.

***

### 2.3. 구성

.kiro/settings/mcp.json 에 추가:

```
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your-token-here"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

자세한 설정은 GitHub 공식 MCP 서버 문서를 참고하십시오.

***

### 2.4. 주요 제공 도구

| 카테고리          | 도구                    | 설명        |
| ------------- | --------------------- | --------- |
| Repository    | search\_repositories  | 리포지토리 검색  |
| Repository    | list\_branches        | 브랜치 목록 조회 |
| Issues        | list\_issues          | 이슈 목록 조회  |
| Issues        | update\_issue         | 이슈 업데이트   |
| Issues        | add\_issue\_comment   | 이슈 코멘트 추가 |
| Pull Requests | create\_pull\_request | PR 생성     |

***

### 2.5. Toolsets 

GitHub MCP 서버는 기능을 toolset 단위로 구성합니다.

도커 환경에서는 다음과 같이 특정 toolset만 활성화할 수 있습니다:

```
docker run -i --rm \
  -e GITHUB_PERSONAL_ACCESS_TOKEN=<your-token> \
  -e GITHUB_TOOLSETS="repos,issues,pull_requests,actions,code_security,experiments" \
  ghcr.io/github/github-mcp-server
```

***

### 2.6. 사용 예시

* “Show me information about the tensorflow/tensorflow repository”
* “Find examples of React hooks in facebook/react”
* “Create an issue in my repository about the login bug”

***

## 3. 사용자 정의 MCP 서버

원하는 기능을 추가하기 위해 나만의 MCP 서버를 직접 개발할 수도 있습니다.

### Creating a Custom MCP Server

1. 언어 선택 (Python, Node.js 등)
2. MCP 프로토콜 구현
3. 도구(툴) 정의
4. 패키징 및 배포

#### Resources

* MCP Protocol Specification
* Python MCP Server Template
* Node.js MCP Server Template

***

## 4. 기타 MCP 서버

#### Database Servers

* PostgreSQL MCP Server: 쿼리 및 데이터베이스 관리
* MongoDB MCP Server: MongoDB 상호작용

#### Development Tools

* Docker MCP Server: 컨테이너·이미지 관리
* Kubernetes MCP Server: 클러스터 관리

***

## 5. 추가 MCP 서버 찾기

* MCP Registry
* GitHub MCP Organization
* npm, PyPI에서 mcp-server 검색
