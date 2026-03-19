---
title: "MCP Security"
parent: Workshop
nav_order: 28
last_modified_date: "2026-03-19"
---

# Security
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

외부 MCP(Model Context Protocol) 서버를 개발 워크플로우와 통합할 때 보안(Security)은 가장 중요한 고려사항입니다.

Kiro CLI의 MCP 보안 모델은 다음의 핵심 원칙에 기반하여 설계되어 있습니다.

* 명시적 허가(Explicit Permission): 모든 MCP 도구(tool)는 실행 전 사용자 승인을 요구합니다.
* 로컬 실행(Local Execution): MCP 서버는 사용자 로컬 환경에서만 실행됩니다.
* 격리(Isolation): MCP 서버는 각각 독립된 프로세스로 실행되어 상호 간섭을 최소화합니다.
* 투명성(Transparency): 사용자는 사용 가능한 모든 도구와 해당 도구가 수행하는 작업을 명확히 확인할 수 있습니다.

***

## 1. Security 고려 사항

Kiro CLI에서 MCP 서버를 사용할 때 반드시 준수해야 할 보안 원칙은 다음과 같습니다.

### 1.1. 신뢰 및 검증(Trust and Verification)

* 신뢰할 수 있는 출처에서 제공하는 MCP 서버만 설치하십시오.
* 설치 전 서버 및 도구의 문서화를 검토하여 동작 방식을 명확히 이해하십시오.
* 관련 보안 권고(Security Advisory)와 패치 업데이트를 주기적으로 확인하십시오.

### 1.2. 접근 제어(Access Control)

* 최소 권한 원칙(Least Privilege Principle)을 적용하여 MCP 서버가 접근할 수 있는 권한을 최소화하십시오.
* 파일 시스템 접근은 반드시 필요한 디렉터리로 한정하십시오.
* 서버의 네트워크 접근 권한을 제한하고, 불필요한 외부 호출을 차단하십시오.
* 민감한 인증 정보는 환경 변수(Environment Variables)를 통해 안전하게 전달하십시오.

### 1.3. 자격 증명 관리(Credential Management)

* API 키, 토큰 등 민감한 데이터는 절대 구성 파일(config file)에 직접 하드코딩하지 마십시오.
* 시스템 키체인 또는 안전한 비밀 관리 솔루션을 활용하여 자격 증명을 보관하십시오.
* 정기적으로 인증 정보를 교체(rotate)하여 보안을 강화하십시오.

### 1.4. 네트워크 보안(Network Security)

* 원격 MCP 서버를 사용할 경우 반드시 HTTPS(SSL/TLS) 프로토콜을 사용하십시오.
* 서버 인증서의 유효성과 신뢰성을 검증하십시오.
* 광범위한 네트워크 접근을 요구하는 서버는 특별히 주의하여 사용하십시오.
* 이상 트래픽 탐지 등 네트워크 활동을 모니터링하십시오.

### 1.5. 모니터링 및 감사(Monitoring and Auditing)

* MCP 서버 로그를 주기적으로 검토하여 비정상적 또는 예기치 않은 동작을 탐지하십시오.
* 설치된 MCP 서버 및 활성화된 도구 목록을 주기적으로 점검하십시오.
* 사용하지 않거나 신뢰할 수 없는 서버는 즉시 비활성화하거나 제거하십시오.

***

## 2.모범사례

아래는 안전한 MCP 운영을 위한 권장 구성 및 운영 모범 사례입니다.

### 2.1. 구성 보안

```
# 민감한 데이터는 환경 변수로 관리
export MCP_API_KEY="your-secure-key"
export DATABASE_URL="your-connection-string"

# 환경 변수를 활용하여 MCP 서버 구성 추가
kiro-cli mcp add my-server --env MCP_API_KEY --env DATABASE_URL
```

### 2.2. 권장 사항:

* 환경 변수는 OS 키체인 또는 비밀 관리 도구와 함께 사용하는 것이 가장 안전합니다.
* 공유 저장소(Git 등)에는 환경 변수를 반드시 제외(.gitignore)하십시오.
