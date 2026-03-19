---
title: "Steering"
parent: Kiro CLI Workshop
nav_order: 30
last_modified_date: "2026-03-19"
---

# Steering
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Steering

### 1.1. Steering 이란?

\
Steering은 `.kiro/steering/` 디렉터리에 저장된 Markdown 파일을 통해 프로젝트 지식(Project Knowledge)을 Kiro가 지속적으로 학습하고 유지하도록 하는 기능입니다.

이를 통해 매 대화마다 동일한 프로젝트 규칙이나 관례를 반복 설명할 필요 없이, Kiro가 귀하의 팀이 정의한 패턴, 라이브러리, 표준, 아키텍처 원칙을 일관되게 준수하도록 합니다.

***

### 1.2. 핵심 이점

#### 1. 일관된 코드 생성

컴포넌트, API 엔드포인트, 테스트 코드 등 모든 산출물이 팀 표준과 아키텍처 규칙을 준수하도록 보장합니다.

#### 2. 반복 작업 감소

프로젝트 규칙을 매번 설명할 필요가 없습니다.

Kiro는 Steering 파일을 기반으로 항상 동일한 맥락을 유지합니다.

#### 3. 팀 정렬(Team Alignment)

신입 개발자부터 시니어 개발자까지, 모든 팀원이 동일한 표준 아래에서 작업할 수 있습니다.

#### 4. 확장 가능한 프로젝트 지식

코드베이스가 확장됨에 따라 프로젝트 결정, 패턴, 구조적 선택을 Steering 파일로 지속적으로 축적할 수 있습니다.

***

## 2.Steering File Scope

Steering 파일은 Workspace Scope와 Global Scope 두 가지로 관리됩니다.

***

### 2.1. Workspace Steering

* 위치: `<project-root>/.kiro/steering/`
* 적용 범위: 현재 워크스페이스에만 적용
* 용도: 해당 프로젝트 전용 규칙, 패턴, 라이브러리 정의

예) 프로젝트별 API 규칙, 모듈 구조, 기술 스택

***

### 2.2. Global Steering

* 위치: `~/.kiro/steering/`
* 적용 범위: 모든 워크스페이스에 공통 적용
* 용도: 조직 전체 또는 개인의 전역 개발 표준 정의

예) 조직 공통 코드 스타일, 보안 정책 등

***

### 2.3. 우선순위

Global Steering과 Workspace Steering에 동일한 항목이 정의된 경우:

> Workspace Steering이 우선 적용됩니다.

이는 전체 workspace에서 공통적으로 적용되는 규칙을 Global Steering으로 관리하면서도, 특정 프로젝트만의 예외 처리는 Workspace Steering에서 재정의할 수 있도록 하기 위함입니다.

***

### 2.4. Team Steering

Global Steering은 팀 단위 중앙 관리에도 사용할 수 있습니다.

예를 들어:

* MDM 솔루션,
* 그룹 정책(Group Policy),
* 중앙 레포지토리에서 Pull

등의 방식으로 팀원 PC의 `~/.kiro/steering`에 Steering 파일을 배포할 수 있습니다.

***

## 3. Steering Files 

Kiro는 기본적으로 다음의 세 가지 Steering 파일을 기초 프로젝트 맥락(Baseline Context)으로 인식합니다.

#### 1.  Product Overview — product.md

제품 목적, 주요 사용자, 핵심 기능, 비즈니스 목표 등을 정의합니다.

Kiro가 기술적 제안을 할 때 비즈니스 목적과 일치하도록 돕습니다.

#### 2. Technology Stack — tech.md

프로젝트에서 사용하는 프레임워크, 라이브러리, 개발 도구, 기술 제약 등을 기술합니다.

Kiro는 새로운 제안을 할 때 항상 지정된 스택을 우선적으로 고려합니다.

#### 3. Project Structure — structure.md

