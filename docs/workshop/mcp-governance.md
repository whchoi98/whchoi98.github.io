---
title: "MCP Governance"
parent: Kiro CLI Workshop
nav_order: 29
last_modified_date: "2026-03-19"
---

# Governance
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Governance

### 1.1 개요

IAM Identity Center를 인증(Sign-in) 방식으로 사용하는 Pro-tier 고객은 조직(Organization) 내 사용자에 대해 모델 컨텍스트 프로토콜(Model Context Protocol, MCP) 접근을 제어할 수 있습니다.

기본 설정(Default configuration)에서는 사용자가 Kiro 클라이언트(Client)에서 모든 MCP 서버(Server)를 사용할 수 있습니다.

관리자는 다음 두 가지 중 하나를 선택하여 MCP 사용을 제어할 수 있습니다.

1. MCP 사용을 완전히 비활성화(Disable)
2. 사전에 검증된 MCP 서버만 사용하도록 허용 목록(Allow-list) 지정

이러한 설정은 MCP On/Off 토글(Toggle) 및 MCP 레지스트리(Registry)를 통해 관리됩니다.

해당 설정은 Kiro 구독 사용자의 경우 _Kiro Profile_, Q 구독 사용자의 경우 _Q Developer Profil&#x65;_&#xC5D0; 포함됩니다.

프로필은 조직 수준(Organization-level) 또는 계정 수준(Account-level)에서 정의할 수 있으며,

계정 수준 프로필이 조직 수준 프로필보다 우선 적용(Supersede) 됩니다.

{: .note }
#### 주의 사항 -  MCP 토글 및 레지스트리 설정은 클라이언트 측(Client-side)에서 강제됩니다. 따라서 최종 사용자가 기술적으로 이를 우회할 가능성이 존재함을 인지해야 합니다.

***

## 2. MCP 비활성화

### 2.1 조직 또는 계정 단위 MCP 비활성화

조직 또는 계정에서 MCP 사용을 비활성화하려면 다음 절차를 수행합니다.

1. Kiro 콘솔(Console)을 엽니다.
2. Settings를 선택합니다.
3. 사용자 구독 유형에 따라 Kiro 또는 Q Developer 탭을 선택합니다.
4. Model Context Protocol (MCP) 토글을 Off로 설정합니다.

***

## 3. MCP 허용 목록(Allow-list)

### 3.1 지원 범위

{: .note }
MCP 허용 목록 기능은 현재 Q 구독 사용자만 지원됩니다.

### 3.2 MCP 허용 목록 개념

관리자는 허용된 MCP 서버만 정의한 JSON 파일을 생성하여 HTTPS로 제공하고, 해당 URL을 Q Developer Profile에 등록할 수 있습니다.

이렇게 설정된 Kiro 클라이언트는 레지스트리에 정의된 MCP 서버만 사용하도록 제한됩니다.

### 3.3 MCP Registry URL 설정

#### 설정 절차

1. Kiro 콘솔을 엽니다.
2. Settings를 선택합니다.
3. Q Developer 탭을 선택합니다.
4. Model Context Protocol (MCP)이 활성화(On)되어 있는지 확인합니다.
5. MCP Registry URL에서 Edit를 선택합니다.
6. MCP 레지스트리 JSON 파일의 URL을 입력합니다.
7. Save를 선택합니다.

MCP Registry URL은 전송 중(In transit) 및 저장 시(At rest) 모두 데이터 암호화 정책에 따라 암호화됩니다.

***

## 4. MCP Registry 파일 형식

MCP Registry 파일은 MCP Registry Standard v0.1의 부분 집합(Subset)을 사용합니다.

아래 예시는 원격(Remote) 및 로컬(Local) MCP 서버 정의를 모두 포함합니다.

