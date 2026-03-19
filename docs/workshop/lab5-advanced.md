---
title: "LAB 5. Kiro CLI 고급 기능"
parent: Workshop
nav_order: 42
last_modified_date: "2026-03-19"
---

# LAB05. Kiro CLI 고급 기능
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Kiro CLI 고급 기능

이번 실습에서는 지금까지 배운 Kiro CLI의 기능을 바탕으로, 보다 고급 기능 및 확장된 활용 방식에 대해 다룹니다.

## 1. Custom Agent (커스텀 에이전트)

커스텀 에이전트는 서로 다른 작업 환경에 맞춰 구성(configuration) 및 지원 리소스(supporting resources)들을 묶어

Kiro CLI 세션을 최적화할 수 있도록 해주는 기능입니다.

#### 1.1  예시: 서로 다른 개발 작업에 맞춘 에이전트 구성

예를 들어, 다음과 같은 다양한 작업을 수행한다고 가정해봅니다:

* 프론트엔드(Front-end) 개발
* 백엔드(Back-end) 개발
* DevOps 작업

각 작업 유형마다 필요한:

* 코드
* 문서
* 이미지
* Tool (예: Model Context Protocol, MCP — 뒤에서 다룸)

작업들이 서로 다를 수 있습니다.

이를 잘 정리해두면, 컨텍스트 설계(Context Engineering) 관점에서도 매우 효율적인 세션 구성이 가능해집니다.

#### 1.2 이전 방식: Profiles

Amazon Q CLI의 이전 버전에서는 이를 Profiles(프로파일)로 정의했습니다.

이 방식도 유용했지만, 몇 가지 제약 사항이 있었습니다.

#### 1.3 Custom Agents의 개선점

Custom Agents는 이러한 프로파일 방식의 단점을 보완하며,

다음과 같은 방식으로 작업을 간소화해줍니다:

* 작업에 필요한 리소스(resources)와 도구(tools)를 하나의 에이전트에 구성
* 각 도구에 대해 권한 설정(permissions) 가능
* 구성된 에이전트를 공유 가능, 협업에 용이
* 각 작업 유형에 맞게 최소한의 컨텍스트만 로딩하여 효율 극대화

Custom Agents는 Kiro CLI에서 작업별로 최적화된 구성 세트를 만들고 관리할 수 있는 고급 기능이며, Context Engineering의 핵심 도구 중 하나입니다.

***

## 2. MCP (Model Context Protocol)

MCP(Model Context Protocol)는 AI 애플리케이션을 다양한 도구(Tools) 및 데이터 소스(Data Sources)에 표준 방식으로 연결할 수 있도록 해주는 프로토콜입니다.

비유하자면, MCP는 AI 애플리케이션의 USB-C 포트와 같습니다. USB-C가 다양한 기기와 액세서리를 일관된 방식으로 연결하듯, MCP는 AI 앱과 외부 도구/데이터 소스를 연결하는 표준 인터페이스를 제공합니다.

### 2.1 핵심 구성 요소

MCP는 Client-Server 아키텍처를 따르며, 3가지 주요 구성 요소로 이루어집니다:

<table data-header-hidden><thead><tr><th width="158.61248779296875"></th><th></th></tr></thead><tbody><tr><td>구성 요소</td><td>설명</td></tr><tr><td>MCP Host</td><td>AI 애플리케이션 자체 (예: Amazon Q CLI)  AI 모델과 상호작용 환경을 제공하며, MCP Client를 실행</td></tr><tr><td>MCP Client</td><td>Host 내에서 실행되며, MCP Server와의 통신을 담당</td></tr><tr><td>MCP Server</td><td>도구 또는 데이터 소스를 노출하는 컴포넌트  외부 기능을 제공하며, MCP Tool들을 포함함</td></tr></tbody></table>

### 2.2 동작 흐름 (참조: 첨부된 다이어그램)

1. 사용자(User)가 Amazon Q CLI에 자연어를 질의.
2. Hook가 설정된 경우, Hook 참조
3. 자연어는 프롬프트(prompt)로 변환되어 LLM으로 전달
4. LLM (Kiro + Bedrock) 기반의 사용자 쿼리 이해 및 의도 분석
5. 추가 컨텍스트가 필요할 경우, Kiro CLI는 MCP Tool을 호출
6. MCP Client가 MCP Server의 MCP Tool에 call 전송
7. MCP Tool은 데이터 소스(Data Source)에 query 수행
8. 결과를 response로 수신
9. MCP Tool은 결과를 MCP Client로 반환
10. 결과는 Kiro CLI로 전달
11. Kiro CLI는 이를 바탕으로 최종 응답(final response) 생성
12. 사용자에게 결과를 반환

<figure><img src="../.gitbook/assets/image (1) (1).png" alt=""><figcaption></figcaption></figure>

***

#### 로컬 실행 vs 컨테이너 실행

{: .note }
####  “MCP Server는 항상 원격 서버인가?”  -  아니요. 대부분의 MCP Server는 로컬 프로세스(local process)로 실행됩니다.

**로컬 실행 방법:**

1. Native 실행:
   * 직접 라이브러리 또는 실행 파일 설치 후 실행
   * 빠르고 간편하지만 의존성 충돌 위험 존재
2. 컨테이너(Container) 실행:
   * Docker와 같은 환경에서 격리된 상태로 실행
   * 보안 격리, 의존성 충돌 방지, 재현성 높은 환경 보장
   * 실무에서는 컨테이너 기반 실행이 점점 더 선호되는 방식.

#### 보안 주의 사항 (Security Alert ⚠️)

MCP는 실행 가능한 외부 도구를 환경 내에서 직접 실행하므로, 보안 리스크(attack surface)가 생깁니다.

안전하게 MCP를 사용하는 방법:

* 신뢰할 수 있는 출처의 서버만 설치
* 도구 설명 및 주석(annotation)을 리뷰하고 승인할 것
* 민감한 설정은 환경 변수(environment variables)를 사용할 것
* MCP Server 및 Amazon Q CLI는 항상 최신 버전으로 유지
* 로그를 모니터링하여 비정상적 활동을 감시

#### Kiro CLI의 MCP 보안 모델 원칙

<table data-header-hidden><thead><tr><th width="255.73748779296875"></th><th></th></tr></thead><tbody><tr><td>원칙</td><td>설명</td></tr><tr><td>Explicit Permission (명시적 승인)</td><td>도구는 실행 전 사용자의 명시적 승인을 받아야 함</td></tr><tr><td>Local Execution (로컬 실행)</td><td>MCP 서버는 로컬에서만 실행됨</td></tr><tr><td>Isolation (격리)</td><td>각 MCP 서버는 별도 프로세스로 독립 실행</td></tr><tr><td>Transparency (투명성)</td><td>어떤 도구가 사용 가능하고, 어떤 기능을 수행하는지 사용자가 모두 확인 가능</td></tr></tbody></table>

***

## 3. Custom Agent 생성  

### 3.1 Custom Agents란?

Custom Agent(커스텀 에이전트)는 Amazon Q CLI의 동작 방식을 특정 목적(use case)에 맞게 맞춤 설정할 수 있도록 해주는 기능입니다. 

각 커스텀 에이전트는 JSON 구성 파일(configuration file)로 정의되며, 다음과 같은 항목들을 포함할 수 있습니다:

* 사용할 도구(tools) 목록
* 도구에 대한 권한 설정(permissions)
* 사용할 컨텍스트(context) 정보 (예: 마크다운 문서) 등

### 3.2 Global vs Project Custom Agents

커스텀 에이전트는 전역(Global) 또는 프로젝트(Local) 범위로 생성할 수 있습니다:

