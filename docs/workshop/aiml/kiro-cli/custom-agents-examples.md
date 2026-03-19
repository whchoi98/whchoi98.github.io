---
title: "에이전트 예시(Examples)"
parent: AIML
grand_parent: Workshop
nav_order: 23
last_modified_date: "2026-03-19"
---

# 에이전트 예시
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

이 페이지는 다양한 워크플로우를 위한 커스텀 에이전트 구성 예시를 제공합니다.

각 에이전트는 실제 개발 환경에서 바로 활용 가능한 형태로 구성되어 있으며, 사용자의 요구에 맞추어 확장하거나 수정할 수 있습니다.

***

## 1. AWS Specialist Agent

AWS 인프라 관리 및 개발 업무에 특화된 커스텀 에이전트입니다.

AWS 관련 도구 사용을 사전 승인하고, 관련 문서를 자동 컨텍스트에 포함하여 생산성을 높입니다.

```
{
  "name": "aws-specialist-agent",
  "description": "Specialized custom agent for AWS infrastructure and development tasks",
  "prompt": "You are an expert AWS infrastructure specialist with deep knowledge of cloud architecture and best practices",
  "tools": [
    "read",
    "write",
    "shell",
    "aws"
  ],
  "allowedTools": [
    "read",
    "aws"
  ],
  "toolsSettings": {
    "aws": {
      "allowedServices": [
        "s3",
        "lambda",
        "cloudformation",
        "ec2",
        "iam",
        "logs"
      ]
    },
    "write": {
      "allowedPaths": [
        "infrastructure/**",
        "scripts/**",
        "*.yaml",
        "*.yml",
        "*.json"
      ]
    }
  },
  "resources": [
    "file://README.md",
    "file://infrastructure/**/*.yaml",
    "file://infrastructure/**/*.yml",
    "file://docs/aws-setup.md",
    "file://scripts/deploy.sh"
  ],
  "hooks": {
    "agentSpawn": [
      {
        "command": "aws sts get-caller-identity",
        "timeout_ms": 10000,
        "cache_ttl_seconds": 300
      }
    ]
  },
  "model": "claude-sonnet-4"
}
```

#### 사용 사례

* CloudFormation 스택 배포
* S3 및 Lambda 운영 관리
* AWS 서비스 문제 해결
* IaC(Infrastructure as Code) 리뷰 및 업데이트

***

## 2. Development Workflow Agent

일반적인 소프트웨어 개발 워크플로우를 지원하도록 설계된 에이전트입니다.

Git 통합을 포함하여 코드 리뷰, 테스트, 문서 업데이트 등에 활용할 수 있습니다.

```
{
  "name": "development-workflow-agent",
  "description": "General development workflow custom agent with Git integration",
  "prompt": "You are a software development assistant with expertise in Git workflows and code management",
  "mcpServers": {
    "git": {
      "command": "git-mcp-server",
      "args": [],
      "timeout": 30000
    }
  },
  "tools": [
    "read",
    "write",
    "shell",
    "@git"
  ],
  "allowedTools": [
    "read",
    "@git/git_status",
    "@git/git_log",
    "@git/git_diff"
  ],
  "toolAliases": {
    "@git/git_status": "status",
    "@git/git_log": "log",
    "@git/git_diff": "diff"
  },
  "toolsSettings": {
    "write": {
      "allowedPaths": [
        "src/**",
        "tests/**",
        "docs/**",
        "*.md",
        "*.json",
        "package.json",
        "requirements.txt"
      ]
    }
  },
  "resources": [
    "file://README.md",
    "file://CONTRIBUTING.md",
    "file://docs/**/*.md",
    "file://package.json",
    "file://requirements.txt"
  ],
  "hooks": {
    "agentSpawn": [
      {
        "command": "git status --porcelain",
        "timeout_ms": 5000
      },
      {
        "command": "git branch --show-current",
        "timeout_ms": 3000
      }
    ]
  }
}
```

#### 사용 사례

* 코드 리뷰 및 분석
* 테스트 코드 생성 및 업데이트
* Git 브랜치·Diff 관리
* 문서 및 의존성 파일 업데이트

***

## 3. Code Review Agent

코드 품질, 보안, 모범 사례 분석에 초점을 맞춘 전문 코드 리뷰 에이전트입니다.

리뷰에 필요한 명령어만 허용하여 보안성과 정확도를 확보합니다.

