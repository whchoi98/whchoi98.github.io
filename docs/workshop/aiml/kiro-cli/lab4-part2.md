---
title: "LAB 4. Kiro CLI Part 2"
parent: AIML
grand_parent: Workshop
nav_order: 41
last_modified_date: "2026-03-19"
---

# LAB 4. Kiro CLI Part2
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

***

## 13. Context

Kiro CLI에서 컨텍스트(Context) 파일은 대화 과정에서 Kiro가 고려해야 할 정보를 포함합니다.

여기에는 프로젝트 요구사항, 코딩 규칙, 개발 표준, 또는 Kiro가 더 정확한 답변을 생성하는 데 도움이 되는 다양한 문서가 포함될 수 있습니다.

컨텍스트를 어떻게 관리하느냐는 Kiro CLI의 출력 품질에 직접적인 영향을 미칩니다.

컨텍스트를 과도하게 제공하면 오히려 성능이 저하될 수 있습니다. 따라서 컨텍스트는 적절히 선별하여 관리하는 것이 중요합니다.

Kiro CLI는 최대 200K tokens의 컨텍스트 윈도우를 가지며, 이는 유한한 자원이므로 효율적으로 운영해야 합니다.

***

### 13. 1 컨텍스 관리 

Kiro CLI 세션에서 작업을 진행하다 보면, 특정 문서를 컨텍스트로 추가해야 할 때도 있고, 세션 시작 시 자동으로 특정 문서가 포함되도록 구성하고 싶을 때도 있습니다.

Kiro CLI는 이러한 컨텍스트를 손쉽게 관리할 수 있는 다양한 메커니즘을 제공합니다.

Kiro CLI는 또한 프로젝트 기반의 지속적 컨텍스트를 관리하기 위해 “steering docs(조정 문서)”를 사용합니다.

Steering 문서는 `.kiro/steering/` 디렉터리에 위치하며, 프로젝트의 규칙, 패턴, 선호 기술 스택 등을 기술해 두어 Kiro가 지속적으로 참고하도록 하는 방식입니다.

***

### 13.2 현재 컨텍스트 보기

현재 Kiro CLI 세션에서 어떤 컨텍스트가 활성화되어 있는지 확인하려면 다음 명령을 사용합니다:

```
/context show
```

출력 예:

```
> /context show

Agent (kiro_default)
  - AmazonQ.md (no matches)
  - AGENTS.md (no matches)
  - README.md (no matches)

Session (temporary)
  <none>
```

이 출력은 다음을 의미합니다:

* Kiro CLI는 지속 컨텍스트로 특정 파일들을 자동 탐색하지만, 현재 디렉터리에는 해당 파일이 없음
* Steering 문서도 아직 존재하지 않음
* 세션 컨텍스트(Session temporary)는 비어 있음

***

### 13.3 컨텍스트 파일 제거

현재 세션에서 활성화된 컨텍스트를 모두 제거하려면 다음 명령을 사용합니다:

```
/context clear
```

예상 출력:

```
Cleared context
Note: Context modifications via slash command is temporary.
```

Kiro CLI를 다시 시작하면

* 지속 컨텍스트(persistent context) 는 다시 로드되고
* 세션 컨텍스트(session context) 는 복구되지 않습니다.

***

### Task-13

Kiro CLI 세션에서 다음을 수행합니다:

1. 컨텍스트 제거:

```
/context clear

```

2. 컨텍스트 조회:

```
/context show
```

3. 세션 종료 후 다시 시작
4. 다시 /context show 실행하여 지속 컨텍스트가 재적용되는지 확인

***

### 13.4 Context usage

현재 컨텍스트 윈도우(token window) 사용 상태는 다음 명령으로 확인할 수 있습니다:

```
/context
```

예시 출력:

```
> /context
Current context window (1.9% used)
█||█████████████████████████████████████████████████████████████████████████████ 1.9%

█ Context files 0.0%
█ Tools 1.7%
█ Kiro responses 0.1%
█ Your prompts 0.1%

💡 Pro Tips:
Run /compact to replace the conversation history with its summary
Run /clear to erase the entire chat history
Run /context show to see usage per context file
```

컨텍스트 윈도우는 다음 4가지 요소가 합산되어 구성됩니다:

<table data-header-hidden><thead><tr><th width="176"></th><th></th></tr></thead><tbody><tr><td>구성 요소</td><td>설명</td></tr><tr><td>Context files</td><td>컨텍스트로 추가된 문서</td></tr><tr><td>Tools</td><td>도구 실행 과정에서 생성된 정보</td></tr><tr><td>Kiro responses</td><td>Kiro의 응답으로 누적된 토큰</td></tr><tr><td>Your prompts</td><td>사용자의 입력 프롬프트</td></tr></tbody></table>

워크샵을 진행하면서 /context 명령을 지속적으로 실행하여 사용량이 어떻게 변화하는지 모니터링하면 좋습니다.

***

### 13.5 Clearing your context window

현재 세션의 전체 컨텍스트 윈도우를 초기화하려면 다음 명령을 실행합니다:

```
/clear
```

실행 시 Kiro는 다음과 같은 경고를 표시합니다:

```
Are you sure? This will erase the conversation history and context from hooks for the current session. [y/n]:
```

{% hint style="info" %}
이 작업은 되돌릴 수 없으므로 주의가 필요합니다.
{% endhint %}

***

### 13.6 Compacting

컨텍스트 윈도우가 가득 찰 경우, Kiro CLI는 자동으로 컨텍스트 압축(compaction) 을 시도하여 요약본을 생성하고 기존 컨텍스트를 교체합니다.\
수동 실행도 가능합니다:

```
/context compact
```