<table data-header-hidden><thead><tr><th width="241.5374755859375"></th><th></th><th></th></tr></thead><tbody><tr><td>유형</td><td>설명</td><td>경로</td></tr><tr><td>Global Custom Agent</td><td>모든 디렉터리 및 프로젝트에서 사용 가능</td><td>~/.kiro/agents/{agent-name}.json</td></tr><tr><td>Project-level Custom Agent</td><td>특정 프로젝트 디렉터리 및 하위 디렉터리에서만 사용 가능</td><td>./.kiro/agents/{agent-name}.json</td></tr></tbody></table>

Git 등을 통해 프로젝트를 공유할 경우, Project Custom Agent를 사용하면 다른 개발자도 동일한 구성을 사용할 수 있습니다.

### 3.3 에이전트 우선순위 (Precedence)

1. 현재 디렉터리에서 로컬 커스텀 에이전트 확인
2. 없다면 글로벌 커스텀 에이전트 확인
3. 둘 다 없으면 기본 에이전트(q\_cli\_default) 사용<br>

⚠️ 주의:

이름이 동일한 로컬/글로벌 에이전트가 존재할 경우, 로컬 에이전트가 우선됩니다.

이 경우 다음과 같은 경고 메시지가 출력됩니다:

```
WARNING: Agent conflict for my-agent. Using workspace version.
```

### Task-01:  기본 에이전트

#### 기본 에이전트 확인

기본적으로 Kiro CLI는 `kiro_default` 라는 내장 에이전트를 사용합니다.

아래 명령으로 현재 사용 가능한 모든 에이전트를 확인할 수 있습니다:

```
/agent list
```

🔍 예시 출력 :

```
> /agent list

* kiro_default    (Built-in)
```

#### `/agent` :  명령어 옵션 확인

모든 agent 관련 명령은 /agent 명령어로 관리합니다:

```
/agent help
```

<table data-header-hidden><thead><tr><th width="151.9781494140625"></th><th></th></tr></thead><tbody><tr><td>명령어</td><td>설명</td></tr><tr><td>list</td><td>사용 가능한 모든 에이전트 나열</td></tr><tr><td>create</td><td>새 에이전트 생성</td></tr><tr><td>edit</td><td>기존 에이전트 수정</td></tr><tr><td>generate</td><td>AI를 활용하여 에이전트 생성</td></tr><tr><td>schema</td><td>에이전트 JSON 구성 스키마 확인</td></tr><tr><td>set-default</td><td>기본 에이전트 설정</td></tr><tr><td>swap</td><td>세션 중 다른 에이전트로 전환</td></tr></tbody></table>

### 3.4 Agent Schema

Amazon Q CLI 세션에서 아래 명령을 입력하면 해당 스키마 전체를 확인할 수 있습니다:

```
/agent schema
```

이 명령어를 입력하면, 커스텀 에이전트를 구성하는 데 사용되는 JSON 스키마 전체가 출력됩니다.

그러나 처음에는 모든 항목을 다 정의할 필요는 없으며, 점진적으로 확장해나가는 것이 좋습니다.

#### 주요 JSON 설정 항목 요약

아래는 커스텀 에이전트 JSON 파일에서 정의할 수 있는 주요 항목들입니다:

