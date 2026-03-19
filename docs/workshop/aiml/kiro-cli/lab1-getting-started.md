---
title: "LAB 1. 초기 구축 및 사용"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 2
last_modified_date: "2026-03-19"
---

# LAB 1. Kiro CLI 초기 구축 및 사용
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

*Update: 2025.12.07*
{: .fs-3 .text-grey-dk-000 }

이 문서는 Kiro CLI를 실무 환경에서 활용하기 위한 초기 구축 절차(Initial Setup)와 사용 개시 단계(Getting Started)를 종합적으로 안내합니다.

본 랩(Lab)에서는 다음 과정을 수행합니다:

- Kiro CLI 사용을 위한 Builder ID 등록
- Kiro CLI 다운로드(Download) 및 설치(Installation)
- Kiro CLI 환경 구성(Configuration Options) 이해 및 탐색

{: .note }
> Linux/macOS에서는 GitHub/Google 인증(Authentication)을 지원하며, WSL/헤드리스(Headless) 환경에서는 Builder ID 또는 AWS Identity Center(IdC) 인증이 필요합니다.

---

## 1. Builder ID 생성 절차

{: .highlight }
> 이미 Builder ID를 보유하고 있다면 본 단계를 생략할 수 있습니다.

Kiro CLI의 모든 인증 흐름(Authentication Flow)은 Builder ID를 기반으로 하므로, 유효한 이메일 주소만 있으면 손쉽게 생성할 수 있습니다.

### 생성 절차 요약

1. Builder ID 페이지 접속
2. **Sign in with Builder ID** 선택
3. 브라우저(Browser)에서 이메일 기반 등록 진행

---

## 2. Kiro CLI 설치 절차

Builder ID 준비가 완료되면, Kiro CLI를 다운로드 → 설치 → 초기 구성하는 단계로 이동합니다.

### 2.1. 설치 명령어

```bash
curl -fsSL https://cli.kiro.dev/install | bash
```

### 2.2. 설치 확인

```bash
kiro-cli --version
```

### 2.3. 초기 실행

```bash
cd ~/my-project
kiro-cli
```

정상적으로 실행되면 터미널(Terminal)에서 Kiro와 직접 상호작용(Interaction)하며 개발을 진행할 수 있습니다.

---

## 3. 인증 설정(Authentication Setup)

Kiro CLI는 다음 인증 방식을 지원합니다:

| 인증 방식(Auth Method) | 환경 | 설명 |
|:----------------------|:-----|:-----|
| **Builder ID** | 모든 환경 | 기본 인증 방식, 이메일 기반 |
| **AWS Identity Center (IdC)** | 기업 환경 | SSO 기반 조직 인증 |
| **GitHub / Google OAuth** | macOS, Linux | 소셜 로그인 기반 |

---

## 참고 자료(References)

- [원본 소스(Source): whchoi98/awsmcp](https://github.com/whchoi98/awsmcp/blob/main/kiro-cli/lab-1-.-kiro-cli.md)
- [Kiro CLI 설치 가이드](https://kiro.dev/docs/getting-started/)