컨텍스트가 충분히 길지 않으면 다음 메시지가 나타납니다:

```
Conversation too short to compact.
```

자동 압축을 끄고 싶다면:

```
kiro-cli settings chat.disableAutoCompaction true
```

압축의 시점은 사용자에 따라 선호가 다를 수 있으므로 개발 워크플로우에 맞추어 설정하는 것을 권장합니다.

***

### 13.7 Session context 제거와 추가

현재 세션에서 특정 파일을 컨텍스트로 추가하려면 다음 명령을 사용합니다:

```
/context add README.md
```

또는 패턴 기반 다중 파일 추가도 가능합니다:

```
/context add ~/context-repo/2-sample-data/*.md
```

출력 예시:

```
Added 1 path(s) to context.
Note: Context modifications via slash command is temporary.
```

/context show 를 실행하면 활성화된 컨텍스트 문서를 확인할 수 있습니다.<br>

예시 출력:

```
Session (temporary)
  ~/project/README.md
  ~/context-repo/2-sample-data/AGENTS.md
  ~/context-repo/2-sample-data/data-bod.md

3 matched files in use
...
```

파일이 아직 존재하지 않아도 강제로 추가하고 싶다면:

```
/context add yourfile.md -f
```

***

### Task-15

1. 다음 내용을 가진 tmp-context.md 파일 생성:

```
cat << EOF > ~/kiro-cli-workshop/tmp-context.md
당신은 파이썬(Python) 으로 코드를 작성하는 것을 좋아합니다.
플라스크(Flask) 웹 애플리케이션 프레임워크(web application framework)를 선호합니다.
공백(space) 대신 탭(tab) 을 사용합니다.
모든 데이터 처리를 위해 PostgreSQL 을 사용합니다.
EOF
```

2. Kiro CLI 세션에서 다음 실행:

```
/context add tmp-context.md
```

3. 컨텍스트 상태 확인:

```
/context show
```

4. 출력 예시

```
> /context show

Agent (kiro_default)
  - AmazonQ.md (no matches)
  - AGENTS.md (no matches)
  - README.md (no matches)

Session (temporary)
  <none>

No files in the current directory matched the rules above.



> /context add tmp-context.md


Added 1 path(s) to context.
Note: Context modifications via slash command is temporary.
```

***

### 13.8 요약

* 컨텍스트 파일은 Kiro의 응답 품질에 결정적 역할을 합니다.
* 지속 컨텍스트(README, steering docs 등)는 세션 재시작 시 자동 복원됩니다.
* 세션 컨텍스트는 임시적이며 `/context add` 로 추가 가능합니다.
* `/context` 명령으로 전체 컨텍스트 윈도우의 토큰 사용량을 확인할 수 있습니다.
* 과도한 컨텍스트는 오히려 품질을 낮출 수 있으므로 적절한 관리가 필수적입니다.

***

## 14. Compacting(컨텍스트 압축)

컨텍스트 윈도우(Context Window)가 가득 차기 시작하면 Kiro CLI는 자동으로 컨텍스트 압축(Compaction) 기능을 수행하여, 기존 대화 내역과 컨텍스트를 요약한 형태로 치환합니다.

이 기능을 통해 제한된 최대 컨텍스트 용량(200K tokens)을 보다 효율적으로 사용할 수 있습니다.

또한, 필요할 경우 수동으로 컨텍스트 압축을 실행할 수도 있습니다.

***

### 14.1 수동 Compact 실행

다음 명령어를 사용하여 현재 세션의 컨텍스트를 요약하여 압축할 수 있습니다:

```
/context compact
```

컨텍스트 길이가 충분하지 않을 경우, Kiro CLI는 다음 메시지를 출력합니다:

```
Conversation too short to compact.
```

이는 현재 대화 기록 또는 컨텍스트가 요약을 수행할 만큼 충분히 축적되지 않았음을 의미합니다.

***

### 14.2 자동 Compact 동작

Kiro CLI는 컨텍스트 윈도우가 임계점에 도달할 경우 자동으로 압축을 시도합니다.

그러나, 개발자의 선호에 따라 자동 압축 기능을 비활성화할 수도 있습니다.

자동 압축을 비활성화하려면 다음 설정을 사용합니다:

```
kiro-cli settings chat.disableAutoCompaction true
```

이 설정을 적용하면:

* Kiro CLI는 더 이상 자동으로 컨텍스트를 요약하지 않으며
* 컨텍스트가 가득 차더라도 사용자가 직접 /context compact를 실행해야 합니다.

***

### 14.3 Compacting 사용 시 고려 사항

컨텍스트 압축은 다음과 같은 장단점을 가집니다:

#### 장점

* 컨텍스트 윈도우의 용량을 확보하여 장기 세션에서도 작업 지속 가능
* 필요 없는 상세 정보를 요약하여 유지 비용 절감

#### 주의할 점

* 압축 과정에서 세부적인 문맥 정보가 요약되며 일부 손실될 수 있음
* 자동 압축 비활성화 시, 컨텍스트 부족으로 작업 실패가 발생할 가능성 있음
* 프로젝트 성격에 따라 자동 압축과 수동 압축 중 더 적합한 방식을 선택해야 함

***

### 14.4 워크플로우 팁(Pro Tips)

* 장시간 또는 대규모 프로젝트 작업 시, 정기적으로 `/context` 명령어로 사용량을 확인하십시오.
* 자동 압축을 끈 경우, 맥락이 과도하게 쌓이기 전에 직접 `/context compact` 수행이 필요합니다.
* 압축은 “대화 품질”과 “맥락 유지” 간의 균형이므로, 팀 또는 작업 유형에 맞는 정책을 설정하는 것이 좋습니다.

***