<table data-header-hidden><thead><tr><th width="177.981201171875"></th><th></th></tr></thead><tbody><tr><td>항목</td><td>설명</td></tr><tr><td>name <em>(필수)</em></td><td>에이전트의 이름을 정의합니다. 반드시 설정해야 합니다.</td></tr><tr><td>description <em>(선택)</em></td><td>에이전트에 대한 설명을 추가할 수 있습니다.</td></tr><tr><td>prompt <em>(선택)</em></td><td>에이전트에 부여할 초기 컨텍스트를 정의합니다. 시스템 프롬프트와 유사한 역할을 합니다.</td></tr><tr><td>mcpServers <em>(선택)</em></td><td>이 에이전트에 사용할 MCP 서버들을 설정합니다.</td></tr><tr><td>tools <em>(선택)</em></td><td>Amazon Q CLI 세션에서 사용할 수 있는 툴을 정의합니다. (예: "*"는 전체 허용)</td></tr><tr><td>toolAliases <em>(선택)</em></td><td>여러 MCP 서버 사용 시 툴 이름 충돌을 방지하기 위한 별칭 매핑을 정의합니다.</td></tr><tr><td>allowedTools <em>(선택)</em></td><td>자동으로 신뢰할 수 있는 툴을 설정합니다. 예: fs_read</td></tr><tr><td>resources <em>(선택)</em></td><td>추가 컨텍스트 리소스를 Markdown 문서 형식으로 추가할 수 있습니다. (예: file://.amazonq/rules/**/*.md)</td></tr><tr><td>hooks <em>(선택)</em></td><td>세션마다 또는 프롬프트마다 실행할 명령어를 정의할 수 있습니다. (이후 실습에서 자세히 다룸)</td></tr><tr><td>toolsSettings <em>(선택)</em></td><td>이 설정이 명시되지 않으면 기본값은 true이며, 구버전 mcp.json 파일을 로드하려는 시도를 합니다.</td></tr><tr><td>model <em>(선택)</em></td><td>이 커스텀 에이전트가 사용할 모델을 지정합니다. 미지정 시, settings.json에 설정된 기본 모델이 사용됩니다.</td></tr></tbody></table>

***

## 4. 커스텀 에이전트(Custom Agents) 생성하기

“python-developer” — 파이썬 코드 작성을 위한 구체적인 가이드라인을 규칙(Rule)로 불러오는 커스텀 에이전트입니다. 

### Task-02: 커스텀 에이전트 생성하기

Amazon Q CLI 세션에서, 아래 명령어를 입력합니다:

```
/agent create --name python-developer
```

이 명령을 실행하면, 시스템의 기본 에디터가 실행됩니다 (macOS/Linux는 기본적으로 vim).

예시 출력 :

```
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {},
  "tools": [
    "*"
  ],
  "toolAliases": {},
  "allowedTools": [],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {},
  "toolsSettings": {},
  "useLegacyMcpJson": true,
  "model": null
}
```

#### 생성 확인

```
/agent list
```

예시 출력 :

```
> /agent list

  python-developer    /home/ec2-user/.kiro/agents
* kiro_default        (Built-in)
```

####  에이전트 수정하기

```
/agent edit --name python-developer
```

이전과 동일한 JSON 설정이 열리며, 수정 후 저장 또는 단순히 종료할 수 있습니다.

#### 에이전트 적용하여 실행

kiro cli 세션을 종료하고, 아래 명령으로 다시 kiro cli 에 접속해 봅니다.

```
kiro-cli --agent python-developer
```

실행하면, 프롬프트 앞에 \[python-developer] 가 붙은 것을 볼 수 있습니다.

이는 현재 어떤 에이전트가 활성화되어 있는지를 나타내는 시각적 표시입니다.

```
[python-developer] >
```

현재 로드된 컨텍스트 확인:

에이전트에 로드된 컨텍스트를 확인하려면 다음 명령어를 실행합니다:

```
/context show
```

예시 출력:

```
[python-developer] > /context show

Agent (python-developer)
  - AGENTS.md (no matches)
  - README.md (no matches)

Session (temporary)
  <none>
```

***

## 5. `/agent generate` 명령어로 자동 생성하기 (v1.15+)

Kiro CLI v1.15부터 도입된 새로운 명령어 `/agent generate`는 커스텀 에이전트(Custom Agent) 생성을 보다 쉽게 만들어 줍니다.

이 명령어는 설정 과정을 단계적으로 안내하며, 최종적으로는 JSON 에디터로 이동해 필요한 수정을 할 수 있도록 합니다.

Kiro CLI 세션에서 다음 명령어를 입력하세요:

```
/agent generate
```

질문에 따라 입력:

```
✔ Enter agent name: python-dev
✔ Enter agent description: Python developer
✔ Agent scope: Local (current workspace)
```

자동 생성된 구성 예시:

```
{
  "name": "python-dev",
  "description": "Python developer",
  "prompt": "You are a Python developer assistant. Help with Python programming tasks including writing, debugging, testing, and optimizing Python code. Provide best practices, explain concepts, and assist with Python libraries and frameworks.",
  "mcpServers": {},
  "tools": [
    "*"
  ],
  "toolAliases": {},
  "allowedTools": [],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {},
  "toolsSettings": {},
  "useLegacyMcpJson": false,
  "model": null
}
```

📝 `/agent create` 와는 달리, `/agent generate` 는 자동으로 prompt도 생성해줍니다.

#### 특정 모델 연결하기

원하는 모델을 지정하려면 model 필드를 설정:

```
"model": "claude-3.5-sonnet"
```

지원 모델 예시:

* "claude-3.5-sonnet"
* "claude-sonnet-4"
* null (기본 설정값 사용)

####  요약

<table data-header-hidden><thead><tr><th width="249.65936279296875"></th><th></th></tr></thead><tbody><tr><td>작업</td><td>명령어</td></tr><tr><td>커스텀 에이전트 생성</td><td>/agent create --name &#x3C;name></td></tr><tr><td>자동 생성 (AI 기반)</td><td>/agent generate</td></tr><tr><td>사용 중인 에이전트 목록 보기</td><td>/agent list</td></tr><tr><td>구성 편집</td><td>/agent edit --name &#x3C;name></td></tr><tr><td>적용하여 실행</td><td>q chat --agent &#x3C;name></td></tr><tr><td>컨텍스트 확인</td><td>/context show</td></tr></tbody></table>

이제  Kiro CLI에서 자신만의 커스텀 에이전트 환경을 구성하고 적용할 수 있습니다.

***

## 6. Custom Agent 구성 (Tool & Trust)

### Task 03 : Tools 및 권한 구성하기

이전 실습에서는 Kiro CLI에서 사용할 수 있는 도구(tools)와 신뢰(trust) 설정에 대해 알아보았습니다.

기본 커스텀 에이전트인 kiro\_default는 Kiro CLI에 내장된 모든 도구를 사용할 수 있도록 되어 있습니다.

하지만 새로 생성한 Custom Agent(예: python-developer)는 기본적으로 아무 도구도 포함하고 있지 않습니다.

#### 현재 세션에서 사용 가능한 도구 확인

```
/tools
```

출력 예시:

```
[python-developer] > /tools

Tool       Permission
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Built-in:
```

* 아무 도구도 활성화되지 않았습니다.

이는 현재 세션에서는 파일을 읽거나 쓰거나, 명령어 실행, AWS CLI 사용 등 아무 작업도 할 수 없다는 의미입니다.

***

## 7. Custom Agent 설정 파일 수정

이제 tools 항목을 설정하여 Amazon Q CLI의 기본 내장 도구들을 사용할 수 있도록 변경해 보겠습니다.

#### 🔍 JSON 파일 위치 확인

이전에 다음과 같은 명령으로 custom agent를 생성했습니다:

```
/agent create --name python-developer
```

* 이 방법은 Global Custom Agent를 생성하므로 JSON 설정 파일은 다음 경로에 저장됩니다:

```
~/.kiro/agents/python-developer.json
```

#### tools 설정 확인

```
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {},
  "tools": [
    "*"
  ],
  "toolAliases": {},
  "allowedTools": [],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {},
  "toolsSettings": {},
  "useLegacyMcpJson": true,
  "model": null
}
```

<table data-header-hidden><thead><tr><th width="181.29998779296875"></th><th></th></tr></thead><tbody><tr><td>키</td><td>설명</td></tr><tr><td>"tools"</td><td>"@builtin"은 Amazon Q CLI의 모든 내장 도구를 활성화합니다.</td></tr><tr><td>"*"</td><td>와일드카드로 모든 도구를 허용</td></tr><tr><td>"execute_bash"</td><td>bash 명령 실행</td></tr><tr><td>"fs_read"</td><td>파일 시스템 읽기</td></tr><tr><td>"fs_write"</td><td>파일 시스템 쓰기</td></tr><tr><td>"report_issue"</td><td>GitHub issue 생성</td></tr><tr><td>"use_aws"</td><td>AWS CLI 명령 실행</td></tr></tbody></table>

## 8. 기본 권한 설정 변경하기

기본적으로 일부 도구는 “`not trusted`” 상태로 시작합니다.

이제 `allowedTools` 항목을 설정하여, 특정 도구를 자동으로 신뢰할 수 있도록 변경해 봅니다.

####  JSON 수정

```
{
  "name": "python-developer",
  "prompt": null,
  "mcpServers": {},
  "tools": ["@builtin"],
  "toolAliases": {},
  "allowedTools": ["fs_read", "fs_write", "use_aws"],
  "resources": [
    "file://.amazonq/rules/**/*.md"
  ],
  "hooks": {},
  "toolsSettings": {}
}
```

#### 🔁 다시 Amazon Q CLI 재시작

```
kiro-cli --agent python-developer
```

#### 🔍 권한 상태 재확인

```
/tools
```

변경된 출력 예시:

```
[python-developer] > /tools

Tool              Permission
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔Built-in
- shell           not trusted
- read            trusted
- write           trusted
- introspect      trusted
- report          not trusted
- aws             trusted
- web_fetch       not trusted
- web_search      not trusted
```

이제 fs\_write 및 use\_aws도 기본적으로 신뢰(trusted) 상태입니다.

#### Task04 - 기본 Custom Agent 설정하기

Amazon Q CLI를 실행할 때 매번 `--agent` 옵션을 쓰지 않고, 기본 커스텀 에이전트를 `python-developer`로 변경해 봅니다.

* 기본 에이전트 설정 명령

```
/agent set-default -n python-developer
```

출력 예시:

```
✓ Default agent set to 'python-developer'. This will take effect the next time q chat is launched.
```

* 재시작하여 확인

```
kiro-cli
```

\[python-developer] > 프롬프트가 나타나면 성공!

#### 설정 파일 확인 (선택)

```
kiro-cli settings list
```

설정 파일에 다음 항목이 추가되어 있어야 합니다:

```
chat.defaultAgent = "python-developer"
```

***

9\. Custom Agent 간 전환하기<br>
---------------------------

세션 도중에 커스텀 에이전트를 바꾸고 싶을 때는 다음 명령으로 가능합니다:

```
/agent swap {agent-name}
```

예:

```
/agent swap python-dev
```

에이전트를 전환하면 MCP 서버 연결, 도구 및 권한 설정, 컨텍스트 리소스 등이 모두 자동으로 적용됩니다.

#### 요약

| 작업          | 명령어                          |
| ----------- | ---------------------------- |
| 현재 도구 보기    | /tools                       |
| 도구 활성화      | JSON에서 "tools" 설정            |
| 기본 도구 신뢰 설정 | JSON에서 "allowedTools" 설정     |
| 기본 에이전트 설정  | /agent set-default -n {name} |
| 에이전트 간 전환   | /agent swap {name}           |

#### 보안 관련 주의사항

* 도구 권한은 가능한 최소한으로 설정하세요.
* 특히 execute\_bash, fs\_write, use\_aws와 같은 도구는 신중하게 신뢰 설정을 하세요.
* 팀과 공유할 때는 보안 규칙을 문서화하고 검토할 것을 권장합니다.

이제  Amazon Q CLI의 커스텀 에이전트에서 사용할 도구와 권한을 정교하게 제어할 수 있습니다.

이 구성은 에이전트마다 다르게 설정할 수 있어, 다양한 프로젝트에 맞춰 최적화된 환경을 만들 수 있습니다.

***

## 10. Context Hooks 구성

#### Context Hook이란?

Context Hook은 Kiro CLI에서 대화 중에 자동으로 컨텍스트(문맥)를 주입할 수 있는 기능입니다.

Hook은 명령어(command)를 실행한 결과를 컨텍스트로 포함시켜, Kiro CLI가 더 정확하고 상황에 맞는 응답을 할 수 있도록 돕습니다.

이러한 Context Hook은 Custom Agent 내부에서 구성합니다.

#### Kiro CLI는 다음과 같은 4가지 유형의 Context Hook을 지원합니다:

<table data-header-hidden><thead><tr><th width="175.98431396484375"></th><th></th></tr></thead><tbody><tr><td>Hook 유형</td><td>설명</td></tr><tr><td>agentSpawn</td><td>대화 세션 시작 시 한 번만 실행. 결과는 전체 세션 동안 유지되는 컨텍스트로 추가됩니다.</td></tr><tr><td>userPromptSubmit</td><td>사용자의 프롬프트가 제출될 때마다 실행. 해당 프롬프트에만 결과가 포함됩니다.</td></tr><tr><td>preToolUse</td><td>도구(tool)가 실행되기 전에 실행됨. 도구 실행을 검증하거나 차단할 때 유용합니다.</td></tr><tr><td>postToolUse</td><td>도구 실행 후 결과가 반환될 때 실행됨. 도구 출력값을 후처리할 수 있습니다.</td></tr></tbody></table>

📘 추가 제약사항은 [Behavior and limitations](https://docs.aws.amazon.com) 문서를 참조하세요.

#### 🔎 현재 세션에서 Hook 확인하기

```
/hooks
```

출력 예시:

```
[python-developer] > /hooks

No hooks are configured.
```

### Task-05: Per-Prompt Hook 만들기 (Pirate Style)

\
이번 실습에서는 매번 프롬프트를 제출할 때마다 해적처럼 말하고 유머를 섞도록 하는 Hook을 만들어 보겠습니다.

#### 1. pirate.md  파일 생성

Kiro CLI를 종료한 뒤, 현재 디렉토리에 pirate.md 파일을 만들고 아래 내용을 작성합니다:

```
cat << EOF > ~/pirate.md
답변을 할 때 한국어로 답변하고, 유머러스하게 반말로 답변해줘.
EOF
```

#### 2. Custom Agent JSON 수정

기존의 python-developer 에이전트 설정 파일을 아래와 같이 수정합니다:

<pre><code>{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {},
  "tools": [
    "*"
  ],
  "toolAliases": {},
  "allowedTools": ["fs_read", "fs_write", "use_aws"],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
<strong>  "hooks": {
</strong>    "userPromptSubmit": [
      {
        "command": "cat pirate.md"
      }
    ]
  },
  "toolsSettings": {},
  "useLegacyMcpJson": true,
  "model": null
}
</code></pre>

#### 3. Amazon Q CLI 재시작 및 Hook 확인

```
q chat --agent python-developer
/hooks
```

출력 예시:

```
[python-developer] > /hooks

userPromptSubmit:
  - cat pirate.md
```

#### 4️. 테스트 프롬프트 입력

```
“당신이 사용 중인 모델은 무엇인가요?”
```

출력 결과에 해적 말투와 유머가 포함되는지 확인해 보세요!

출력 예시

```
나는 AWS가 만든 AI 어시스턴트 Kiro야! 근데 솔직히 말하면... 내가 정확히 어떤 모델 기반인지는 AWS가 비밀로 하고 있어서 나도 몰라 ㅋㅋ 

뭐 중요한 건 모델 이름보다는 내가 뭘 할 수 있냐는 거 아니겠어? 파일 읽고 쓰고, 배시 명령어 실행하고, AWS 리소스 관리하고, 코드 짜고... 이런 거 다 할 수 있으니까 필요한 거 있으면 편하게 말해봐! 😎
```

이 Hook은 cat pirate.md의 출력이 매 프롬프트마다 컨텍스트로 주입되기 때문에 동작합니다.

#### 5. Session 시작 시 실행되는 Hook : agentSpawn

이번에는 Amazon Q CLI 세션을 시작할 때 자동으로 실행되는 Hook을 설정해보겠습니다.

예: 현재 시간과 날짜를 컨텍스트에 포함시키기

```
  "hooks": {
        "agentSpawn": [
     {
       "command": "aws sts get-caller-identity"
     }
    ]
```

📌 agentSpawn Hook은 대화가 시작될 때 한 번만 실행되며, 그 출력은 전체 세션의 고정 컨텍스트가 됩니다.

## 11. Tool 관련 Hook 설정하기

\
Kiro CLI에서 사용 가능한 도구들(ex: fs\_write, execute\_bash)에 대해 도구 실행 전후에 Hook을 설정할 수 있습니다.

이때는 Hook 설정에 matcher 필드를 추가로 사용합니다.

#### 예시: preToolUse, postToolUse

```
"hooks": {
  "preToolUse": [
    {
      "matcher": "execute_bash",
      "command": "{ echo \"$(date) - Bash command:\"; cat; echo; } >> /tmp/bash_audit_log"
    }
  ],
  "postToolUse": [
    {
      "matcher": "fs_write",
      "command": "cargo fmt --all"
    }
  ]
}
```

<table data-header-hidden><thead><tr><th width="137.5843505859375"></th><th></th></tr></thead><tbody><tr><td>Hook 타입</td><td>설명</td></tr><tr><td>preToolUse</td><td>execute_bash가 실행되기 전에 실행됨. 실행 커맨드를 /tmp/bash_audit_log에 기록</td></tr><tr><td>postToolUse</td><td>fs_write 실행 이후에 cargo fmt로 코드 포맷팅 수행</td></tr></tbody></table>

📌 matcher 필드는 Hook이 어떤 도구에 연동되는지를 명시합니다.

### 요약

| Hook 유형    | 키 값              | 실행 시점             | 사용 예         |
| ---------- | ---------------- | ----------------- | ------------ |
| Session 시작 | agentSpawn       | Amazon Q CLI 실행 시 | 환경 준비, 날짜 기록 |
| 프롬프트 전     | userPromptSubmit | 사용자 입력 시          | 맥락 설정, 말투 변경 |
| 도구 실행 전    | preToolUse       | 도구 실행 직전          | 로깅, 차단       |
| 도구 실행 후    | postToolUse      | 도구 실행 직후          | 포맷팅, 검증      |

### 참고

* .md 파일, 쉘 커맨드 등 자유롭게 Hook에 활용 가능
* Hook 설정은 Custom Agent마다 독립적으로 구성됩니다
* 민감 작업 시에는 로깅 또는 사전 검증 Hook을 추천합니다

이제  Amazon Q CLI에서 Context Hook을 자유자재로 구성할 수 있습니다. 이를 통해 보다 동적인 세션 운영과 컨텍스트 기반 개발 지원이 가능합니다.

***

## 12. MCP Servers 설정

앞서 이 실습의 초반부에서 MCP(Model Context Protocol)와 Kiro CLI에서 이를 세션에 통합하는 방법에 대해 소개했습니다. 지금까지 Custom Agent(사용자 정의 에이전트)를 사용하여 context 제공을 위한 리소스를 추가하고, 사용할 수 있는 tools(도구) 설정 방법과 context hooks(후크) 생성 방법을 배웠습니다. 이 모든 작업은 Custom Agent의 JSON 구성 파일을 편집하여 수행되었습니다.

MCP Server는 Tools, Resources, Prompts를 노출할 수 있으며, Kiro CLI는 이 중 Tools와 Prompts를 사용할 수 있습니다.

Tools를 제공하는 MCP Server를 추가하면, 이는 Amazon Q CLI의 기존 도구들과 동일하게 동작하며, 접근 제어와 권한 설정도 동일한 방식으로 관리할 수 있습니다.

이번 실습에서는 우리가 이전에 설정한 "python-developer" Custom Agent에 AWS Documentation MCP Server를 추가해보겠습니다. 이 MCP Server는 다양한 AWS 문서를 검색하고 읽을 수 있는 도구를 제공합니다.

```json
{
  "mcpServers": {
    "awslabs.aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "AWS_DOCUMENTATION_PARTITION": "aws"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

AWS MCP Servers 목록은 [AWS MCP Server Directory](https://github.com/awslabs/amazon-q-devtools-mcp-servers)에서 확인할 수 있으며, 각 MCP Server가 제공하는 기능 및 설치 방법도 포함되어 있습니다.

#### Task-06: MCP Server 통합

기존의 `python-developer` 에이전트 구성에 위의 `mcpServers` 블록을 추가합니다.

```
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {
    "awslabs.aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "AWS_DOCUMENTATION_PARTITION": "aws"
      }
    }
  },
  "tools": [
    "*"
  ],
  "toolAliases": {},
  "allowedTools": ["fs_read", "fs_write", "use_aws"],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {
    "userPromptSubmit": [
      {
        "command": "cat pirate.md"
      }
    ],
    "agentSpawn": [
     {
       "command": "aws sts get-caller-identity"
     }
    ]
  },
  "toolsSettings": {},
  "useLegacyMcpJson": true,
  "model": null
}
```

 추가 후 Amazon Q CLI를 다시 시작하면 MCP 서버가 초기화되며, 다음과 같은 메시지가 출력됩니다:

```
⠏ 0 of 1 mcp servers initialized. ctrl-c to start chatting now
```

세션이 시작된 후, `/mcp` 명령어로 MCP Server가 정상적으로 로드되었는지 확인합니다:

```
/mcp
```

출력 예:

```
[python-developer] > /mcp

