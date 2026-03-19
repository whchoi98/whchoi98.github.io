---
title: "MCP Tool Forge - MCP 도구를 코드로 변환하는 CLI"
parent: AIML
grand_parent: Tech Blog
nav_order: 2
last_modified_date: 2026-03-19
---

# MCP Tool Forge — MCP 서버 도구(Tool)를 실행 가능한 코드로 변환하는 Python CLI
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 개요(Overview)

[MCP Tool Forge](https://github.com/whchoi98/mcp-tool-forge)는 MCP(Model Context Protocol) 서버의 도구 스키마(Tool Schema)를 추출하여, 다양한 런타임(Runtime)에서 직접 실행할 수 있는 코드로 변환하는 Python CLI 도구입니다.

MCP 프로토콜은 도구 정의(Tool Definition)와 요청/응답이 모두 LLM 토큰(Token)으로 소모됩니다. 66개 이상의 AWS MCP 서버에서 수백 개 도구를 사용하면 **토큰 비용이 급증**합니다. MCP Tool Forge는 이 문제를 해결합니다.

{: .important }
> MCP 도구를 한 번 추출하여 다양한 런타임에서 직접 사용할 수 있는 코드로 변환합니다 — **토큰 0, 지연(Latency) 0**.

---

## 핵심 문제: MCP 토큰 오버헤드(Token Overhead)

MCP 서버를 통한 기존 방식에서는 매 호출마다 다음이 발생합니다:

```
[LLM] ──토큰 소모──▶ [MCP 서버] ──API 호출──▶ [AWS 서비스]
         ▲                           │
         └────토큰 소모(응답)─────────┘
```

MCP Tool Forge를 사용하면:

```
[에이전트] ──직접 호출──▶ [생성된 boto3/CLI 코드] ──API 호출──▶ [AWS 서비스]
                          (토큰 소모 없음)
```

---

## 5가지 출력 형식(Output Formats)

MCP Tool Forge는 추출한 도구 스키마를 다음 5가지 형식으로 변환합니다:

| 출력 형식 | 파일 유형 | 용도 |
|:----------|:----------|:-----|
| **boto3** | `.py` | AgentCore Gateway Lambda, 코드 인터프리터(Code Interpreter)에서 직접 호출 |
| **AWS CLI** | `.sh` | 셸(Shell) 기반 에이전트, 자동화 스크립트 |
| **Schema** | `.json` | OpenAPI 호환 도구 정의(Tool Definition) |
| **AgentCore** | `.json` | Amazon Bedrock AgentCore Gateway toolSpec |
| **Skill** | `.md` | Claude Code / Kiro-CLI 스킬(Skill) 등록 |

---

## 아키텍처(Architecture)

MCP Tool Forge는 **3단계 하이브리드 파이프라인(Hybrid Pipeline)**으로 동작합니다:

```
┌──────────────────────────────────────────────────────┐
│                    mcp-tool-forge                      │
├──────────────────────────────────────────────────────┤
│                                                       │
│  Phase 1: 스키마 추출(Schema Extraction)               │
│  ┌───────────┐  tools/list  ┌────────────────┐       │
│  │ MCP Server ├────────────►│ Schema Cache    │       │
│  │ (stdio)    │  MCP SDK    │(~/.mcp-tool-forge)│     │
│  └───────────┘              └───────┬────────┘       │
│                                      │                │
│  Phase 2: 정적 매핑(Static Mapping)   │                │
│  ┌──────────────┐                    │                │
│  │ YAML Mappings │◄──────────────────┘                │
│  │ (iam, dynamo) │                                    │
│  └──────┬───────┘                                    │
│         │ unmapped                                    │
│  Phase 3: LLM 추론(LLM Inference)                     │
│  ┌──────▼───────┐                                    │
│  │ Bedrock Claude│  tool schema → boto3 mapping       │
│  │ (Opus 4.6)    │                                    │
│  └──────┬───────┘                                    │
│         │                                             │
│  코드 생성(Code Generation)                            │
│  ┌──────▼───────┐                                    │
│  │  Generators   │  boto3 / cli / schema /            │
│  │  (Jinja2)     │  agentcore / skill                 │
│  └──────────────┘                                    │
└──────────────────────────────────────────────────────┘
```

### Phase 1: 스키마 추출(Schema Extraction)

MCP SDK의 `stdio_client`를 통해 MCP 서버에 연결하고, JSON-RPC의 `tools/list` 메서드로 도구 스키마를 추출합니다. 추출된 스키마는 `~/.mcp-tool-forge/cache/`에 캐시(Cache)되어 반복 연결을 방지합니다.

```python
# connector.py — MCP 서버 연결 및 도구 추출
tools = await self._connector.list_tools_from_config(config)
self._cache.save(config.name, tools)
```

### Phase 2: 정적 매핑(Static Mapping)

`mappings/*.yaml` 파일에 사전 정의된 매핑 정보를 조회합니다. 현재 IAM 29개, DynamoDB 6개 = 총 35개 도구가 정적 매핑 대상입니다.

```yaml
# mappings/iam.yaml 예시
list_users:
  service: iam
  method: list_users
  params: {}
```

### Phase 3: LLM 추론(LLM Inference)

정적 매핑에 없는 도구는 Amazon Bedrock의 Claude Opus 4.6 모델에 전송하여 boto3/CLI 매핑을 추론합니다. `--llm-assist` 플래그(Flag)로 활성화합니다.

{: .warning }
> LLM 매핑은 Bedrock Claude 접근 권한이 필요하며, 추론 비용이 발생합니다.

---

## 핵심 컴포넌트(Core Components)

### 프로젝트 구조(Project Structure)

```
mcp-tool-forge/
├── .claude/skills/             # 9개 AWS 스킬 (이식 가능)
│   ├── aws-iam/                # IAM 사용자, 역할, 정책
│   ├── aws-cloudwatch/         # 로그, 메트릭, 알람, CloudTrail
│   ├── aws-cost/               # 비용 탐색기, 청구, 가격
│   ├── aws-infra/              # CloudFormation, EKS, ECS, Lambda
│   ├── aws-messaging/          # SNS, SQS, MQ, Step Functions
│   ├── aws-network/            # VPC, Transit Gateway, Cloud WAN, VPN
│   ├── aws-ai/                 # Bedrock, SageMaker, Kendra, Q Business
│   ├── aws-data/               # DynamoDB, Aurora, Redshift, Neptune
│   └── aws-security/           # 계정 정보, 보안 감사
├── src/mcp_to_cli/
│   ├── cli.py                  # Click CLI 진입점(Entry Point)
│   ├── pipeline.py             # 3단계 오케스트레이터(Orchestrator)
│   ├── connector.py            # MCP SDK stdio_client 연결
│   ├── registry.yaml           # 67개 서버 설정(Configuration)
│   ├── llm_mapper.py           # Bedrock Claude Opus 4.6 매핑
│   ├── validator.py            # 생성 코드 검증/자동 수정
│   ├── generators/             # 5가지 출력 생성기(Generator)
│   ├── mappings/               # 정적 YAML 매핑 (IAM, DynamoDB)
│   └── templates/              # 6개 Jinja2 템플릿(Template)
├── tests/                      # 38개 pytest 테스트
└── docs/                       # 아키텍처 및 설계 문서
```

### 기술 스택(Tech Stack)

| 기술 | 용도 |
|:-----|:-----|
| **Python 3.11** | 핵심 언어 |
| **Click 8.x + Rich** | CLI 프레임워크 및 터미널 UI |
| **MCP SDK 1.26.0** | `stdio_client` + `ClientSession` MCP 연결 |
| **boto3** | AWS API 호출 및 Bedrock LLM 추론(Inference) |
| **Jinja2** | 코드 생성(Code Generation) 템플릿 |
| **PyYAML** | 레지스트리(Registry), 매핑 설정 |
| **Hatchling** | 빌드 시스템(Build System) |
| **pytest + pytest-asyncio** | 테스트 프레임워크(38개 테스트) |

---

## 파이프라인 데이터 흐름(Data Flow)

```python
# pipeline.py — 메인 파이프라인 실행 흐름
async def run(self, config, outputs, llm_assist=False):
    # Phase 1: MCP 서버에서 도구 추출
    raw_tools = await self._extract_tools(config)
    tools = parse_tools_list(raw_tools, config.name)

    # Phase 2 & 3: 정적 매핑 → LLM 매핑 (폴백)
    for tool in tools:
        mapping = self._resolve_mapping(tool)         # 정적 매핑 시도
        if not mapping and llm_assist:
            mapping = await self._resolve_mapping_with_llm(tool)  # LLM 폴백

    # 코드 생성: 5가지 형식으로 출력
    for output_type in outputs:
        self._write_boto3(...)      # Python 함수
        self._write_cli(...)        # Bash 스크립트
        self._write_schema(...)     # OpenAPI JSON
        self._write_agentcore(...)  # AgentCore toolSpec
        self._write_skills(...)     # Claude/Kiro 스킬
```

---

## 추출 결과(Extraction Results)

| 지표(Metric) | 값(Value) |
|:-------------|:----------|
| 연결 성공 서버(Connected Servers) | **55 / 67** (82%) |
| 추출된 도구(Extracted Tools) | **792** |
| 생성된 boto3 함수(Generated Functions) | **480+** |
| 생성된 스킬(Generated Skills) | **792** |
| 구문 통과율(Syntax Pass Rate) | **91.4%** (자동 수정 후) |

---

## 9개 AWS 스킬(Skills)

MCP Tool Forge에는 **MCP 서버 없이** Claude Code / Kiro-CLI에서 직접 AWS 서비스를 사용할 수 있는 9개 수동 제작 스킬이 포함되어 있습니다.

| 스킬(Skill) | 트리거(Trigger) | 주요 작업(Operations) |
|:------------|:---------------|:---------------------|
| **aws-iam** | "IAM 사용자/역할/정책" | list_users, create_role, attach_policy |
| **aws-cloudwatch** | "로그/메트릭/알람" | Logs Insights, get_metric_data, describe_alarms |
| **aws-cost** | "비용/청구/가격" | get_cost_and_usage, cost_forecast |
| **aws-infra** | "리소스/스택/컨테이너" | Cloud Control API, CloudFormation, EKS, ECS |
| **aws-messaging** | "큐/토픽/메시지" | SNS publish, SQS send/receive, Step Functions |
| **aws-data** | "DB/캐시/쿼리" | DynamoDB, Aurora, Redshift, ElastiCache |
| **aws-network** | "VPC/서브넷/TGW" | VPC, Transit Gateway, Cloud WAN, VPN |
| **aws-ai** | "Bedrock/SageMaker" | Bedrock models, Knowledge Bases, Agents |
| **aws-security** | "계정/자격증명/보안" | get_caller_identity, MFA check, 감사(Audit) |

{: .note }
> 9개 수동 스킬은 67개 MCP 서버 중 **52개 서버(78%)**를 커버합니다. 미커버 15개 서버도 `mcp-tool-forge convert`로 자동 생성된 **792개 개별 스킬**을 통해 사용 가능합니다.

### 스킬 설치(Installation)

```bash
# 리포지토리 복제(Clone)
git clone https://github.com/whchoi98/mcp-tool-forge.git

# 프로젝트 레벨 설치 (추천)
cd ~/your-project
mkdir -p .claude/skills
cp -r mcp-tool-forge/.claude/skills/aws-* .claude/skills/

# 글로벌 레벨 설치 (모든 프로젝트에서 사용)
mkdir -p ~/.claude/skills
cp -r mcp-tool-forge/.claude/skills/aws-* ~/.claude/skills/
```

### 스킬 테스트 결과(Test Results)

실제 AWS 계정(서울 리전, IAM 역할 인증)에서 테스트 완료:

| # | 스킬 | 테스트 | 결과 |
|:--|:-----|:-------|:-----|
| 1 | aws-security | `sts get-caller-identity` | OK |
| 2 | aws-iam | `list-users` | OK (2 users) |
| 3 | aws-iam | `list-roles` | OK (13 roles) |
| 4 | aws-cloudwatch | `describe-log-groups` | OK |
| 5 | aws-cloudwatch | `describe-alarms` | OK |
| 6 | aws-infra | Cloud Control EC2 | OK |
| 7 | aws-infra | Cloud Control S3 | OK (1 bucket) |
| 8 | aws-infra | CloudFormation stacks | OK |
| 9 | aws-cost | `get-cost-and-usage` | OK ($1,093) |
| 10 | aws-cost | Cost by service (top 5) | OK |
| 11 | aws-security | MFA check (boto3) | OK (2 NO MFA) |
| 12 | aws-security | Access key age (boto3) | OK (23 days) |
| 13 | aws-security | Account summary (boto3) | OK (Root MFA: NO) |
| 14 | aws-messaging | SNS topics | OK |
| 15 | aws-messaging | SQS queues | OK |
| 16 | aws-data | DynamoDB tables | OK |
| 17 | aws-infra | Lambda functions | OK |

**17/17 통과** — 모든 스킬이 표준 AWS 자격 증명(Credentials)으로 정상 동작합니다.

---

## 지원 서버(Supported Servers)

| 카테고리(Category) | 수 | 주요 서버 |
|:-------------------|:---|:----------|
| Data & Analytics | 18 | DynamoDB, Aurora, Redshift, ElastiCache, Neptune |
| Infrastructure & Deployment | 11 | EKS, ECS, CDK, CloudFormation, Terraform |
| AI & Machine Learning | 10 | Bedrock, SageMaker, Kendra, Nova Canvas |
| Cost & Operations | 8 | CloudWatch, CloudTrail, Cost Explorer |
| Developer Tools & Support | 7 | IAM, MSK, Diagram, Code Doc Gen |
| Integration & Messaging | 5 | SNS/SQS, MQ, Step Functions, Location |
| Healthcare & Lifesciences | 3 | HealthOmics, HealthImaging, HealthLake |
| Core | 2 | AWS API, Core MCP |
| Documentation | 2 | AWS Documentation, Knowledge |
| Essential Setup | 1 | AWS MCP (통합 프록시) |

---

## 사용 사례(Use Cases)

### AgentCore Gateway Lambda에서 직접 호출

```python
from output.aws_iam_mcp_server.boto3.tools import list_users, create_role

def handler(event, context):
    tool_name = event['tool_name']
    params = event['parameters']
    if tool_name == 'list_users':
        return list_users(**params)
```

### Claude Code 스킬로 사용 (MCP 서버 불필요)

```bash
# "IAM 사용자 목록 보여줘" → aws-iam 스킬 자동 활성화
# "이번 달 비용은?" → aws-cost 스킬 자동 활성화
# "보안 감사 실행" → aws-security 스킬 자동 활성화
```

### 자동화 스크립트에서 사용

```bash
source output/aws-iam-mcp-server/cli/tools.sh
list_users
```

---

## 빠른 시작(Quick Start)

```bash
# 설치(Install)
pip install -e ".[dev]"

# 서버 목록 조회(List Servers)
mcp-tool-forge list-servers
mcp-tool-forge list-servers --category "Data & Analytics"

# 도구 확인(List Tools) — 실제 MCP 서버에 연결
mcp-tool-forge list-tools --server aws-iam-mcp-server

# 모든 형식으로 변환(Convert)
mcp-tool-forge convert --server aws-iam-mcp-server --output all

# LLM 매핑 활성화(LLM Assist)
mcp-tool-forge convert --server amazon-cloudwatch-mcp-server --output all --llm-assist

# Claude Code에 스킬 등록(Register)
mcp-tool-forge register --server aws-iam-mcp-server -d output

# Kiro-CLI에 스킬 등록
mcp-tool-forge register --server aws-iam-mcp-server -d output --target kiro
```

---

## 요구사항(Requirements)

- Python >= 3.11
- AWS 자격 증명(Credentials) — IAM 역할(Role), CLI 프로필(Profile), 또는 환경변수(Environment Variables)
- uvx (Python MCP 서버용) / npx (Node.js MCP 서버용, 선택)
- Amazon Bedrock 접근 권한 (LLM 매핑 기능 사용 시)

---

## 참고 자료(References)

- [GitHub: whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge)
- [Model Context Protocol (MCP) 사양](https://modelcontextprotocol.io/)
- [Amazon Bedrock AgentCore 문서](https://docs.aws.amazon.com/bedrock/latest/userguide/agentcore.html)
- [Claude Code Skills 문서](https://docs.anthropic.com/en/docs/claude-code)