파일 구조, 디렉터리 조직, 네이밍 규칙, 아키텍처 결정 등을 설명합니다.

Kiro가 생성하는 코드가 프로젝트 구조와 자연스럽게 맞도록 보장합니다.

> 이 세 파일은 모든 Kiro 세션에서 자동으로 포함됩니다.

***

## 4.Custom Steering File 생성

기초 파일 외에도 프로젝트 고유의 특성을 반영하기 위해 임의의 Steering 파일을 추가할 수 있습니다.

### 4.1. 생성 방법

1. `.kiro/steering/` 디렉터리에 새로운 .md 파일 생성
2. 의미 있는 파일명 지정 (예: `api-standards.md`, `testing-guidelines.md`)
3. Markdown 문법으로 가이드를 기술
4. 자연어로 명확히 요구사항, 규칙, 이유 등을 설명

### 4.2. 예시

```
API 스펙: #[[file:api/openapi.yaml]]
컴포넌트 패턴: #[[file:components/ui/button.tsx]]
환경 변수 템플릿: #[[file:.env.example]]
```

***

## 5. `AGENTS.md` 지원

Kiro는 `AGENTS.md` 표준도 Steering 파일과 동일한 방식으로 지원합니다.

단, `AGENTS.md` 파일은 항상 포함된다는 점이 다릅니다.

* 전역 위치: `~/.kiro/steering/AGENTS.md`
* 워크스페이스 위치: `<project-root>/AGENTS.md`

두 위치 모두 자동으로 로드됩니다.

***

## 6. 모범사례

### 6.1. 파일은 작고 목적에 집중 (Single Domain per File)

예:

* api-rest-conventions.md – REST API 표준
* testing-unit-patterns.md – 유닛 테스트 패턴
* components-form-validation.md – Form 컴포넌트 검증 규칙

### 6.2. 명확한 파일명 사용

내용을 파일명만 보고 바로 이해할 수 있도록 구성합니다.

### 6.3. 배경(Context) 제공

“무엇” 뿐만 아니라, “왜” 그런 선택을 했는지도 설명하십시오.

이는 Kiro의 의사결정 품질을 크게 향상시킵니다.

### 6.4. 예시(Examples) 포함

코드 스니펫, before/after 예시는 Kiro의 패턴 학습에 매우 효과적입니다.

### 6.5. 보안(Security)

Steering 파일은 코드베이스 일부이므로 민감한 정보(API 키, 비밀번호 등)는 절대 포함하지 마십시오.

### 6.6. 지속적 유지관리

* 스프린트마다 Steering 파일을 검토
* 프로젝트 구조 변경 시 파일 경로 및 참조 업데이트
* Steering 변경 사항도 코드 변경처럼 Pull Request 검토 절차 적용

***

## 7. 공통 Steering 파일 전략 

#### API Standards — api-standards.md

* REST 규칙
* 오류 응답 구조
* 인증/인가 플로우
* 버전 관리 전략
* 요청/응답 예시

#### Testing Approach — testing-standards.md

* 유닛 테스트 패턴
* 통합 테스트 전략
* Mocking 가이드
* 커버리지 기대치
* 테스트 파일 구문/구조 규칙

#### Code Style — code-conventions.md

* naming 규칙
* import 순서
* 디렉터리 구조
* 권장 코드 패턴 및 반패턴(anti-patterns)

#### Security Guidelines — security-policies.md

* 인증 정책
* 입력 검증, 데이터 sanitization
* 보안 취약점 방지 전략
* 애플리케이션 특화 보안 모범 사례

#### Deployment Process — deployment-workflow.md

* 빌드 절차
* 환경 구성
* 배포/롤백 전략
* CI/CD 파이프라인 구성

***

## 8. Steering 파일 적용 범위

커스텀 Steering 파일은 .kiro/steering/에 저장된 즉시 모든 Kiro CLI 세션에서 자동 활성화됩니다.