awslabs.aws-documentation-mcp-server
✓ awslabs.aws-documentation-mcp-server loaded in 10.37 s
```

### MCP 서버 도구(Tools) 설정하기

MCP 서버를 통합하면 해당 서버가 제공하는 도구(Tools)을 사용할 수 있게 되며, /tools 명령어를 통해 확인할 수 있습니다. 이 MCP 도구(Tools)들도 Amazon Q CLI 내 기본 도구(Tools)과 동일하게 신뢰 여부(trusted/untrusted)를 설정할 수 있습니다.

#### Task-07: MCP Tools 구성 및 권한 설정

MCP Server가 정상적으로 로드되면 해당 MCP Server가 제공하는 도구들이 `/tools` 명령어를 통해 표시됩니다. 

도구(Tools) 목록을 확인합니다:

```
/tools
```

예시:

```
Tool                      Permission
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔Built-in
- shell                   not trusted
- read                    trusted
- write                   trusted
- introspect              trusted
- report                  not trusted
- aws                     trusted
- web_fetch               not trusted
- web_search              not trusted

awslabs.aws-documentation-mcp-server (MCP)
- read_documentation      not trusted
- recommend               not trusted
- search_documentation    not trusted
```

Custom Agent의 JSON 파일을 다음과 같이 수정하여,  특정 MCP Tools만 활성화하고 일부에 대해서만 신뢰 권한을 부여할 수 있습니다:

```json
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {
    "awslabs.aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "AWS_DOCUMENTATION_PARTITION": "aws"
      }
    }
  },
  "tools": [
    "fs_read",
    "fs_write",
    "use_aws",
    "@awslabs.aws-documentation-mcp-server/read_documentation",
    "@awslabs.aws-documentation-mcp-server/search_documentation"
  ],
  "toolAliases": {},
  "allowedTools": ["fs_read", "fs_write", "use_aws"],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {
    "userPromptSubmit": [
      {
        "command": "cat pirate.md"
      }
    ],
    "agentSpawn": [
     {
       "command": "aws sts get-caller-identity"
     }
    ]
  },
  "toolsSettings": {},
  "useLegacyMcpJson": true,
  "model": null
}
```

Amazon Q CLI를 재시작하고 `/tools` 명령어를 통해 구성 결과를 확인할 수 있습니다.

```
/tools

