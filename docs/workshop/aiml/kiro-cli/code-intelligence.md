---
title: "Code Intelligence"
parent: AIML
grand_parent: Workshop
nav_order: 33
last_modified_date: "2026-03-19"
---

# Code Intelligence
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. Code Intelligence

### 1.1 개요(Overview)

Code Intelligence는 언어 서버 프로토콜(Language Server Protocol, LSP) 을 Kiro CLI에 통합하여, IDE 확장 기능과 유사한 수준의 코드 의미 분석(Semantic understanding) 을 Kiro 에이전트가 수행할 수 있도록 하는 기능입니다.

기본적으로 다음 7개 언어가 사전 구성(pre-configured)되어 제공됩니다.

* TypeScript
* Rust
* Python
* Go
* Java
* Ruby
* C / C++

또한 프로젝트 루트의 .kiro/settings/lsp.json 파일에 커스텀 LSP 구성(Custom LSP configuration) 을 추가함으로써, 사실상 모든 언어로 확장할 수 있습니다.

`/code init` 명령을 실행한 이후에는 자연어 질의를 통해 다음과 같은 고급 코드 탐색 및 분석 작업을 수행할 수 있습니다.

* 심볼 검색(Symbol search)
* 참조 검색(Find references)
* 정의 위치 탐색(Go to definition)
* 파일 간 리네이밍(Rename across files)
* 진단 정보 조회(Diagnostics)

***

### 1.2 동작 방식(How it works)

Kiro CLI는 백그라운드에서 LSP 서버 프로세스(Language Server processes) 를 실행하며, 이들은 표준 입출력(stdio) 을 통해 JSON-RPC 방식으로 통신합니다.

워크스페이스를 초기화하면 다음 과정을 거칩니다.

1. 프로젝트 마커(Project markers) 탐지 - 예: package.json, Cargo.toml 등
2. 파일 확장자(File extensions) 기반 언어 감지
3. 적절한 언어 서버(Language server) 자동 실행

실행된 언어 서버는 지속적으로 코드베이스를 분석하여 다음 정보를 인덱싱(Indexing)합니다.

* 심볼(Symbols)
* 타입(Types)
* 참조(References)

사용자가 자연어로 질의하면, Kiro는 이를 LSP 프로토콜 요청으로 변환하여 해당 서버에 전달하고, 결과를 사람이 읽기 쉬운 형식으로 가공하여 반환합니다.

***

### 1.3 LSP 활성화 절차(Enabling LSP integration)

Kiro CLI에서 LSP 서버를 사용하기 위한 기본 절차는 다음과 같습니다.

1. 언어 서버(Language servers) 설치
2. LSP 통합 활성화(Enable LSP integration)
3. 코드 관련 자연어 질의 수행

***

### 1.4 언어 서버 설치(Installing language servers)

#### 1.4.1 지원 언어(Supported Languages)

아래 표는 현재 공식적으로 지원되는 언어, 파일 확장자, 사용되는 LSP 서버, 설치 명령어를 정리한 것입니다.

| Language                | Extensions           | Server                     | Install Command                                         |
| ----------------------- | -------------------- | -------------------------- | ------------------------------------------------------- |
| TypeScript / JavaScript | .ts, .js, .tsx, .jsx | typescript-language-server | npm install -g typescript-language-server typescript    |
| Rust                    | .rs                  | rust-analyzer              | rustup component add rust-analyzer                      |
| Python                  | .py                  | jedi-language-server       | npm install -g pyright or pip install pyright           |
| Go                      | .go                  | gopls                      | go install golang.org/x/tools/gopls@latest              |
| Java                    | .java                | jdtls                      | brew install jdtls (macOS)                              |
| Ruby                    | .rb                  | solargraph                 | gem install solargraph                                  |
| C / C++                 | .c, .cpp, .h, .hpp   | clangd                     | brew install llvm (macOS) or apt install clangd (Linux) |

***

### 1.5 Code Intelligence 초기화(Initialize Code Intelligence)

#### 1.5.1 워크스페이스 범위 구성(Workspace-scoped configuration)

Code Intelligence 설정은 전역(Global)이 아닌 워크스페이스(Project) 단위 로 관리됩니다.

각 프로젝트는 독립적인 LSP 설정을 가집니다.

프로젝트 루트에서 다음 명령을 실행합니다.

```
/code init
```

이 명령은 .kiro/settings/lsp.json 파일을 생성하고 언어 서버를 시작합니다.

***

#### 1.5.2 초기화 시 출력 예시

