---
title: "Auto Complete"
parent: Kiro CLI Workshop
nav_order: 32
last_modified_date: "2026-03-19"
---

# Auto Complete
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Completions & Autocomplete

Kiro CLI는 터미널 작업 효율을 극대화하기 위해 두 가지 AI 기반 자동완성 기능을 제공합니다:

1. Autocomplete Dropdown Menu
   * 커서 우측에 표시되는 그래픽 기반 자동완성 메뉴
2. Inline Suggestions
   * 사용자가 입력하는 동안 회색 “고스트 텍스트” 형태로 제안 제공

두 기능은 서로 독립적으로 작동하며, git, npm, docker, aws 포함 수백 개의 CLI 도구를 지원합니다.

***

## 2. Autocomplete Dropdown Menu

Autocomplete Dropdown은 명령어를 입력하는 즉시 커서 오른쪽에 표시되며, 사용할 수 있는 옵션, 서브커맨드(Subcommand), 인수를 시각적으로 탐색할 수 있게 합니다.

### 사용 방법

Autocomplete 기능은 Kiro CLI 설치 직후 자동 활성화됩니다.

1. 터미널 또는 명령 프롬프트를 엽니다.
2. 명령어 입력을 시작합니다.
3. 자동완성 메뉴가 화면에 표시됩니다.
4. 화살표 키로 제안 항목을 탐색합니다.
5. Tab 또는 Enter로 선택합니다.

***

## 3. 설정

```
# 자동완성 활성/비활성화
kiro-cli settings autocomplete.disable false   # 활성화
kiro-cli settings autocomplete.disable true    # 비활성화

# 테마 변경
kiro-cli theme dark
kiro-cli theme light
kiro-cli theme system

# 현재 테마 확인
kiro-cli theme

# 사용 가능한 테마 목록 보기
kiro-cli theme --list
```

테마 시스템은 시각적 환경을 개인 취향 또는 접근성 기준에 맞게 조정할 수 있습니다.

***

## 4.Inline Suggestions

Inline Suggestions는 사용자가 입력하는 동안 명령줄 내부에 회색 고스트 텍스트로 제안을 표시하는 기능입니다.

Dropdown 메뉴와는 별도로 동작합니다.

### 4.1. 사용 방법

Inline Suggestions는 기본적으로 활성화되어 있습니다.

1. 명령어 입력을 시작합니다.
2. 회색 고스트 텍스트가 예상 명령을 제안합니다.
3. →(오른쪽 화살표) 또는 Tab으로 해당 제안을 수락합니다.
4. 계속 입력하여 제안을 무시할 수도 있습니다.

***

### 4.2. Inline Suggestions 관리

```
# Inline suggestions 활성화
kiro-cli inline enable

# 비활성화
kiro-cli inline disable

# 현재 상태 확인
kiro-cli inline status

# 특정 커스터마이제이션 설정
kiro-cli inline set-customization [ARN]

# 사용 가능한 커스터마이제이션 목록 확인
kiro-cli inline show-customizations
```

***

## 5. Supported Tools

자동완성 시스템은 광범위한 CLI 도구를 지원하며, 다음 카테고리 전반에서 정교한 제안을 제공합니다.

### 5.1. Popular Tools

* Git: 브랜치명, 커밋 해시, 파일 경로
* Docker: 컨테이너 이름, 이미지 태그, 명령
* npm / yarn: 패키지명, 스크립트, 의존성
* kubectl: 리소스, 네임스페이스, 컨텍스트
* terraform: 리소스, 프로바이더, 변수
* aws: 서비스명, 리전, 리소스 이름

### 5.2. Language Tools

* Python: pip, poetry, conda
* Node.js: npm, yarn, pnpm
* Ruby: gem, bundle
* Go: go mod, go build

### 5.3. System Tools

* Unix/Linux 표준 명령어
* 패키지 관리자(apt, brew, yum)
* 파일 관리 명령(ls, find, grep 등)

***

## 6. 트러블슈팅

자동완성 기능이 예상대로 동작하지 않을 경우 다음을 확인하십시오.

***

### 6.1. Autocomplete Dropdown Issues

문제가 발생할 때 점검할 사항:

* Kiro CLI 정상 설치 여부 확인

```
kiro-cli --version
```

* 자동완성 설정 확인

```
kiro-cli settings autocomplete.disable
```

* 터미널 재시작
* 다른 쉘 시도 (bash, zsh, fish 등)

***

### 6.2. Inline Suggestions Issues

Inline suggestions가 나타나지 않을 때:

* 상태 확인

```
kiro-cli inline status

```

* 필요 시 활성화

```
kiro-cli inline enable

```

* 쉘 호환성 확인
* 터미널 에뮬레이터가 해당 기능을 지원하는지 확인