Tool                      Permission
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔Built-in
- read                    trusted
- write                   trusted
- aws                     trusted

awslabs.aws-documentation-mcp-server (MCP)
- read_documentation      not trusted
- search_documentation    not trusted
```

#### MCP Tool 테스트

프롬프트에 다음과 같이 입력해보세요:

```
MWAA 작업자 크기에 대한 AWS 문서를 확인해줘
```

`search_documentation` Tool은 신뢰되지 않은 상태이므로 실행 시 사용자에게 신뢰 여부를 묻게 됩니다.

 `t`를 입력하면 세션 전체에서 이 도구를 신뢰하게 되며, 이후 `read_documentation`은 미리 신뢰되어 바로 실행됩니다.

MCP 서버는 매우 강력하며, 다음과 같은 유연한 구성이 가능합니다:

* 도구 단위의 신뢰/비신뢰 설정
* MCP 서버별로 개별 도구(Tools) 허용
* 다양한 AWS 서비스 문서를 실시간 검색 및 활용

사용자 정의 에이전트를 통해 세션에 정교한 MCP 통합이 가능하며, 팀원들과 설정을 공유하여 일관성 있는 개발 환경을 만들 수 있습니다.  Custom Agent를 통해 MCP Server를 매우 유연하고 세밀하게 통합 및 제어할 수 있으며, 프로젝트에 맞는 MCP Tool만 선택적으로 활성화할 수 있어 협업 시 일관된 작업 환경을 제공할 수 있습니다.

***

## 13. 도구 이름 충돌 방지 - toolAliases 사용하기

Kiro CLI에 MCP 서버(MCP Server)를 추가할 때 고려해야 할 중요한 점 중 하나는 도구(Tools) 이름 충돌(tool name clash) 가능성입니다.

예를 들어, get\_issues라는 이름의 도구(Tools)이 있다고 가정해 보겠습니다. 여기에 GitHub와 GitLab MCP 서버를 통합하면, 두 서버 모두 동일한 이름의 툴(get\_issues)을 제공하게 됩니다. 이 경우, 어떤 MCP 서버의 도구(Tools)을 사용할지 명확히 지정해야 할 필요가 생깁니다.<br>

이러한 충돌을 관리하기 위해, 사용자 정의 에이전트(Custom Agent)의 JSON 구성 파일에서 toolAliases 항목을 사용하여 각 MCP 도구(Tools)에 대한 별칭(alias) 을 정의할 수 있습니다.

예시:

```
"toolAliases": {
  "@github-mcp/get_issues": "github_issues",
  "@gitlab-mcp/get_issues": "gitlab_issues"
}
```

이렇게 구성하면 충돌을 피하면서도 명확하게 도구를 사용할 수 있습니다.

## 14. toolAliases 를 활용한 도구 참조 방식 개선

앞에서 소개한 toolAliases는 단순히 네임스페이스 충돌을 해결하기 위한 용도 외에도, 개발자의 사용자 경험(Developer Experience, DX)을 개선하기 위한 수단으로도 사용할 수 있습니다.

예를 들어, 도구 이름이 너무 길거나 복잡하다면, 더 짧고 직관적인 이름으로 별칭을 부여할 수 있습니다.

예시:

```
{
  "toolAliases": {
    "@aws-cloud-formation/deploy_stack_with_parameters": "deploy_cf",
    "@kubernetes-tools/get_pod_logs_with_namespace": "pod_logs"
  }
}
```

이런 방식은 자주 사용하는 도구(Tools)에 대해 더 짧고 명확한 이름을 제공하므로, 명령어 입력 시 편의성을 높이고, 실수를 줄이며, 가독성도 향상시킬 수 있습니다.

📌 정리

* MCP 서버 통합 시 동일 이름의 도구(Tools)이 있을 수 있으므로 toolAliases로 충돌 방지 필요
* 개발자가 자주 사용하는 도구(Tools)의 이름을 더 짧고 기억하기 쉽게 별칭으로 정의 가능
* 에이전트 JSON 내 toolAliases 항목에서 구성

***

## 15. MCP 프롬프트 (MCP Prompts)

앞서 Kiro CLI에서 MCP 도구(MCP Tools) 를 어떻게 활용하는지 알아보았지만, Kiro CLI는 MCP 도구뿐 아니라 MCP 프롬프트(Prompts) 도 지원합니다. MCP 프롬프트는 /prompts 명령어를 통해 확인할 수 있으며, MCP 서버(MCP Server)에서 제공하는 프롬프트 리소스를 탐색하여 목록화합니다.

이 프롬프트들은 Kiro CLI 세션 내에서 @{prompt} 구문으로 호출하여 사용할 수 있습니다.

#### Task08: 사용자 정의 MCP 프롬프트 서버 생성

* **새로운 디렉토리 및 MCP 서버 코드 생성**

```
mkdir mcp-prompts
cd mcp-prompts
```

mcp-server.py라는 이름의 파일을 생성하고 다음 코드를 입력합니다:

```
cat << EOF > ./mcp-server.py
import asyncio
import sys

