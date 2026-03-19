---
title: "도구 권한 관리(Tool Permissions)"
parent: Kiro CLI Workshop
nav_order: 15
last_modified_date: "2026-03-19"
---

# 도구 권한 관리
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Kiro가 시스템에서 작업을 수행할 때 사용하는 Tools(도구) 에 대한 권한을 /tools 명령어를 통해 세밀하게 제어할 수 있습니다. 이를 통해 Kiro가 수행할 수 있는 작업 범위와 안전성을 사용자가 직접 정의할 수 있습니다.

***

## 1. Tools Commands

<table data-header-hidden><thead><tr><th width="175.2734375"></th><th></th></tr></thead><tbody><tr><td>Command</td><td>Description</td></tr><tr><td>help</td><td>Tools 관련 도움말 표시</td></tr><tr><td>trust</td><td>특정 도구를 해당 세션 동안 신뢰(자동 승인)하도록 설정</td></tr><tr><td>untrust</td><td>특정 도구를 요청 시마다 확인하도록 설정</td></tr><tr><td>trust-all</td><td>모든 도구를 신뢰하도록 설정 <em>(이전 /acceptall 명령과 동일)</em></td></tr><tr><td>reset</td><td>모든 도구 권한을 기본값으로 재설정</td></tr></tbody></table>

현재 설정된 도구 권한을 확인하려면 다음을 실행합니다:

```
$ kiro-cli chat
Kiro> /tools
```

이 명령은 현재 사용 가능한 도구 목록과 각 도구의 권한 상태(Trusted 또는 Per-request) 를 출력합니다.

***

## 2. 권한 상태

도구 권한은 두 가지 상태 중 하나입니다:

*   Trusted

    Kiro가 해당 도구를 사용할 때 추가 승인 없이 자동으로 실행됩니다.
*   Per-request

    Kiro가 도구 사용 시 매번 사용자에게 확인을 요청합니다.

특정 도구를 신뢰하거나 신뢰 해제하려면 다음과 같이 실행합니다:

```
Kiro> /tools trust read
Kiro> /tools untrust shell
```

모든 도구를 한 번에 신뢰하려면:

```
Kiro> /tools trust-all
```

***

## ⚠️ 주의

/tools trust-all 명령은 편리하지만 보안 리스크가 존재합니다.

자세한 내용은 _Understanding security risks_ 문서를 참고하십시오.

***

## 3. 지원 도구

Kiro가 기본적으로 사용할 수 있는 도구는 다음과 같습니다:

<table data-header-hidden><thead><tr><th width="126.015625"></th><th></th></tr></thead><tbody><tr><td>Tool</td><td>Description</td></tr><tr><td>read</td><td>파일 및 디렉토리 조회</td></tr><tr><td>write</td><td>시스템의 파일 생성 및 수정</td></tr><tr><td>shell</td><td>Bash 명령 실행</td></tr><tr><td>aws</td><td>AWS CLI 호출 및 AWS 서비스와 상호작용</td></tr><tr><td>report</td><td>AWS에 문제 보고를 위한 브라우저 실행</td></tr></tbody></table>

도구가 신뢰되지 않은 상태에서 Kiro가 해당 도구를 사용하려고 하면,사용자에게 허용(Allow), 거부(Deny), 또는 세션 동안 신뢰(Trust for session) 를 선택하도록 요청합니다.

기본 신뢰 상태:

* read 도구만 기본적으로 Trusted
* 나머지는 모두 Per-request

***

## 4. 도구 신뢰/비신뢰 설정 사례

\
다음은 권한 설정을 선택하는 데 도움이 되는 대표적인 시나리오입니다:

####  Trust read (fs\_read 신뢰) 

* 코드베이스 탐색 등 파일을 반복적으로 읽는 작업을 수행할 때

#### Trust write (fs\_write 신뢰)

* 프로젝트 개발 중이며, Kiro에게 파일 생성/수정 작업을 적극적으로 맡기고 싶을 때

#### Untrust shell (execute\_bash 비신뢰)

* 민감한 환경에서 bash 명령 실행을 사용자가 직접 검토하고 싶을 때

####  Untrust aws (use\_aws 비신뢰)

* 프로덕션 AWS 리소스를 다룰 때 예기치 않은 변경을 방지하기 위해

***

## 5. 권한 표시

Kiro가 도구를 사용할 때마다 현재 적용 중인 권한 수준(Trusted/Per-request) 을 명확히 표시하여 사용자가 실행 과정과 보안 상태를 투명하게 파악할 수 있도록 합니다.

***

## 6. 세션 시작 시 도구 권한 지정

kiro-cli chat 세션을 시작할 때 원하는 권한 구성을 사전에 지정할 수도 있습니다.

이 기능을 통해 매 세션마다 같은 권한을 반복 설정할 필요가 없습니다.
