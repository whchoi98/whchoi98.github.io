---
title: "Tangent Mode"
parent: Kiro CLI Workshop
nav_order: 36
last_modified_date: "2026-03-19"
---

# Tangent Mode
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

Tangent Mode는 대화의 흐름을 보존한 채, 임시로 다른 주제를 탐색할 수 있도록 설계된 대화 분기 기능입니다.

사용자는 Tangent Mode로 진입하여 보조 질문·개념 확인·짧은 탐색을 수행한 뒤, 언제든지 원래 대화 지점으로 복귀할 수 있습니다.

***

## 1. 개요

Tangent Mode는 “대화 체크포인트(checkpoint)“를 생성하여 다음을 가능하게 합니다:

* 메인 대화 흐름 보존
* 임시적인 측면 질문(side-topic) 수행
* 탐색 종료 후 즉시 원래 대화로 복귀
* 필요 시 Tangent 결과 일부를 메인 대화에 병합

이 기능은 특히 개념 확인, 도구 사용법 검색, 의사결정 전 대안 검토, 짧은 보조 대화에 유용합니다.

***

## 2. Tangent Mode 활성화

Tangent Mode는 실험적 기능이므로 다음 중 하나를 통해 활성화해야 합니다.

### 방법 1: Experiment 메뉴

```
/experiment
# Tangent Mode 선택 후 활성화
```

### 방법 2: 설정 직접 변경

```
kiro-cli settings chat.enableTangentMode true
```

***

## 3. 기본 사용법

### 3.1 Tangent Mode 진입

아래 명령 또는 단축키(Ctrl+T)를 사용합니다.

```
/tangent
```

출력 예:

```
Created a conversation checkpoint (↯). Use ctrl+t or /tangent to restore.
```

프롬프트는 다음과 같이 변경됩니다.

```
↯ > 
```

### 3.2 Tangent Mode에서 대화

Tangent 환경에서는 자유롭게 질문하거나 개념을 탐구할 수 있습니다.

예:

```
↯ > What is the difference between async and sync functions?
```

### 3.3 Tangent Mode 종료

다시 /tangent 또는 Ctrl+T 를 실행합니다.

```
↯ > /tangent
Restored conversation from checkpoint (↯).
```

메인 대화로 정확히 복귀합니다.

### 3.4 Tail Mode

Tangent에서 마지막 Q\&A 페어를 메인 대화에 병합하고 싶을 때 사용합니다.

```
/tangent tail
```

출력 예:

```
Restored conversation from checkpoint (↯) with last conversation entry preserved.
```

***

## 4. 사용 예

### Example 1 – 대안 탐색

메인 질문:

```
> I need to process a large CSV file in Python...
```

대안 탐색:

```
> /tangent
↯ > What about using the csv module instead of pandas?
```

탐색 종료:

```
↯ > /tangent
> Thanks! I'll go with pandas...
```

***

### Example 2 – CLI 도움 요청

메인 대화 중 CLI 도움 필요:

```
/tangent
↯ > What Kiro CLI commands are available for file operations?
```

종료 후 메인 대화로 복귀:

```
↯ > /tangent
> It's a Node.js application for AWS
```

***

### Example 3 – 요구사항 정리

메인:

```
> I need to optimize this SQL query
```

Tangent에서 명확화:

```
↯ > What information do you need to help optimize a query?
```

***

### Example 4 – Tail 모드 사용

유용한 Tangent Q\&A를 보존하고 싶은 경우:

```
↯ > /tangent tail
# 마지막 대화가 메인 대화에 포함됨
```

***

## 5. 구성

### 5.1 키보드 단축키 변경

```
kiro-cli settings chat.tangentModeKey y
```

### 5.2 Kiro CLI 도움말 자동 Tangent

도움말 요청 시 자동 Tangent 모드로 전환:

```
kiro-cli settings introspect.tangentMode true
```

### 5.3 시각적 표시

<table data-header-hidden><thead><tr><th width="140.66796875"></th><th></th></tr></thead><tbody><tr><td>상태</td><td>프롬프트</td></tr><tr><td>Normal</td><td>></td></tr><tr><td>Tangent</td><td>↯ ></td></tr><tr><td>Agent 활성</td><td>[agent] ↯ ></td></tr></tbody></table>

***

## 6. Tangent Mode 활용 시나리오

### 적합한 시나리오

* 메인 주제와 직접 관련된 짧은 보조 질문
* 개념 확인, “이게 무슨 뜻이야?”
* 결정을 내리기 전에 대안 비교
* Kiro CLI 명령 도움말 조회
* 메인 흐름을 오염시키고 싶지 않을 때

### 적합하지 않은 시나리오

* 주제가 전혀 다른 장시간 대화 → 새 세션 시작 권장
* 메인 컨텍스트에 반드시 포함되어야 하는 대화 → Tangent 불필요

***

## 7. Tips

* Tangent는 짧게 사용하고 빠르게 복귀하는 것이 이상적
* /tangent tail은 정말 중요한 Tangent Q\&A만 메인에 남길 때 사용
* Tangent 중이라는 것을 잊지 않도록 프롬프트의 ↯ 를 확인
* 실험적인 아이디어를 안전하게 테스트할 때 유용

***

## 8. 동작 방식

### 8.1 Checkpoint 생성

Tangent 진입 시:

1. 현재 대화 상태를 저장 (Checkpoint 생성)
2. Tangent 전용 스레드로 분기
3. 메인 대화는 정지된 상태로 유지

### 8.2 Restoration

Tangent 종료 시:

* 저장된 Checkpoint로 되돌림
* Tangent 대화 내용은 기본적으로 폐기
* Tail 사용 시 마지막 Q\&A만 유지

### 8.3 Limitations

* Tangent 중첩 불가 (단일 레벨)
* Tail을 사용하지 않으면 Tangent 대화는 복구 불가
* 기능은 실험적이며 향후 변경될 수 있음

***

## 9. 트러블슈팅

| 문제                   | 해결방법                 |
| -------------------- | -------------------- |
| Tangent 모드가 작동하지 않음  | 실험 기능 활성화 여부 확인      |
| 단축키 작동 안됨            | 올바른 Ctrl+키 조합인지 확인   |
| Tangent에서 벗어나는 법을 잊음 | /tangent 실행          |
| Tangent 내용을 잃어버림     | 복구 불가 → 필요 시 Tail 사용 |

***

## 10. 모범사례

### 권장 워크플로우

1. 메인 작업 수행
2. 보조 질문 필요 시 /tangent
3. 필요한 내용만 탐색
4. Tail 여부 결정 (/tangent 또는 /tangent tail)
5. 원래 대화로 복귀하여 업무 지속
