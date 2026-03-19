---
title: "모델 선택(Model Selection)"
parent: Kiro CLI Workshop
nav_order: 9
last_modified_date: "2026-03-19"
---

# 모델 선택
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

***

Kiro는 개발 업무 전반을 지원하기 위해 Auto, Claude Sonnet 4.0, Claude Sonnet 4.5, Claude Haiku 4.5, Claude Opus 4.5 등 다양한 고성능 AI Agent(에이전트) 모델을 제공합니다. 각 모델은 업무 특성, 사용 패턴, 비용 구조에 따라 상이한 강점을 갖고 있습니다.

***

## 1. 지원 모델

### 1.1. Auto (권장 설정)

Auto는 Kiro의 기본 모델 라우팅(Model Routing) 엔진으로, 여러 최첨단 LLM을 조합하고 고급 최적화 기법을 적용하여 가장 효율적인 결과를 제공합니다.

주요 장점

* 비용 효율성(Cost-effective) – Sonnet 4 직접 사용 대비 약 23% 비용 절감
* 지능형 라우팅(Smart Routing) – 작업 특성에 최적화된 모델을 자동 선택
* 일관된 품질(Consistent Quality) – 다양한 작업에서 Sonnet 4 수준의 출력 제공
* 플랜 효율성(Plan Efficiency) – 사용 한도를 가장 효율적으로 활용

Auto가 사용하는 모델은?

Auto는 Claude Sonnet 4를 포함한 최상위급 LLM(best-in-class LLM) 조합을 기반으로 작업 유형별 최적의 품질을 제공합니다. Auto 라우팅이 별도 모델의 직접 호출 품질을 충족하거나 능가하도록 엄격한 기준을 유지합니다.

***

### 1.2. Claude Sonnet 4.0

일관된 모델 선택을 선호하거나, 특정 워크로드에서 명확히 Sonnet 4.0을 요구하는 사용자를 위한 Anthropic Claude Sonnet 4.0 직접 접근 모델입니다.

주요 장점

* 예측 가능한 동작(Predictable Behavior) – 모든 요청에 동일 모델 적용
* 직접 접근(Direct Access) – 라우팅·최적화 계층 없음
* 완전한 제어(Full Control) – 모델 선택 투명성 보장

***

### 1.3. Claude Sonnet 4.5

복잡한 에이전트 운영과 소프트웨어 엔지니어링(SWE) 작업에서 최고의 성능을 제공하는 Anthropic의 상위 모델입니다.

주요 장점

* 최첨단 코딩 성능(Coding Excellence) – SWE-bench Verified 기준 최고 수준
* 고급 에이전트 기능(Agent Capabilities) – 수 시간의 장기 자율 작업 수행 및 효과적 도구 활용
* 향상된 추론 능력(Enhanced Reasoning) – 시스템 설계·보안 엔지니어링·계획 능력 강화

***

### 1.4. Claude Opus 4.5

Anthropic의 최상위급 지능을 제공하는 모델로, 복잡한 전문 업무, 프로덕션급 소프트웨어 엔지니어링, 고급 에이전트 운영에 적합합니다.

주요 장점

* 최대 지능(Maximum Intelligence) – 추론·코딩·문제 해결에서 단계적 성능 향상
* 실용적 성능(Practical Performance) – 이전 Opus 대비 더 접근 가능한 가격
* 복합 추론 능력(Complex Reasoning) – 다중 시스템 간 트레이드오프와 모호성 처리 능력 우수

이용 가능 여부

* Google, GitHub, AWS BuilderID 로그인 사용자에게 실험적 지원(Experimental Support) 제공.
* AWS IAM Identity Center 사용자는 현재 미지원.

***

### 1.5. Claude Haiku 4.5

가장 빠르고 지능적인 Haiku 시리즈 모델로, Sonnet 4에 근접한 지능을 훨씬 낮은 비용과 빠른 속도로 제공합니다.

주요 장점

* 준-프런티어 지능(Near-frontier Intelligence) – 추론·코딩에서 Sonnet 4 수준에 근접
* 매우 빠른 속도(Blazing Speed) – Sonnet 4 대비 2배 이상 속도
* 비용 효율성(Cost-effective) – Sonnet 4 대비 1/3 수준의 비용
* 확장된 사고 능력(Extended Thinking) – 최초의 고급 추론 지원 Haiku 모델

***

## 2. 모델별 비용 비교

모델별 크레딧 소모 방식은 다음과 같습니다:

<table data-header-hidden><thead><tr><th width="189.58203125"></th><th width="231.70703125"></th><th></th></tr></thead><tbody><tr><td>모델(Model)</td><td>크레딧 사용량(Credit Usage)</td><td>예시 작업 비용(Example Task Cost)</td></tr><tr><td>Claude Haiku 4.5</td><td>0.4x</td><td>4 credits</td></tr><tr><td>Auto</td><td>1.0x</td><td>10 credits</td></tr><tr><td>Claude Sonnet 4.0</td><td>1.3x</td><td>13 credits</td></tr><tr><td>Claude Sonnet 4.5</td><td>1.3x</td><td>13 credits</td></tr><tr><td>Claude Opus 4.5</td><td>2.2x</td><td>22 credits</td></tr></tbody></table>

***

## 3. 모델 선택 기준

#### Claude Haiku 4.5를 고려할 때

* 응답 속도가 중요한 경우 (Speed-critical)
* 비용 최적화가 필요한 경우 (Cost Efficiency)
* 대량 처리 작업 (High-volume Processing)
* 실시간 사용자 경험(Real-time Applications) 제공 시

***

#### Auto를 고려할 때

* 비용 효율성 극대화 필요
* 일반적인 개발 작업(코딩·디버깅·설계 등)
* 다양한 유형의 작업을 병행
* 플랜 사용량 최적화가 중요

***

#### Sonnet 4.0 & Sonnet 4.5를 고려할 때

* 모델 동작의 일관성(Consistency) 이 필요
* Sonnet 기반 기능에 대한 명확한 요구사항 존재
* 요청 모델의 완전한 투명성이 필요
* 비용이 상대적으로 덜 중요한 환경

***

#### Claude Opus 4.5를 고려할 때

* 최상위급 지능(Maximum Intelligence)이 필요한 경우
* 전문적·고난도 소프트웨어 엔지니어링
* 장기 실행형 고급 에이전트
* 품질이 핵심인 고위험·고가치 작업

***

## 4.모델 변경 방법

* Chat 인터페이스 내에서 /model 명령어 사용

#### Kiro CLI 설정

```
kiro-cli settings chat.defaultModel claude-sonnet4
```

***

## 5. 모범 사례

#### 효율 극대화

* 기본값은 Auto로 설정
* 속도가 중요하면 Haiku 활용
* 복잡한 에이전트·코딩 워크로드에는 Sonnet
* 최고 난도 작업에는 Opus
* 사용량 모니터링을 정기적으로 수행
* 동일 작업에 다양한 모델을 테스트하여 최적점을 찾기

***

#### 비용 관리

* 플랜 선택 시 모델별 비용 구조 고려
* 업무별 모델 사용 패턴 분석
* 모델 특성에 맞춰 워크플로우 최적화
* 필요 시 초과 사용(Overage) 옵션 활성화 검토

***
