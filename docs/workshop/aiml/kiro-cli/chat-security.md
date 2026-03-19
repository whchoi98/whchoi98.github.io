---
title: "보안 고려 사항(Security)"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 18
last_modified_date: "2026-03-19"
---

# 보안 고려 사항
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Kiro는 로컬 시스템 및 AWS 리소스에 영향을 미칠 수 있는 강력한 기능을 제공합니다.

따라서 이러한 기능의 보안적 영향(Security Implications) 을 이해하고 모범 사례(Best Practices) 를 준수하는 것은 안전한 운영에 매우 중요합니다.

***

## 1. 보안 리스크 이해하기

Kiro를 사용할 때 고려해야 할 잠재적 보안 위험은 다음과 같습니다:

* 예기치 않은 시스템 변경 - 요청이 의도와 다르게 해석되어 비정상적인 파일 수정 또는 시스템 변경이 발생할 수 있음.
* AWS 리소스 변경 - 자원 생성·수정·삭제가 예상치 못하게 수행되어 프로덕션 환경에 영향을 주거나 비용이 증가할 수 있음.
* 데이터 손실 - 삭제 또는 덮어쓰기 명령이 실행될 경우 중요한 데이터가 복구 불가능한 상태로 손실될 수 있음.
* 보안 취약점 노출 - 사용자 승인 없이 실행된 명령이 시스템의 보안 상태를 악화시킬 가능성 존재.

특히 `/tools trust-all` 또는 `/acceptall` 을 사용할 경우 이러한 위험이 크게 증가합니다.

해당 모드에서는 모든 도구 사용 시 확인 절차가 우회되기 때문입니다.

#### 구체적 위험 사례

* “오래된 파일 정리(clean up old files)” 요청이 중요한 구성 파일을 삭제할 수 있음
* “EC2 인스턴스 최적화(optimize EC2 instances)” 요청이 실행 중인 인스턴스를 종료할 수 있음
* “보안 문제 해결(fix security issues)” 요청이 민감한 데이터가 노출될 수 있는 잘못된 권한 변경을 수행할 수 있음

***

## ⚠️ 중요 경고

프로덕션 환경 또는 민감 데이터/리소스를 다루는 환경에서는 `/tools trust-all` 또는 `/acceptall` 모드를 절대 사용하지 마십시오.

Kiro가 수행하는 모든 작업에 대한 책임은 사용자에게 있습니다.

***

## 2. 일반 보안 모범 사례

특히 민감한 파일, 개인 키(private keys), 토큰(tokens), 인증 정보(credentials) 등과 함께 Kiro를 사용할 때는 다음 보안 조치를 적극 고려해야 합니다.

***

### 파일 접근 제한

기본적으로 Kiro는 파일 읽기(read tool)를 자동 승인 상태(Trusted) 로 사용합니다.

민감한 환경에서는 이 동작을 비활성화하는 것이 안전합니다.

```
/tools untrust read
```

이 설정 후 Kiro는 파일을 읽기 전에 항상 사용자에게 명시적 승인을 요청합니다.

#### 영구 설정 방법

Shell 시작 스크립트에 아래 명령을 추가해 모든 세션에서 자동 적용되도록 설정할 수 있습니다:

```
echo 'alias kiro-cli="kiro-cli --untrust-fs-read"' >> ~/.bashrc
```

이렇게 하면 새로운 모든 Kiro 세션에서 fs\_read가 기본적으로 비신뢰(Per-request) 상태로 시작됩니다.

***

## 3. 추가 고려 사항

특히 고도의 민감 데이터를 다루는 환경에서는 다음을 고려하십시오:

* 민감한 자격 증명 또는 데이터가 없는 전용 개발 환경에서 Kiro 실행
* 민감 파일은 프로젝트 디렉터리 밖 또는 접근 제한이 있는 경로에 보관
* 민감 값은 파일에 하드코딩하지 말고 환경 변수(Environment Variables)로 관리
* aws 도구 사용 시 /tools untrust aws 로 설정해 AWS 호출 시마다 확인 요구
* Kiro Steering 기능을 사용하여 보안 정책(Security Guidelines) 및 금지 행위 명시

***

## 4. `/tools trust-all` 안전 사용 방법

특정 워크플로우에서 `/tools trust-all` 또는 `/acceptall` 사용이 불가피한 경우, 아래의 안전 수칙을 반드시 준수하십시오:

1. 개발/테스트 환경에서만 사용 — 프로덕션에서는 절대 사용 금지
2. 특정 작업을 위해 필요한 순간에만 활성화하고, 작업 종료 즉시 비활성화:

```
/tools reset
```

3. 중요한 데이터는 사전 백업
4. AWS 관련 작업 시 최소 권한 원칙(Least Privilege Principle) 을 적용한 자격 증명 사용
5. trust-all 활성화 중에는 Kiro의 모든 작업을 적극 모니터링

#### 기본 권한으로 복구하기

```
/tools reset
```

이 명령은 도구 권한을 기본값으로 재설정하며, 기본적으로 read 도구만 Trusted, 나머지는 모두 Per-request 상태로 복귀합니다.