from mcp.server.fastmcp import Context, FastMCP

# MCP 서버 인스턴스 생성
mcp = FastMCP("QCLIPromptDemo")

@mcp.prompt()
def create_new_project() -> str:
    """A prompt that bootstraps a new project repository as per our requirements"""
    return f'Create a new project layout. Create a top level src directory, and in the src directory create subdirectories for templates, models, routes, and static. Add a README.md to the src directory.'

if __name__ == "__main__":
    mcp.run()
EOF
```

> 위 코드는 “create\_new\_project”라는 MCP 프롬프트를 하나 제공하는 매우 단순한 MCP 서버입니다. 필요에 따라 더 복잡하게 확장 가능합니다.

* **가상 환경 생성 및 의존성 설치**

```
uv init
uv add mcp "mcp[cli]"
```

***

이제 프롬프트(Prompts)를 제공하는 간단한 사용자 정의 MCP 서버가 준비되었습니다. 이를 사용하기 위한 구성은 아래와 같으며, {path to directory}는 앞서 MCP 서버를 생성한 디렉토리 경로로 바꾸어야 합니다. 예제에서는 해당 디렉터리를 'mcp-server'로 설정했습니다:

```
{
    "mcpServers": {
        "KiroCLIPromptDemo": {
            "command": "uv",
            "args": ["--directory", "{path to directory}", "run", "--with", "mcp", "mcp", "run", "main.py"]
        }
    }
}
```

LAB 환경에서는 아래와 같습니다.

```
    "KiroCLIPromptDemo": {
      "command": "uv",
      "args": ["--directory", "/home/ec2-user/mcp-prompts", "run", "--with", "mcp", "mcp", "run", "mcp-server.py"]
    }
```

이 MCP 서버를 기존의 사용자 정의 에이전트 JSON 설정 파일에 추가해주어야 합니다. 이 실습 전반에 걸쳐 사용해온 에이전트를 계속 활용해도 되고, 새롭게 생성한 에이전트를 사용해도 무방합니다.

```
pwd
```

위 명령어를 실행했을 때, 다음과 같은 작업 디렉터리 경로가 출력되었다고 가정합니다:

```
/home/ec2-user/mcp-prompts
```

이 경로는 MCP 서버 실행을 위한 --directory 인자에 사용해야 할 실제 경로입니다. JSON 설정 내 {path to directory} 자리에 이 경로를 그대로 대입하면 됩니다.

#### Custom Agent에 MCP 서버 추가

다음은 이 MCP 서버를 기존 Custom Agent 설정(python-developer)에 통합하는 JSON 예시입니다. 디렉토리 경로는 본인의 환경에 맞게 조정하십시오:

```
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {
    "awslabs.aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "AWS_DOCUMENTATION_PARTITION": "aws"
      }
    },
    "KiroCLIPromptDemo": {
      "command": "uv",
      "args": ["--directory", "/home/ec2-user/mcp-prompts", "run", "--with", "mcp", "mcp", "run", "mcp-server.py"]
    }
  },
  "tools": [
    "fs_read",
    "fs_write",
    "use_aws",
    "@awslabs.aws-documentation-mcp-server/read_documentation",
    "@awslabs.aws-documentation-mcp-server/search_documentation"
  ],
  "toolAliases": {},
  "allowedTools": ["fs_read", "fs_write", "use_aws"],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {
    "userPromptSubmit": [
      {
        "command": "cat pirate.md"
      }
    ],
    "agentSpawn": [
     {
       "command": "aws sts get-caller-identity"
     }
    ]
  },
  "toolsSettings": {},
  "useLegacyMcpJson": true,
  "model": null
}
```

>  MCP 서버 설정은 "mcpServers" 블록 내에 "QCLIPromptDemo" 항목으로 추가됩니다.

다음과 같이, 앞서 생성한 MCP 서버를 기존의 사용자 정의 에이전트(custom agent) 구성 파일에 추가한 것을 확인할 수 있습니다. 실습 사용자의 경우에는 MCP 서버를 생성한 디렉터리 경로가 다를 수 있으므로, 해당 부분은 환경에 맞게 수정해야 합니다.

```
    "KiroCLIPromptDemo": {
      "command": "uv",
      "args": ["--directory", "/home/ec2-user/mcp-prompts", "run", "--with", "mcp", "mcp", "run", "mcp-server.py"]
    }
```

#### Kiro CLI 세션 시작 및 MCP 확인



위 JSON 파일을 저장한 뒤, 아래 명령어로 Q CLI 세션을 시작합니다:

```
kiro-cli --agent python-developer
```

정상적으로 시작되면 아래와 같은 메시지를 볼 수 있습니다:

/tools 명령어를 실행해 보면, 이전과 동일한 출력이 나타나야 합니다. 이번에 추가한 MCP 서버는 새로운 툴(tools)을 제공하지 않았기 때문입니다. 대신, 프롬프트(prompts) 를 추가했습니다.

그렇다면 이 프롬프트는 어떻게 확인할 수 있을까요? 간단합니다 — Amazon Q CLI 세션 내에서 `/prompts` 명령어를 사용하면 됩니다.

프롬프트에서 다음과 같이 입력하세요:

```
> /prompts list


Usage: You can use a prompt by typing '@<prompt name> [...args]'


Prompt                Description                              Arguments (* = required)
▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔
Global:
/home/ec2-user/.kiro/prompts/proj-setup.md

Local:
/home/ec2-user/.kiro/prompts/proj-setup.md (overrides global)

KiroCLIPromptDemo (MCP):
- create_new_project 
```

이제 실제로 실행해볼 차례입니다. 새로운 > 프롬프트에서 다음 명령어를 입력하세요:

```
@create_new_project
```

그러면 다음과 같은 출력이 생성될 것입니다:

```
> @create_new_project