```
✓ Workspace initialization started

Workspace: /path/to/your/project
Detected Languages: ["python", "rust", "typescript"]
Project Markers: ["Cargo.toml", "package.json"]

Available LSPs:
○ clangd (cpp) - available
○ gopls (go) - not installed
◐ jdtls (java) - initializing...
✓ jedi-language-server (python) - initialized (687ms)
✓ rust-analyzer (rust) - initialized (488ms)
○ solargraph (ruby) - not installed
✓ typescript-language-server (typescript) - initialized (214ms)
```

#### 1.5.3 상태 표시(Status indicators)

* ✓ : 초기화 완료 및 사용 가능
* ◐ : 초기화 진행 중
* ○ available : 설치되어 있으나 현재 프로젝트에서 사용되지 않음
* ○ not installed : 시스템에 설치되지 않음

***

#### 1.5.4 기타 제어

* 언어 서버 재시작:

```
/code init -f
```

* 자동 초기화(Auto-initialization): `.kiro/settings/lsp.json` 이 존재하면 Kiro CLI 시작 시 자동 초기화
* 비활성화(Disable): `.kiro/settings/lsp.json` 삭제 후 세션 재시작

***

### 1.6 언어 서버 활용(Using Language Servers)

언어 서버는 자연어 기반 질의를 통해 다음과 같은 의미 기반 코드 인텔리전스(Semantic code intelligence) 기능을 제공합니다.

* 심볼 탐색
* 정의 위치 이동
* 참조 검색
* 리네이밍
* 진단 정보 확인
* 메서드 문서 조회
* API 탐색

#### 1.6.1 예제 1: 심볼 검색 

```
> Find the UserRepository class
```

결과:

```
1. Class UserRepository at src/repositories/user.repository.ts:15:1
```

#### 1.6.2 예제 2: 참조 검색

```
> Find references of Person class
```

#### 1.6.3 예제 3: 정의 위치 탐색 

```
> Find the definition of UserService
```

#### 1.6.4 예제 4: 파일 내 심볼 조회

```
> What symbols are in auth.service.ts?
```

#### 1.6.5 예제 5: 드라이 런 리네이밍

```
> Dry run: rename the method "FetchUser" to "fetchUserData"
```

#### 1.6.6 예제 6: 진단 정보 조회

```
> Get diagnostics for main.ts
```

#### 1.6.7 예제 7: 호버 정보 조회

```
> What's the documentation for the authenticate method in AuthService?
```

#### 1.6.8 예제 8: 코드 자동완성 탐색

```
> What methods are available on the s3Client instance?
```

### 1.7 커스텀 언어 서버

프로젝트의 .kiro/settings/lsp.json 파일을 수정하여 커스텀 언어 서버를 추가할 수 있습니다.

```
{
  "languages": {
    "mylang": {
      "name": "my-language-server",
      "command": "my-lsp-binary",
      "args": ["--stdio"],
      "file_extensions": ["mylang", "ml"],
      "project_patterns": ["mylang.config"],
      "exclude_patterns": ["**/build/**"],
      "multi_workspace": false,
      "initialization_options": { "custom": "options" }
    }
  }
}
```

#### 필드 설명

* name: 언어 서버 표시 이름
* command: 실행할 바이너리 또는 명령
* args: 명령 인자
* file\_extensions: 처리 대상 파일 확장자
* project\_patterns: 프로젝트 루트 식별 파일
* exclude\_patterns: 분석 제외 경로
* multi\_workspace: 멀티 워크스페이스 지원 여부
* initialization\_options: LSP 초기화 옵션
* request\_timeout\_secs: 요청 타임아웃(초), 기본값 60

***

### 1.8 문제 해결

| Issue                           | Cause(s)       | Solution                     |
| ------------------------------- | -------------- | ---------------------------- |
| Workspace is still initializing | LSP 서버 초기화 중   | 대기 후 재시도, 필요 시 /code init -f |
| LSP initialization failed       | 서버 오류          | /code logs -l로 로그 확인         |
| No symbols found                | 인덱싱 중 또는 문법 오류 | 파일 오류 확인, 검색어 확장             |
| No definition found             | 위치가 심볼이 아님     | 행·열 위치 재확인                   |

***

### 1.9 모범 사례(Best Practices)

* 프로젝트당 1회 초기화
* 정확한 위치(행·열) 사용
* 리네이밍 전 dry\_run 활용
* 진단 오류 먼저 해결
* 검색어는 구체적으로 사용
* 문서는 자연어로 질의
* 외부 API는 대화형으로 탐색

***

### 1.10 제약 사항(Limitations)

* LSP 기능 지원 범위는 서버별로 상이
* 대규모 코드베이스에서는 초기 인덱싱 지연 가능
