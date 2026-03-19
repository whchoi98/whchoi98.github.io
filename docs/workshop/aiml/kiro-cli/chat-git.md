---
title: "Git과 함께 작업하기"
parent: AIML
grand_parent: Workshop
nav_order: 16
last_modified_date: "2026-03-19"
---

# Git과 함께 작업하기
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Git과 함께 작업하기

Kiro CLI는 Git 리포지토리 환경에서 작업할 때 Git-aware Fuzzy Finder(깃 인식 퍼지 파인더) 기능을 제공하여, 컨텍스트에 포함할 파일을 보다 쉽고 빠르게 선택할 수 있도록 지원합니다.

이 기능은 프로젝트 내에서 Git이 추적하는 파일, 변경된 파일, 신규 파일 등을 직관적으로 파악할 수 있게 해주어 효율적인 파일 선택 흐름을 보장합니다.

***

### Git 인식 기반 선택 기능 동작 방식

Git-aware 퍼지 파인더는 리포지토리의 Git 메타데이터를 활용하여 다음과 같은 기능을 제공합니다:

* Git이 추적하는 파일(Git-tracked files)을 자동으로 인식
* Git 상태(Git Status)에 따른 시각적 표시 제공
* Git 변경 이력(Git history)을 기반으로 관련성이 높은 파일을 우선순위로 정렬

\
이를 통해 사용자는 컨텍스트 추가 시 보다 정확하고 효율적인 파일 선택을 수행할 수 있습니다.

***

### Git-aware 파일 선택 사용 방법

#### 1. Git 리포지토리 디렉토리로 이동

터미널에서 컨텍스트를 추가하려는 Git 프로젝트 루트로 이동합니다.

#### 2. /context add

####  명령 실행

```
/context add
```

#### 3. 퍼지 파인더(Fuzzy Finder) 인터페이스 표시

파일 목록과 함께 Git 상태 표시(Git status indicators)가 나타납니다.

예시 상태 표시는 다음과 같습니다:

* M – Modified (수정된 파일)
* A – Added (추가된 파일)
* ? – Untracked (추적되지 않은 파일)

#### 4. 파일 검색 및 선택

* 입력을 통해 특정 파일명 또는 Git 상태에 따라 필터링
* 방향키로 탐색
* Enter 키로 컨텍스트에 추가할 파일 선택

***

### Git-aware 선택 활용 팁

* Git 상태 정보를 검색 기준으로 활용하면 수정된 파일(M) 또는 미추적 파일(?)을 빠르게 찾아 포함할 수 있습니다.
* 퍼지 파인더는 Git 변경 이력 기반으로 최근 수정 파일을 우선 순위에 두고 표시합니다.
* .gitignore에 의해 Git에서 무시되는 파일도 여전히 선택 목록에 나타나지만, 우선순위는 낮게 설정됩니다.
