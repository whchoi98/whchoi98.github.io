---
title: "인증 방식(Authentication)"
parent: Workshop
nav_order: 7
last_modified_date: "2026-03-19"
---

# 인증 방식
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Authentication Methods / 인증 방식

Kiro CLI는 다양한 인증 공급자(Authentication Providers)를 지원하여 개발자가 가장 익숙한 방식으로 손쉽게 로그인할 수 있도록 설계되었습니다. 아래는 지원되는 인증 방식과 특징을 요약한 것입니다.

***

### 1.1. Supported Authentication Providers / 지원되는 인증 제공자

• GitHub : GitHub 계정으로 즉시 로그인할 수 있으며, 개발 환경과 자연스럽게 통합됩니다.

• Google :  Google 자격 증명으로 빠르게 로그인할 수 있습니다.

• AWS Builder ID : 개별 개발자에게 적합한 경량 인증 방식으로 간편하게 가입·로그인이 가능합니다.

• AWS IAM Identity Center : 엔터프라이즈 환경에서 사용하는 조직 기반 인증 방식으로, SSO(Single Sign-On)를 포함한 기업용 인증 체계를 제공합니다.

***

### 1.2. 정보(Info)

Kiro 유료 구독(Subscription)을 소셜 로그인(GitHub·Google) 또는 AWS Builder ID를 통해 사용하는 사용자는 개인 구독자(individual subscribers) 로 분류됩니다.

Kiro Free Tier(무료 요금제) 및 개인 구독자의 일부 콘텐츠는 서비스 품질 개선(Service Improvement)에 활용될 수 있습니다.

자세한 내용 및 옵트아웃(opt-out) 방법은 다음 문서를 참고하세요:  [Service Improvement 문서](https://kiro.dev/docs/privacy-and-security/data-protection/#service-improvement)

***

## 2. Sign in to Kiro CLI / Kiro CLI 로그인

아래 절차에 따라 Kiro CLI에 로그인할 수 있습니다.

***

### 2.1. CLI에서 로그인 시작

터미널에서 다음 명령 중 하나를 입력합니다.

```
kiro-cli
kiro-cli login
```

엔터(Enter)를 누르면 브라우저를 통해 인증을 완료하도록 안내됩니다.

***

### 2.2. 브라우저에서 인증 공급자 선택

브라우저가 열리면 다음 중 하나를 선택하여 인증합니다.

* Google
* GitHub
* Builder ID (AWS Builder ID)
* Your Organization (조직 IdC / Enterprise SSO)

해당 계정으로 인증을 완료합니다.

***

### 2.3. 인증 완료 후 터미널로 복귀

브라우저에서 인증이 완료되면 “터미널로 돌아가세요”라는 메시지가 표시됩니다.

터미널로 돌아오면 자동으로 Kiro CLI에 로그인된 상태입니다.

***

## 3. Sign out of Kiro CLI / Kiro CLI 로그아웃

로그아웃은 아래 명령 한 줄로 수행할 수 있습니다.

```
kiro-cli logout
```

***

## 4. 인증 문제 해결

로그인 과정에서 다음과 같은 문제가 발생할 수 있습니다:

* 브라우저가 열리지 않음
* 인증 후 리디렉션 실패
* 로그인 오류 메시지 발생
* 헤드리스(WSL·CLI-only) 환경에서 코드 인증 실패

이 경우, Kiro CLI에서 제공하는 트러블슈팅 가이드(Troubleshooting Guide) 를 참고하면 운영체제별 해결 방법과 일반적인 오류 해결책을 확인할 수 있습니다.