프로젝트 구조를 만들어드릴게요! 웹 애플리케이션 같은 느낌이 나는데, 한번 뚝딱 만들어보겠습니다 🛠️
```

이제 출력 내용을 따라가며 확인해보세요 — 파일을 생성해야 하기 때문에 권한 허용 요청이 나타날 수 있습니다. 참고로, 이 커스텀 에이전트는 fs\_write 권한이 부여되지 않았기 때문에, 파일 쓰기 작업에는 별도의 승인이 필요할 수 있습니다.

작업이 완료되면, 생성된 결과물을 확인해보세요. 함수에 정의된 프롬프트 내용과 비교해보았을 때, 요청한 구조대로 프로젝트가 잘 생성되었는지 검토해보세요.

***

## 16. Disabling MCP Servers

MCP 서버를 비활성화하려면, 커스텀 에이전트 JSON 구성 파일을 수정하고 "disabled" 설정 항목을 추가하여 true로 지정하면 됩니다. (기본값은 false입니다.)

### Task-09

다음과 같이 커스텀 에이전트 JSON 파일을 수정하세요:

```
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {
    "awslabs.aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "AWS_DOCUMENTATION_PARTITION": "aws"
      },
      "disabled": true
    },
```

#### 변경 후 해야 할 일

* 설정 파일을 저장하세요.
* Kiro CLI 세션을 재시작하세요.<br>

그 후, 화면 상단에 다음과 같은 메시지를 확인할 수 있어야 합니다:

```
$ k
○ awslabs.aws-documentation-mcp-server is disabled
✓ KiroCLIPromptDemo loaded in 0.45 s
```

이로써 해당 MCP 서버가 현재 세션에서 비활성화된 것을 확인할 수 있습니다.

***

### 조직 차원의 MCP 비활성화 (Disabling MCP for your organisation) 

MCP 서버(MCP Servers)는 Amazon Q CLI와 같은 AI 코딩 에이전트에게 강력한 기능을 제공하지만, 앞서 설명했듯 보안 측면에서의 위험성도 내포하고 있습니다.

일부 조직에서는 이러한 위험 요소를 감수할 수 없다고 판단하여, 조직 단위에서 MCP 서버 구성을 완전히 비활성화하고자 할 수 있습니다.

***

#### 조직 차원의 MCP 비활성화 기능

이 기능은 회사/프로페셔널 계정으로 로그인한 사용자에게만 제공됩니다. Kiro 관리(Admin) 화면에서 다음과 같은 토글 스위치를 통해 MCP 서버 사용 여부를 제어할 수 있습니다:

<figure><img src="../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>

#### 관리자가 MCP를 비활성화했을 경우

조직 관리자에 의해 MCP 서버 기능이 꺼진 상태에서, MCP 서버가 구성된 Custom Agent를 포함한 Amazon Q CLI 세션을 시작하게 되면, 다음과 같은 경고 메시지가 출력됩니다:

```
⚠️  WARNING: MCP functionality has been disabled by your administrator.
```

이 설정은 전역(Global) 설정으로 동작하므로, 한 번 비활성화하면 조직 내 모든 사용자 계정에 적용됩니다.



* MCP 서버는 강력하지만 민감한 기능 → 조직 정책에 따라 제한 가능
* 중앙 관리자(Admin Console)에서 제어 가능
* 비활성화 시, 모든 사용자에게 적용됨
* CLI 실행 시 경고 메시지로 확인 가능

필요 시 관리 화면에서 정책을 다시 활성화하거나, MCP 기능 없이도 Custom Agent를 사용할 수 있도록 구성할 수 있습니다.

***

## 17. Kiro CLI에서 Tool에 대한 세분화된 권한 설정 

이전 실습에서 Custom Agent(사용자 정의 에이전트) 안에서 어떤 Tool(도구) 을 사용할 수 있을지와, 그에 따른 기본 권한을 어떻게 부여할 수 있는지를 살펴보았습니다.

하지만, 다음과 같은 더 세밀한 권한 제어(Fine-Grained Permission Control)가 필요할 수 있습니다:

> 예시: execute\_bash라는 도구는 Bash 명령어를 실행할 수 있습니다. 하지만 이 중에서 git status, git fetch 같은 명령어만 허용하고, git push, git commit은 막고 싶다면?

#### toolsSettings:  도구별 세부 권한 제어 설정

이를 위해 toolsSettings라는 항목을 custom agent JSON 설정 파일 내에 추가할 수 있으며, 각 도구별로 다음과 같은 권한 필드를 정의할 수 있습니다:

**내장 도구(Built-in Tools)의 세부 권한 설정 예시:**

<table data-header-hidden><thead><tr><th width="184.23440551757812"></th><th></th></tr></thead><tbody><tr><td>Tool 이름</td><td>지원 설정 항목 예시</td></tr><tr><td>fs_read, fs_write</td><td>allowedPaths, deniedPaths</td></tr><tr><td>use_aws</td><td>allowedServices, deniedServices</td></tr><tr><td>execute_bash</td><td>allowedCommands, deniedCommands, allowReadOnly</td></tr></tbody></table>

**예시:  execute\_bash - 도구의 권한 설정**

```
"toolsSettings": {
  "execute_bash": {
    "allowedCommands": ["git status", "git fetch"],
    "deniedCommands": ["git commit .*", "git push .*"],
    "allowReadOnly": true
  }
}
```

* allowedCommands: 허용할 명령어 목록 (정확히 일치하거나 정규식 사용 가능)
* deniedCommands: 차단할 명령어 목록 (정규식 가능)
* allowReadOnly: 읽기 전용 명령 허용 여부

***

### MCP 서버 도구(MCP Server Tools)의 세부 설정

MCP 서버를 통해 추가된 도구도 동일한 방식으로 설정할 수 있습니다.

단, 해당 MCP 도구가 어떤 설정 옵션을 제공하는지는 MCP Server 문서를 참고해야 합니다.

**예시:  @git/git\_status - 도구에 사용자 지정 값 전달**

```
"toolsSettings": {
  "@git/git_status": {
    "git_user": "$GIT_USER"
  }
}
```

#### 참고사항

* 모든 도구가 toolsSettings 구성을 지원하는 것은 아닙니다.
* 세부 옵션이 존재하는지 여부는 공식 문서 또는 MCP Server 문서를 반드시 확인해야 합니다.

#### 요약

<table data-header-hidden><thead><tr><th width="185.83242797851562"></th><th></th></tr></thead><tbody><tr><td>항목</td><td>설명</td></tr><tr><td>toolsSettings</td><td>도구별 세부 권한을 제어하는 JSON 설정 블록</td></tr><tr><td>적용 대상</td><td>내장 도구 및 MCP 서버 도구 모두</td></tr><tr><td>필수 문서</td><td>각 도구 또는 MCP 서버 문서에서 지원 옵션 확인 필요</td></tr><tr><td>유용성</td><td>조직 보안 정책 또는 개발 표준에 따라 강력한 제어 가능</td></tr></tbody></table>

필요 시, execute\_bash, fs\_write, use\_aws 등의 권한을 제한하거나 허용함으로써, 개발자 실수 방지, 보안 강화, 컴플라이언스 대응에 유용하게 사용할 수 있습니다.

### Task-10: Kiro CLI에서 파일 접근 제어 설정 (Fine-Grained File Access Control) 

이번 Task에서는 Kiro CLI가 접근 가능한 파일의 범위를 제어하는 Custom Agent 설정을 구성해 봅니다.

* 프로젝트 디렉토리 내의 파일은 읽기 허용
* 민감하거나 임시적인 경로(/tmp 등)는 접근 차단

#### Custom Agent JSON 설정 예시

```
{
  "name": "python-developer",
  "description": "",
  "prompt": null,
  "mcpServers": {
    "awslabs.aws-documentation-mcp-server": {
      "command": "uvx",
      "args": ["awslabs.aws-documentation-mcp-server@latest"],
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR",
        "AWS_DOCUMENTATION_PARTITION": "aws"
      },
      "disabled": true
    },
    "KiroCLIPromptDemo": {
      "command": "uv",
      "args": ["--directory", "/home/ec2-user/mcp-prompts", "run", "--with", "mcp", "mcp", "run", "mcp-server.py"]
    }
  },
  "tools": [
    "fs_read",
    "fs_write",
    "use_aws",
    "@awslabs.aws-documentation-mcp-server/read_documentation",
    "@awslabs.aws-documentation-mcp-server/search_documentation"
  ],
  "toolAliases": {},
  "allowedTools": ["fs_read", "fs_write", "use_aws"],
  "resources": [
    "file://AGENTS.md",
    "file://README.md"
  ],
  "hooks": {
    "userPromptSubmit": [
      {
        "command": "cat pirate.md"
      }
    ],
    "agentSpawn": [
     {
       "command": "aws sts get-caller-identity"
     }
    ]
  },
