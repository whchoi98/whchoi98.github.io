---
title: "MCP Tool Forge - MCP 도구를 코드로 변환하는 CLI"
parent: AIML
grand_parent: Tech Blog
nav_order: 2
last_modified_date: "2026-03-19"
---

# MCP Tool Forge — MCP 서버 도구(Tool)를 실행 가능한 코드로 변환하는 Python CLI
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 개요(Overview)

[MCP Tool Forge](https://github.com/whchoi98/mcp-tool-forge)는 MCP(Model Context Protocol) 서버의 도구를 추출하여, **boto3, AWS CLI, OpenAPI 스키마(Schema), AgentCore Gateway, Claude Code / Kiro-CLI Skill** 5가지 형식으로 변환하는 Python CLI 도구입니다. **9개 AWS Skills**을 포함하며 Claude Code와 Kiro-CLI 모두 지원합니다.

---

## 핵심 문제: MCP 토큰 비용(Token Cost)

### MCP는 왜 토큰을 많이 소모하는가?

MCP 프로토콜은 강력하지만, **모든 도구 정의(Tool Definition)와 요청/응답이 LLM 토큰(Token)으로 소모**됩니다.

```
매 대화마다 발생하는 토큰 소비:

┌─────────────┐     JSON Schema (도구 정의)      ┌─────────┐
│  LLM Agent  │ ◄──────── ~2,000 토큰/도구 ────── │   MCP   │
│             │ ──────── 요청 (함수 호출) ────────► │  Server │
│             │ ◄──────── 응답 (결과) ──────────── │         │
└─────────────┘                                   └─────────┘
```

MCP 서버가 로딩되면 **모든 도구의 JSON Schema가 LLM 컨텍스트(Context)에 주입**됩니다. 이는 LLM이 어떤 도구를 사용할 수 있는지 "알기 위해" 필요하지만, 대부분의 도구는 사용되지 않습니다.

```
예: IAM MCP 서버 로딩 시

  29개 도구 × ~2,000 토큰/도구 = ~58,000 토큰 (도구 정의만)
  + 요청/응답 JSON-RPC 왕복 = ~500 토큰/호출

  67개 서버 전체 로딩 시:
  792개 도구 × ~2,000 토큰 = ~1,584,000 토큰 (약 150만)
```

{: .warning }
> 67개 AWS MCP 서버에서 792개 도구를 전부 로딩하면, 도구 정의만으로 **약 150만 토큰**이 소모됩니다.

### 실제 측정 결과 (Kiro-CLI 기준)

| 시나리오 | Credits | 토큰 사용량 |
|:--------|:--------|:-----------|
| MCP 서버 4개 ON | 0.71 | 도구 스키마(Schema) 로딩 + 응답 |
| MCP 서버 4개 OFF (Skills만) | **0.27** | 필요한 스킬(Skill)만 선택 로딩 |
| **절감률(Savings)** | **62%** | |

### MCP Tool Forge의 해법

```
한 번 추출 → 네이티브 코드로 변환 → MCP 없이 직접 실행

  MCP 방식:   Agent ←→ MCP Server ←→ AWS API  (매번 토큰 소비)
  Skill 방식:  Agent → boto3/CLI 코드 → AWS API  (토큰 0, 지연 0)
```

| 비교 | MCP 방식 | Skill 방식 |
|:-----|:--------|:----------|
| 도구 정의 토큰 | ~2,000/도구 (매 대화) | **0** (코드에 내장) |
| 요청/응답 토큰 | JSON-RPC 왕복 | **0** (직접 실행) |
| 서버 의존성(Dependency) | 항상 실행 필요 | **불필요** |
| 지연 시간(Latency) | MCP 서버 왕복 | **0** |
| 오프라인(Offline) 동작 | 불가 | **가능** |

---

## 토큰 경제학(Token Economics): MCP vs Skills

### Skills는 어떻게 토큰을 절약하는가?

Skills는 **필요한 스킬만 선택적으로 로딩(Selective Loading)**합니다.

```
예: "IAM 사용자 목록 보여줘" 요청 시

  MCP 방식:  29개 도구 스키마 전체 로딩 (58,000 토큰) → 1개 사용
  Skill 방식: aws-iam SKILL.md 1개 로딩 (~3,000 토큰) → 바로 실행
```

| 항목 | MCP (서버 1개) | MCP (67개 전체) | Skill |
|:-----|:-------------|:---------------|:------|
| 초기 로딩(Initial Loading) | ~58,000 토큰 | ~1,584,000 토큰 | **~3,000 토큰** |
| 도구 호출(Per Call) | ~500 토큰/회 | ~500 토큰/회 | **0 토큰** |
| 서버 프로세스(Process) | 1개 필요 | 67개 필요 | **0개** |
| 콜드 스타트(Cold Start) | 2~5초 | 30초+ | **0초** |

### 비용 환산(Cost Estimation) — Claude Opus 4.6 기준

| 시나리오 | 입력 토큰(Input Tokens) | 비용($15/1M 토큰) |
|:--------|:----------------------|:-----------------|
| MCP 1개 서버/대화 | 58,000 | $0.87/대화 |
| MCP 10개 서버/대화 | 580,000 | $8.70/대화 |
| **Skill 1개/대화** | **3,000** | **$0.045/대화** |
| **Skill 전체 9개/대화** | **27,000** | **$0.41/대화** |

{: .important }
> **Skill 방식은 MCP 대비 토큰 비용을 95% 이상 절감합니다.**

---

## Skills 설치 — 3줄이면 끝

{: .highlight }
> **MCP 서버 설치, Python 패키지(Package), Bedrock 접근 모두 불필요.** AWS 자격 증명(Credentials)만 있으면 바로 사용할 수 있습니다.

### Claude Code

```bash
git clone https://github.com/whchoi98/mcp-tool-forge.git
mkdir -p .claude/skills
cp -r mcp-tool-forge/.claude/skills/aws-* .claude/skills/
```

### Kiro-CLI

```bash
git clone https://github.com/whchoi98/mcp-tool-forge.git
mkdir -p .kiro/skills
cp -r mcp-tool-forge/.claude/skills/aws-* .kiro/skills/
```

### 글로벌 설치(Global Installation) — 모든 프로젝트에 적용

```bash
# Claude Code
mkdir -p ~/.claude/skills
cp -r mcp-tool-forge/.claude/skills/aws-* ~/.claude/skills/

# Kiro-CLI
mkdir -p ~/.kiro/skills
cp -r mcp-tool-forge/.claude/skills/aws-* ~/.kiro/skills/
```

### 특정 스킬만 설치

```bash
# Claude Code
cp -r mcp-tool-forge/.claude/skills/aws-iam .claude/skills/
cp -r mcp-tool-forge/.claude/skills/aws-cost .claude/skills/
cp -r mcp-tool-forge/.claude/skills/aws-network .claude/skills/

# Kiro-CLI
cp -r mcp-tool-forge/.claude/skills/aws-iam .kiro/skills/
cp -r mcp-tool-forge/.claude/skills/aws-network .kiro/skills/
```

설치 후 자연어(Natural Language)로 요청하면 스킬이 자동 활성화됩니다:

| 요청 예시 | 활성화 스킬 |
|:---------|:-----------|
| "IAM 사용자 목록 보여줘" | aws-iam |
| "이번 달 비용은?" | aws-cost |
| "CloudWatch 알람 확인" | aws-cloudwatch |
| "Lambda 함수 목록" | aws-infra |
| "SQS 큐 목록" | aws-messaging |
| "VPC 네트워크 확인" | aws-network |
| "Bedrock 모델 목록" | aws-ai |
| "DynamoDB 테이블 조회" | aws-data |
| "보안 감사 실행" | aws-security |

---

## 9개 AWS Skills

| 스킬(Skill) | 트리거(Trigger) | 주요 작업(Operations) |
|:------------|:---------------|:---------------------|
| **aws-iam** | "IAM 사용자/역할/정책" | list_users, create_role, attach_policy, simulate_policy |
| **aws-cloudwatch** | "로그/메트릭/알람/감사" | Logs Insights, get_metric_data, describe_alarms, CloudTrail |
| **aws-cost** | "비용/청구/가격" | get_cost_and_usage, cost_forecast, pricing lookup |
| **aws-infra** | "리소스/스택/컨테이너" | Cloud Control API, CloudFormation, EKS, ECS, Lambda |
| **aws-messaging** | "큐/토픽/메시지/워크플로" | SNS publish, SQS send/receive, MQ, Step Functions |
| **aws-network** | "VPC/서브넷/TGW/VPN" | VPC, Transit Gateway, Cloud WAN, Network Firewall, VPN, Flow Logs |
| **aws-ai** | "Bedrock/SageMaker/Kendra" | Bedrock Converse, Knowledge Bases, Agents, SageMaker, Kendra, Q Business |
| **aws-data** | "DB/캐시/쿼리" | DynamoDB, Aurora, Redshift, ElastiCache, Neptune |
| **aws-security** | "계정/자격증명/보안감사" | get_caller_identity, credential audit, MFA check |

### Skills 커버리지(Coverage)

9개 수동 스킬은 67개 MCP 서버 중 **52개 (78%)**를 커버합니다.

미커버(Uncovered) 15개 서버:

| 카테고리 | 미커버 서버 | 사유 |
|:---------|:-----------|:-----|
| Core / Essential | aws-api, core-mcp, aws-mcp | MCP 프록시(Proxy)/플래닝(Planning) — 특정 서비스가 아님 |
| Documentation | aws-documentation, aws-knowledge | 문서 검색 전용 — boto3/CLI 대상 아님 |
| Developer Tools | aws-diagram, aws-msk, code-doc-gen, frontend, git-repo-research, synthetic-data | 개발 도구 (다이어그램, Kafka, 코드 문서화 등) |
| Healthcare | aws-healthomics, healthimaging, healthlake | 헬스케어(Healthcare) 전문 서비스 |
| Cost & Operations | aws-managed-prometheus | Prometheus 모니터링(Monitoring) |

{: .note }
> 미커버 서버도 `mcp-tool-forge convert`로 자동 생성된 **792개 개별 스킬**을 통해 사용 가능합니다.

### Skills 테스트 결과(Test Results)

실제 AWS 계정(서울 리전, IAM 역할 인증)에서 테스트:

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

**17/17 통과** — 모든 스킬이 표준 AWS 자격 증명(Credentials)으로 동작합니다.

---

## 아키텍처(Architecture)

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

1. **추출(Extract)** — MCP SDK `stdio_client`로 서버 연결, `tools/list`로 스키마 추출. `~/.mcp-tool-forge/cache/`에 캐시(Cache).
2. **정적 매핑(Static Map)** — `mappings/*.yaml`에서 알려진 매핑 조회 (IAM 29 + DynamoDB 6 = 35개).
3. **LLM 매핑(LLM Map)** — 미매핑(Unmapped) 도구를 Bedrock Claude Opus 4.6에 전송. `--llm-assist` 플래그(Flag).

---

## 멀티 AWS 프로필 지원(Multi-Profile Support)

`--aws-profile` 옵션으로 생성되는 boto3 코드에 AWS 프로필을 설정할 수 있습니다. AWS Organizations + SSO 환경에서 여러 계정을 사용하는 경우 유용합니다.

```python
# --aws-profile 없이 생성 (기본)
def list_users(profile_name: str | None = None, **kwargs) -> dict:
    session = boto3.Session(profile_name=profile_name)
    client = session.client('iam')
    ...

# --aws-profile prod-account 으로 생성
def list_users(profile_name: str | None = "prod-account", **kwargs) -> dict:
    session = boto3.Session(profile_name=profile_name)
    client = session.client('iam')
    ...

# 호출 시 프로필 오버라이드(Override) 가능
list_users()                                  # 기본 프로필 사용
list_users(profile_name="staging-account")    # 다른 계정으로 전환
```

---

## 추출 결과(Extraction Results)

| 지표(Metric) | 값(Value) |
|:-------------|:----------|
| 등록 서버(Registered Servers) | **67개** |
| 연결 성공(Connected) | **55 / 67** (82%) |
| 추출된 도구(Extracted Tools) | **792개** |
| 생성된 boto3 함수(Generated Functions) | **480+** |
| 생성된 스킬(Generated Skills) | **792개** |
| 구문 통과율(Syntax Pass Rate) | **91.4%** (자동 수정 후) |

---

## 5가지 출력 형식(Output Formats)

| 형식 | 파일 | 용도 |
|:-----|:-----|:-----|
| **boto3** (.py) | `output/*/boto3/tools.py` | AgentCore Gateway Lambda에서 직접 호출 |
| **AWS CLI** (.sh) | `output/*/cli/tools.sh` | 셸(Shell) 기반 에이전트, 자동화 스크립트 |
| **Schema** (.json) | `output/*/schema/tools.json` | OpenAPI 호환 도구 정의(Tool Definition) |
| **AgentCore** (.json) | `output/*/agentcore/tool_config.json` | Bedrock AgentCore Gateway toolSpec |
| **Skill** (.md) | `output/*/skill/*.md` | Claude Code / Kiro-CLI 스킬(Skill) |

---

## 지원 서버(Supported Servers) — 67개

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

## 빠른 시작(Quick Start) — CLI 도구

{: .note }
> Skills만 사용하려면 이 섹션은 건너뛰어도 됩니다. 위의 [Skills 설치](#skills-설치--3줄이면-끝)만으로 충분합니다.

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

# LLM 매핑(LLM Assist)
mcp-tool-forge convert --server amazon-cloudwatch-mcp-server --output all --llm-assist

# 멀티 AWS 프로필(Multi-Profile) 지원
mcp-tool-forge convert --server aws-iam-mcp-server --output boto3 --aws-profile prod-account

# Claude Code에 스킬 등록(Register)
mcp-tool-forge register --server aws-iam-mcp-server -d output

# Kiro-CLI에 스킬 등록
mcp-tool-forge register --server aws-iam-mcp-server -d output --target kiro
```

---

## 프로젝트 구조(Project Structure)

```
mcp-tool-forge/
├── .claude/skills/             # 9개 AWS Skills (이식 가능)
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

---

## 요구사항(Requirements)

| 항목 | Skills만 사용 | CLI 도구 전체 |
|:-----|:------------|:-------------|
| Python >= 3.11 | 불필요 | 필요 |
| AWS 자격 증명(Credentials) | 필요 | 필요 |
| uvx / npx | 불필요 | 필요 (MCP 서버 실행) |
| Bedrock 접근 | 불필요 | 선택 (LLM 매핑용) |

---

## 참고 자료(References)

- [GitHub: whchoi98/mcp-tool-forge](https://github.com/whchoi98/mcp-tool-forge)
- [Model Context Protocol (MCP) 사양](https://modelcontextprotocol.io/)
- [Amazon Bedrock AgentCore 문서](https://docs.aws.amazon.com/bedrock/latest/userguide/agentcore.html)
- [Claude Code Skills 문서](https://docs.anthropic.com/en/docs/claude-code)
- [Kiro CLI 공식 사이트](https://kiro.dev/)
