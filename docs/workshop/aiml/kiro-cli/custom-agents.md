---
title: "Custom Agents 커스텀 에이전트"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 20
last_modified_date: "2026-03-19"
---

# Custom Agents (커스텀 에이전트)
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Custom Agents는 Kiro의 동작 방식을 사용자의 다양한 사용 사례에 맞춰 세밀하게 구성(Customize) 할 수 있는 기능을 제공합니다.

각 커스텀 에이전트는 별도의 에이전트 설정 파일(Agent Configuration File) 로 정의되며, 이 파일에는 다음과 같은 요소가 포함됩니다:

* 사용 가능한 도구(Tools)
* 도구 권한(Permissions)
* 자동으로 포함할 컨텍스트(Context)
* 동작 파라미터 및 런타임 설정

기본적으로 Kiro CLI는 모든 내장 도구(Built-in Tools)에 접근할 수 있지만, 대부분의 작업에서 사용자 승인을 요구합니다. 이는 보안 우선(Security-first) 접근 방식이지만, 잦은 권한 요청으로 인해 워크플로우가 방해될 수 있습니다.

Custom Agents는 이러한 문제를 해결합니다.

***

## 1. Custom Agents Enable(커스텀 에이전트 기능)

커스텀 에이전트는 다음과 같은 기능을 구성할 수 있도록 합니다:

1\. Pre-approve specific tools : 특정 도구를 사전 승인하여 작업 중 매번 확인 요청을 피할 수 있음

2\. Limit tool access : 필요한 도구만 허용하여 복잡성을 줄이고 보안을 강화

3\. Include relevant context : 프로젝트 문서, 설정 파일, 시스템 정보 등을 자동으로 컨텍스트로 로드 

4\.  Configure tool behavior :  도구의 세부 동작 방식을 설정하여 자동화 품질 향상

***

## 2. Custom Agents  사용의 장점

1\. Workflow Optimization (워크플로우 최적화) :  AWS 인프라 관리, 코드 리뷰, 디버깅 세션 등 특정 작업에 맞춘 최적화된 에이전트를 구축 가능.

2\. Reduced Interruptions (작업 방해 감소) :  신뢰된 도구를 사전 승인하여 작업 중 등장하는 반복적인 권한 요청 제거.

3\. Enhanced Context (향상된 컨텍스트 구성) : 프로젝트 문서, 설정 파일 등을 자동 로드하여 더 정확한 분석 및 응답 제공.

4\. Team Collaboration (팀 협업 강화) : 공유 가능한 에이전트 설정을 통해 팀 전체가 동일한 개발 환경을 유지할 수 있음.

5\. Security Control (보안 관리 향상) : 사용 사례별로 필요한 최소 도구만 활성화하여 잠재적 보안 위험 최소화.

***

## 3. MCP 및 내장 도구와의 관계

Custom Agents는 Kiro의 내장 도구(Built-in Tools) 와 Model Context Protocol(MCP) 을 통한 외부 도구 모두와 함께 작동합니다.

이를 통해 사용자는 다음을 달성할 수 있습니다:

#### 1. Use Built-in Tools

* 파일 조회 및 수정(File operations)
* 명령 실행(Command execution)
* AWS CLI 통합
* 기타 Kiro의 핵심 기능 활용

#### 2.  Integrate MCP Servers

* MCP 서버를 추가하여 외부 서비스나 커스텀 도구를 확장형으로 연결
* 조직 또는 프로젝트별 맞춤형 워크플로우 구축 가능

#### 3. Control Tool Access

* 각 도구 소스(내장 또는 MCP 제공)에서 사용할 도구를 명확히 지정
* 필요 시 도구 접근 제한

#### 4.  Manage Tool Conflicts

* 서로 다른 도구 소스 간 이름 충돌 발생 시 별칭(Alias) 을 사용하여 충돌 해결 가능