"toolsSettings": {
  "fs_read": {
    "allowedPaths": ["./**"],
    "deniedPaths": ["/tmp/*"]
  }
},
  "useLegacyMcpJson": true,
  "model": null
}
```

#### 🔍 핵심 설정 설명

```
"toolsSettings": {
  "fs_read": {
    "allowedPaths": ["./**"],
    "deniedPaths": ["/tmp/*"]
  }
}
```

* "allowedPaths": \["./\*\*"] → 현재 디렉토리(./) 및 모든 하위 디렉토리(\*\*) 읽기 허용
* "deniedPaths": \["/tmp/\*"] → /tmp 디렉토리 하위 파일은 접근 차단

#### 테스트 파일 생성

```
echo "import os" > /tmp/kiro-cli-test.py
echo "import os" > kiro-cli-test.py
echo "import os" > ~/kiro-cli-test.py
```

#### 테스트 프롬프트 입력

1. 정상 접근 테스트:

```
"kiro-cli-test.py" 파일을 검토하고, 어떤 프로그래밍 언어로 작성되었는지 알려줄 수 있나요?
```

정상 작동해야 하며, Python으로 인식할 가능성 높습니다.

2. 차단 테스트:

```
"/tmp/kiro-cli-test.py" 파일을 검토하고, 어떤 프로그래밍 언어로 작성되었는지 알려줄 수 있나요?
"~/kiro-cli-test.py" 파일을 검토하고, 어떤 프로그래밍 언어로 작성되었는지 알려줄 수 있나요?
```

차단된 경로이므로, 다음과 같은 오류 메시지가 나와야 정상입니다:

```
Command fs_read is rejected because it matches one or more rules on the denied list:
  - /tmp/*

✓ 1 of 1 hooks finished in 0.08 s
> 아하! 제가 두 파일을 한 번에 읽으려다가 거절당했네요. 😅 마치 뷔페에서 접시 두 개를 들고 가려다 "한 번에 하나씩만요!"라고 제지당한 기분입니다.

그럼 한 번에 하나씩 정중하게 읽어볼게요!
Command fs_read is rejected because it matches one or more rules on the denied list:
  - /tmp/*

✓ 1 of 1 hooks finished in 0.08 s
> 음... 이번엔 한 개만 읽으려 했는데도 거절당했네요! 🤔 

파일 경로에 뭔가 민감한 부분이 있나 봅니다. /tmp 디렉토리나 특정 경로 접근이 제한되어 있는 것 같아요. 마치 "출입금지" 표지판이 붙은 방문을 열려다 경비원한테 제지당한 느낌이네요! 🚫

혹시 현재 디렉토리(/home/ec2-user)에 있는 파일이나 접근 가능한 다른 경로의 파일을 확인해드릴까요? 아니면 파일 내용을 직접 보여주시면 어떤 언어인지 알려드릴 수 있습니다! 😊
```

#### 요약

<table data-header-hidden><thead><tr><th width="239.89846801757812"></th><th></th></tr></thead><tbody><tr><td>설정 목적</td><td>설정 방법</td></tr><tr><td>특정 디렉토리만 읽기 허용</td><td>"allowedPaths": ["./**"]</td></tr><tr><td>민감한 디렉토리 차단</td><td>"deniedPaths": ["/tmp/*", "~/secret/**"]</td></tr><tr><td>설정 대상 도구</td><td>"fs_read", "fs_write" 등</td></tr></tbody></table>

정밀 권한 제어는 보안 및 규정 준수가 중요한 프로젝트에서 Amazon Q CLI의 오용을 방지하고, 개발자가 허용된 범위 내에서만 작업하도록 도와주는 핵심 기능입니다. 필요시 fs\_write에 대해서도 유사한 방식으로 allowedPaths, deniedPaths를 설정할 수 있습니다.

***

## 17. 프로젝트 범위(Custom Scope)의 커스텀 에이전트 생성하기

\
지금까지 이 실습에서는 전역(Global) 커스텀 에이전트만 생성해왔습니다. 커스텀 에이전트가 전역인지, 프로젝트 범위(Project Scoped)인지 여부는 JSON 구성 파일의 위치에 따라 결정됩니다.

### **전역(Global) 커스텀 에이전트**

실습 초반에 agent create -n xxx 명령어를 사용해 에이전트를 생성했는데,기본적으로 이 명령은 전역 범위(Global Scope)로 커스텀 에이전트를 생성합니다.

이 경우, JSON 구성 파일은 다음 위치에 생성됩니다:

```
~/.kiro/agents/
```

### **프로젝트 범위(Project Scoped) 커스텀 에이전트**

에이전트를 특정 프로젝트 디렉터리에 국한하고 싶다면, -d 인자를 추가로 사용하면 됩니다:

```
agent create -n my-agent -d .
```

이렇게 하면 JSON 구성 파일은 다음 경로에 생성됩니다:

```
<프로젝트_디렉토리>/.kiro-project/agents/
```

```
<프로젝트_디렉토리>/.kiro/agents/
```

이 경로에 위치하게 되면 프로젝트 범위(Project Scoped)의 커스텀 에이전트로 인식됩니다.

### **커스텀 에이전트 로드 우선순위**

Kiro CLI가 에이전트를 로드할 때는 다음과 같은 우선순위를 따릅니다:

1. 로컬(프로젝트) 범위의 커스텀 에이전트 - 현재 작업 디렉터리 기준으로 `<프로젝트_디렉토리>/.kiro-project/agents/` 에서 먼저 탐색
2. 전역(Global) 범위의 커스텀 에이전트- 사용자 홈 디렉터리의 `~/.kiro/agents/` 에서 탐색
3. 기본 내장(Built-in) 에이전트 - 로컬 및 전역 범위에서도 찾을 수 없는 경우 사용

> 만약 동일한 이름의 커스텀 에이전트가 로컬과 전역 모두에 존재한다면, 로컬(프로젝트 범위)의 에이전트가 우선시됩니다.

\
이런 경우 다음과 같은 경고 메시지가 출력됩니다:

```
WARNING: Agent conflict for my-agent. Using workspace version.
```

📚 참고:

커스텀 에이전트를 어떻게 구성하고 관리하면 좋을지에 대한 가이드라인은 공식 문서인 [Best practices for organizing custom agents](https://docs.aws.amazon.com/amazonq/latest/dev/custom-agents-best-practices.html) 에서 확인할 수 있습니다. 에이전트 구성 전략에 대한 좋은 아이디어를 얻을 수 있습니다.

***