```
{
  "name": "code-review-agent",
  "description": "Specialized custom agent for code review and quality analysis",
  "prompt": "You are a code review specialist focused on quality, security, and best practices",
  "tools": [
    "read",
    "shell"
  ],
  "allowedTools": [
    "read",
    "shell"
  ],
  "toolsSettings": {
    "shell": {
      "allowedCommands": [
        "grep",
        "find",
        "wc",
        "head",
        "tail",
        "cat",
        "diff",
        "git diff",
        "git log",
        "eslint",
        "pylint",
        "rubocop"
      ]
    }
  },
  "resources": [
    "file://CONTRIBUTING.md",
    "file://docs/coding-standards.md",
    "file://docs/security-guidelines.md",
    "file://.eslintrc.json",
    "file://.pylintrc",
    "file://pyproject.toml"
  ],
  "hooks": {
    "agentSpawn": [
      {
        "command": "git diff --name-only HEAD~1",
        "timeout_ms": 5000,
        "max_output_size": 2048
      }
    ],
    "userPromptSubmit": [
      {
        "command": "find . -name '*.py' -o -name '*.js' -o -name '*.ts' | wc -l",
        "timeout_ms": 3000,
        "cache_ttl_seconds": 60
      }
    ]
  }
}
```

#### 사용 사례

* PR(풀 리퀘스트) 코드 리뷰
* 보안 취약점 탐지
* 코딩 컨벤션 준수 여부 확인
* 복잡도 및 유지보수성 분석
* 리팩터링 제안

***

## 4. Project-Specific Agent

특정 프로젝트에 최적화된 전용 에이전트 구성 예시입니다.

Docker, Database, Build/Testing 등의 워크플로우에 맞춰 강화할 수 있습니다.

```
{
  "name": "mobile-app-agent",
  "description": "Custom agent for the mobile app backend project",
  "prompt": "You are a backend development specialist for mobile applications with expertise in Docker and database management",
  "mcpServers": {
    "docker": {
      "command": "docker-mcp-server",
      "args": ["--socket", "/var/run/docker.sock"]
    },
    "database": {
      "command": "postgres-mcp-server",
      "args": ["--connection", "postgresql://localhost:5432/myapp"],
      "env": {
        "PGPASSWORD": "$DATABASE_PASSWORD"
      }
    }
  },
  "tools": [
    "read",
    "write",
    "shell",
    "@docker",
    "@database"
  ],
  "allowedTools": [
    "read",
    "@docker/docker_ps",
    "@docker/docker_logs",
    "@database/query_read_only"
  ],
  "toolAliases": {
    "@docker/docker_ps": "containers",
    "@docker/docker_logs": "logs",
    "@database/query_read_only": "query"
  },
  "toolsSettings": {
    "write": {
      "allowedPaths": [
        "src/**",
        "tests/**",
        "migrations/**",
        "docker-compose.yml",
        "Dockerfile",
        "requirements.txt"
      ]
    },
    "shell": {
      "allowedCommands": [
        "npm test",
        "npm run build",
        "python manage.py test",
        "docker-compose up",
        "docker-compose down"
      ]
    }
  },
  "resources": [
    "file://README.md",
    "file://docs/api-documentation.md",
    "file://docs/database-schema.md",
    "file://docker-compose.yml",
    "file://requirements.txt",
    "file://src/config/settings.py"
  ],
  "hooks": {
    "agentSpawn": [
      {
        "command": "docker-compose ps",
        "timeout_ms": 10000,
        "cache_ttl_seconds": 30
      },
      {
        "command": "git status --porcelain",
        "timeout_ms": 5000
      }
    ]
  }
}
```

#### 사용 사례

* Docker 컨테이너 상태 점검 및 로그 조회
* 데이터베이스 조회 및 마이그레이션 관리
* 빌드/테스트 자동화
* API 문서 관리 및 업데이트
* 배포 파이프라인 디버깅

***

## 5. 원격 MCP 서버와 통합 에이전트

원격 MCP 서버와 통합된 에이전트 예시입니다.

```
{
  "name": "domain-finder",
  "description": "Agent with access to domain search capabilities",
  "prompt": "You help users find and research domain names using the find-a-domain service.",
  "mcpServers": {
    "find-a-domain": {
      "type": "http",
      "url": "https://api.findadomain.dev/mcp"
    }
  },
  "tools": ["@find-a-domain"],
  "allowedTools": ["@find-a-domain"]
}
```

OAuth 인증이 필요한 서버인 경우, /mcp 명령을 통해 인증 요청이 자동으로 수행됩니다.

***

## 6. 효율적인 커스텀 에이전트 구성 예시

효율적인 커스텀 에이전트를 만들기 위한 모범 사례:

* Start simple — 최소 구성으로 시작해 필요에 따라 확장
* Use descriptive names — 목적이 명확한 이름 지정
* Include relevant context — 프로젝트 문서, 설정 파일 자동 로드
* Pre-approve safe tools — 자주 쓰는 저위험 도구를 allowedTools에 추가
* Use hooks strategically — 시스템 상태·Git 브랜치·프로세스 등 동적 정보 반영
* Limit tool scope — toolsSettings로 도구 접근 범위 최소화
* Test thoroughly — 에이전트 동작을 충분히 검증
* Document for teams — 협업을 위해 용도·권한·컨텍스트 명확히 기술