```
{
  "servers": [
    {
      "server": {
        "name": "my-remote-server",
        "title": "My server",
        "description": "My server description",
        "version": "1.0.0",
        "remotes": [
          {
            "type": "streamable-http",
            "url": "https://acme.com/my-server",
            "headers": [
              {
                "name": "X-My-Header",
                "value": "SomeValue"
              }
            ]
          }
        ]
      }
    },
    {
      "server": {
        "name": "my-local-server",
        "title": "My server",
        "description": "My server description",
        "version": "1.0.0",
        "packages": [
          {
            "registryType": "npm",
            "registryBaseUrl": "https://npm.acme.com",
            "identifier": "@acme/my-server",
            "transport": {
              "type": "stdio"
            },
            "runtimeArguments": [
              {
                "type": "positional",
                "value": "-q"
              }
            ],
            "packageArguments": [
              {
                "type": "positional",
                "value": "start"
              }
            ],
            "environmentVariables": [
              {
                "name": "ENV_VAR",
                "value": "ENV_VAR_VALUE"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

***

## 5. MCP Registry 속성(Properties)

### 5.1 공통 속성(Common attributes)

| Attribute   | Description                           | Optional | Example value                                |
| ----------- | ------------------------------------- | -------- | -------------------------------------------- |
| name        | 서버 이름. 레지스트리 내에서 고유해야 함               |          | “aws-ccapi-mcp”                              |
| title       | 사람이 읽기 쉬운 서버 이름                       | Yes      | “AWS CC API”                                 |
| description | 서버 기능 설명                              |          | “Manage AWS infra through natural language.” |
| version     | 서버 버전. 의미적 버전(Semantic Versioning) 권장 |          | “1.0.2”                                      |

***

### 5.2 원격(Remote) MCP 서버 속성

| Attribute | Description                | Optional | Example value               |
| --------- | -------------------------- | -------- | --------------------------- |
| remotes   | 정확히 하나의 원격 엔드포인트 정의        |          |                             |
| type      | “streamable-http” 또는 “sse” |          | “streamable-http”           |
| url       | MCP 서버 엔드포인트 URL           |          | “https://mcp.figma.com/mcp” |
| headers   | 요청에 포함할 HTTP 헤더            | Yes      |                             |

***

### 5.3 로컬(Local) MCP 서버 속성

#### 패키지 실행 도구 매핑

| registryType | 실행 도구(Runtime) |
| ------------ | -------------- |
| npm          | npx            |
| pypi         | uvx            |
| oci          | docker         |

#### 패키지 속성

<table data-header-hidden><thead><tr><th width="202.21875"></th><th></th><th></th><th></th></tr></thead><tbody><tr><td>Attribute</td><td>Description</td><td>Optional</td><td>Example value</td></tr><tr><td>registryType</td><td>패키지 레지스트리 유형</td><td></td><td>“npm”</td></tr><tr><td>registryBaseUrl</td><td>패키지 레지스트리 URL</td><td>Yes</td><td>“https://npm.acme.com”</td></tr><tr><td>identifier</td><td>MCP 서버 패키지 식별자</td><td></td><td>“@acme/my-server”</td></tr><tr><td>transport.type</td><td>전송 방식. 반드시 “stdio”</td><td></td><td>“stdio”</td></tr><tr><td>runtimeArguments</td><td>실행 도구 인자</td><td>Yes</td><td>“-q”</td></tr><tr><td>packageArguments</td><td>MCP 서버 인자</td><td>Yes</td><td>“start”</td></tr><tr><td>environmentVariables</td><td>환경 변수</td><td>Yes</td><td>“LOG_LEVEL=INFO”</td></tr></tbody></table>

***

## 6. MCP Registry 파일 제공(Serving)

* HTTPS를 통해 제공해야 합니다.
* 신뢰된 인증기관(CA)이 서명한 SSL 인증서가 필요합니다.
* Self-signed 인증서는 지원되지 않습니다.
* 사내 네트워크 전용 URL도 허용됩니다.

Kiro는 시작 시 및 이후 24시간마다 MCP Registry를 동기화합니다.

레지스트리에서 제거된 MCP 서버는 자동 종료되며,

버전이 다를 경우 레지스트리에 정의된 버전으로 재실행됩니다.

***

## 7. Kiro CLI 동작 방식

* Registry URL이 설정된 경우, Kiro CLI는 해당 레지스트리만 사용합니다.
* /mcp add 실행 시 레지스트리에 정의된 서버만 선택 가능합니다.

#### 사용자 재정의 허용 항목

사용자는 다음 항목을 추가 또는 변경할 수 있습니다.

* 환경 변수(Environment variables)
* HTTP 헤더(Headers)
* 요청 타임아웃(Request timeout)
* MCP 서버 범위(Scope)
* MCP 도구 신뢰 설정(Tool trust permissions)

이 값들은 레지스트리 정의를 우선 덮어씁니다.

***

## 8. MCP Registry JSON Schema

문서 하단에 제공된 JSON Schema는 Kiro에서 지원하는 MCP Registry 형식의 공식 스키마 정의입니다.

레지스트리 파일 작성 시 해당 스키마를 사용한 사전 검증을 권장합니다.

```
{
  "$schema": "https://json-schema.org/draft-07/schema",
  "properties": {
    "servers": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "server": {
            "$ref": "#/definitions/ServerDetail"
          }
        },
        "required": [
          "server"
        ]
      }
    }
  },
  "definitions": {
    "ServerDetail": {
      "properties": {
        "name": {
          "description": "Server name. Must be unique within a given registry file.",
          "example": "weather-mcp",
          "maxLength": 200,
          "minLength": 3,
          "pattern": "^[a-zA-Z0-9._-]+$",
          "type": "string"
        },
        "title": {
          "description": "Optional human-readable title or display name for the MCP server. MCP subregistries or clients MAY choose to use this for display purposes.",
          "example": "Weather API",
          "maxLength": 100,
          "minLength": 1,
          "type": "string"
        },
        "description": {
          "description": "Clear human-readable explanation of server functionality. Should focus on capabilities, not implementation details.",
          "example": "MCP server providing weather data and forecasts via OpenWeatherMap API",
          "maxLength": 100,
          "minLength": 1,
          "type": "string"
        },
        "version": {
          "description": "Version string for this server. SHOULD follow semantic versioning (e.g., '1.0.2', '2.1.0-alpha'). Equivalent of Implementation.version in MCP specification. Non-semantic versions are allowed but may not sort predictably. Version ranges are rejected (e.g., '^1.2.3', '~1.2.3', '\u003e=1.2.3', '1.x', '1.*').",
          "example": "1.0.2",
          "maxLength": 255,
          "type": "string"
        },
        "packages": {
          "items": {
            "$ref": "#/definitions/Package"
          },
          "type": "array"
        },
        "remotes": {
          "items": {
            "anyOf": [
              {
                "$ref": "#/definitions/StreamableHttpTransport"
              },
              {
                "$ref": "#/definitions/SseTransport"
              }
            ]
          },
          "type": "array"
        }
      },
      "required": [
        "name",
        "description",
        "version"
      ],
      "type": "object"
    },
    "Package": {
      "properties": {
        "registryType": {
          "description": "Registry type indicating how to download packages (e.g., 'npm', 'pypi', 'oci')",
          "enum": [
            "npm",
            "pypi",
            "oci"
          ],
          "type": "string"
        },
        "registryBaseUrl": {
          "description": "Base URL of the package registry",
          "examples": [
            "https://registry.npmjs.org",
            "https://pypi.org",
            "https://docker.io"
          ],
          "format": "uri",
          "type": "string"
        },
        "identifier": {
          "description": "Package identifier - either a package name (for registries) or URL (for direct downloads)",
          "examples": [
            "@modelcontextprotocol/server-brave-search",
            "https://github.com/example/releases/download/v1.0.0/package.mcpb"
          ],
          "type": "string"
        },
        "transport": {
          "anyOf": [
            {
              "$ref": "#/definitions/StdioTransport"
            },
            {
              "$ref": "#/definitions/StreamableHttpTransport"
            },
            {
              "$ref": "#/definitions/SseTransport"
            }
          ],
          "description": "Transport protocol configuration for the package"
        },

        "runtimeArguments": {
          "description": "A list of arguments to be passed to the package's runtime command (such as docker or npx).",
          "items": {
            "$ref": "#/definitions/PositionalArgument"
          },
          "type": "array"
        },
        "packageArguments": {
          "description": "A list of arguments to be passed to the package's binary.",
          "items": {
            "$ref": "#/definitions/PositionalArgument"
          },
          "type": "array"
        },
        "environmentVariables": {
          "description": "A mapping of environment variables to be set when running the package.",
          "items": {
            "$ref": "#/definitions/KeyValueInput"
          },
          "type": "array"
        }
      },
      "required": [
        "registryType",
        "identifier",
        "transport"
      ],
      "type": "object"
    },
    "StdioTransport": {
      "properties": {
        "type": {
          "description": "Transport type",
          "enum": [
            "stdio"
          ],
          "example": "stdio",
          "type": "string"
        }
      },
      "required": [
        "type"
      ],
      "type": "object"
    },
    "StreamableHttpTransport": {
      "properties": {
        "type": {
          "description": "Transport type",
          "enum": [
            "streamable-http"
          ],
          "example": "streamable-http",
          "type": "string"
        },
        "url": {
          "description": "URL template for the streamable-http transport. Variables in {curly_braces} reference argument valueHints, argument names, or environment variable names. After variable substitution, this should produce a valid URI.",
          "example": "https://api.example.com/mcp",
          "type": "string"
        },
        "headers": {
          "description": "HTTP headers to include",
          "items": {
            "$ref": "#/definitions/KeyValueInput"
          },
          "type": "array"
        }
      },
      "required": [
        "type",
        "url"
      ],
      "type": "object"
    },
    "SseTransport": {
      "properties": {
        "type": {
          "description": "Transport type",
          "enum": [
            "sse"
          ],
          "example": "sse",
          "type": "string"
        },
        "url": {
          "description": "Server-Sent Events endpoint URL",
          "example": "https://mcp-fs.example.com/sse",
          "format": "uri",
          "type": "string"
        },
        "headers": {
          "description": "HTTP headers to include",
          "items": {
            "$ref": "#/definitions/KeyValueInput"
          },
          "type": "array"
        }
      },
      "required": [
        "type",
        "url"
      ],
      "type": "object"
    },
    "PositionalArgument": {
      "properties": {
        "type": {
          "enum": [
            "positional"
          ],
          "example": "positional",
          "type": "string"
        },
        "value": {
          "description": "The value for the input.",
          "type": "string"
        }
      },
      "required": [
        "type",
        "value"
      ],
      "type": "object"
    },
    "KeyValueInput": {
      "properties": {
        "name": {
          "description": "Name of the header or environment variable.",
          "example": "SOME_VARIABLE",
          "type": "string"
        },
        "value": {
          "description": "The value for the input.",
          "type": "string"
        }
      },
      "required": [
        "name"
      ],
      "type": "object"
    }
  },
  "required": [
    "servers"
  ],
  "type": "object"
}

```

***

### 요약

* MCP Governance는 조직 및 계정 단위 제어를 제공합니다.
* MCP 허용 목록은 Q 구독 사용자만 지원됩니다.
* 레지스트리 기반 제어는 정책 강제 수단이지 완전한 보안 장치는 아닙니다.
* 엔터프라이즈 환경에서는 IAM, 네트워크 보안과 병행 사용해야 합니다.
