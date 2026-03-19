---
title: "실험적 기능(Experimental)"
parent: Workshop
nav_order: 34
last_modified_date: "2026-03-19"
---

# 실험적 기능
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Kiro CLI는 고급 기능을 빠르게 실험하고 사용자 피드백을 수집하기 위해 여러 실험적 기능(Experimental Features)을 제공합니다. 이 기능들은 활성화 여부를 선택적으로 설정할 수 있으며, /experiment 명령을 통해 손쉽게 관리할 수 있습니다.

***

### 중요 고려 사항

{: .warning }
Experimental 기능은 예고 없이 변경되거나 제거될 수 있습니다.\
사용 경험이 완전하지 않을 수 있습니다.\
프로덕션 환경 사용 시 주의가 필요합니다.

이 기능들은 새로운 기능의 안정성 및 유용성을 평가하기 위한 목적이며, 문제 발생 시 kiro issue 명령을 통해 피드백을 제공해 주시기 바랍니다.

***

## 1. 실험적 기능의 관리

실험적 기능은 `/experiment` 명령으로 관리할 수 있습니다.

```
/experiment
```

실행 시 다음 기능을 제공합니다:

* 각 실험 기능의 현재 상태(ON/OFF) 확인
* 선택하여 기능 활성화/비활성화
* 기능 설명 확인

***

## 2. 주요 실험적 기능 목록

아래는 Kiro CLI에서 제공하는 주요 실험적 기능 목록입니다.

***

### 2.1. Knowledge Management

`Command: /knowledge`

Persistent Knowledge Base 기능을 추가하여 대화 세션 간 지속적인 문맥 저장 및 검색을 제공합니다.

#### 기능

* 파일, 디렉터리, 텍스트 기반 지식 저장
* 의미 기반 검색(Semantic Search) 지원
* 세션 간 유지되는 지속형 지식 저장소
* 에이전트별 지식 격리

#### 활성화 방법

```
kiro-cli settings chat.enableKnowledge true
```

***

### 2.2. Tangent Mode

`Command: /tangent or Ctrl+T`

메인 대화를 유지한 상태에서 사이드 토픽을 탐색할 수 있는 모드입니다.

#### 기능

* 대화 체크포인트 생성
* 주제와 독립된 분기(conversational branch) 탐색
* 필요 시 메인 대화로 복귀
* 전체 문맥 유지

#### 활성화 방법

```
kiro-cli settings chat.enableTangentMode true
```

***

### 2.3. TODO Lists

`Tool: todo | Command: /todo`

Kiro가 자동으로 TODO 리스트를 생성하고 관리하는 기능입니다.

#### 기능

* Kiro가 맥락에 따라 자동 TODO 생성
* TODO 조회·관리·삭제 지원
* 기존 TODO 리스트 이어서 사용
* 세션 간 지속됨

#### 활성화 방법

```
kiro-cli settings chat.enableTodoList true
```

***

### 2.4. Thinking Tool

AI의 단계별 사고(process of reasoning)를 투명하게 보여주는 기능입니다.

#### 기능

* 복잡한 문제 해결 과정 가시화
* 단계별 사고(Chain-of-thought) 출력
* 디버깅 및 학습 목적에 유용
* 결론 도출 과정 명확화

#### 활성화 방법

```
kiro-cli settings chat.enableThinking true
```

***

### 2.5. Checkpointing

Command: /checkpoint

Git 기반 스냅샷과 유사한 방식으로 파일 변경 사항을 세션 단위로 추적합니다.

#### 기능

* Shadow Git Repo에 변경 사항 저장
* 체크포인트 목록/확장/비교(diff)/복원 지원
* 복원 시 대화 히스토리도 해당 시점으로 되돌림
* Git 저장소에서는 자동 활성화
* 비-Git 디렉터리도 수동 초기화 가능

#### 활성화 방법

```
kiro-cli settings chat.enableCheckpoint true
```

#### 주요 사용 방법

```
/checkpoint list
/checkpoint expand <tag>
/checkpoint diff <tag1> [tag2]
/checkpoint restore [<tag>]
/checkpoint clean
```

***

### 2.6. Context Usage Percentage

프롬프트에 현재 컨텍스트 사용량(%)을 시각적으로 표시합니다.

예:

```
[rust-agent] 6% >
```

#### Color Indicators

* Green: 50% 미만
* Yellow: 50–89%
* Red: 90–100%

#### 활성화 방법

```
kiro-cli settings chat.enableContextUsageIndicator true
```

***

### 2.7. Delegate

Kiro가 비동기(background) 작업을 실행하고, 병렬 에이전트 세션을 관리할 수 있도록 합니다.

#### 기능

* 자연어 기반 백그라운드 태스크 생성
* 특정 에이전트로 병렬 대화 세션 실행
* 각 작업의 진행 상황 개별 모니터링
* 보안 확인을 위한 에이전트 승인 절차 제공

#### 활성화 방법

```
kiro-cli settings chat.enableDelegate true
```

#### 사용 예제

```
API 엔드포인트(API endpoints)의 성능을 분석하기 위한 백그라운드 작업(background task)을 생성할 수 있습니까?
```

***

## 3. 설정 통합

실험적 기능 설정은 모두 Kiro CLI 설정에 저장되며, 세션 간 지속됩니다.

```
# 모든 실험 설정 보기
kiro-cli settings list | grep -i enable

# 실험 기능 개별 활성화/비활성화
kiro-cli settings chat.enableKnowledge true
kiro-cli settings chat.enableTangentMode true
kiro-cli settings chat.enableTodoList true
kiro-cli settings chat.enableThinking true
kiro-cli settings chat.enableCheckpoint true
kiro-cli settings chat.enableContextUsageIndicator true
kiro-cli settings chat.enableDelegate true
```

***

## 4.Fuzzy Search 지원

모든 실험 기능 명령은 fuzzy search(Ctrl+S)에서도 사용할 수 있습니다:

* `/experiment` — 실험 기능 관리
* `/knowledge` — Knowledge Base 관련 명령
* `/todo` — TODO 관리 명령
* `/tangent` — Tangent Mode
* `/checkpoint` — Checkpoint 기능

***

## 5. 모범사례

#### 1. 비프로덕션 환경에서 먼저 실험

실험 기능은 불안정할 수 있으므로 안전한 프로젝트에서 우선 테스트하십시오.

#### 2. 적극적인 피드백 제공

kiro issue 명령을 사용해 개선점을 제공해 주십시오.

#### 3. 릴리즈 노트 확인

업데이트 또는 변경 사항을 주기적으로 확인하십시오.

#### 4. 기능 제한 사항 인지

각 기능의 상세 문서에서 알려진 이슈 및 제한 사항 확인.

#### 5️. 백업 필수

Checkpointing, TODO 등 파일 변경 가능성이 있는 기능은 반드시 백업을 유지하십시오.

***

## 6. 트러블슈팅

### Feature Not Working

1. 기능이 활성화되어 있는지 확인

```
kiro-cli settings list | grep -i enable
```

1. 오류 메시지 확인
2. 기능 비활성화 후 재활성화

```
kiro-cli settings chat.enableFeatureName false
kiro-cli settings chat.enableFeatureName true
```

3. Kiro CLI 재시작

***

### Commands Not Available

*   명령 실행 전에 해당 기능이 활성화되어 있는지 확인하십시오.

    예: /knowledge는 Knowledge Management 기능을 활성화해야 작동합니다.
