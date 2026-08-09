# Security / 보안 구현 상세

[![English](https://img.shields.io/badge/Language-English-blue)](#english)
[![한국어](https://img.shields.io/badge/Language-한국어-red)](#korean)

<a id="english"></a>
## English

### 1. Overview
This is a public GitHub Pages blog: everything pushed to main is published to the internet.
The security layer therefore focuses on preventing secret/identifier leakage into published
content, blocking dangerous operations in the Claude Code harness, and keeping internal
documents out of the build output.

### 2. Components
| Component | Path | Purpose |
|---|---|---|
| Secret scan hook | `.claude/hooks/secret-scan.sh` | PreToolUse(Bash) hook; scans staged files for AWS/GitHub/Anthropic/Slack/Stripe/Google keys, passwords, and API key assignments. Exits 1 to block - registered WITHOUT `\|\| true` so blocking actually works |
| Deny list | `.claude/settings.json` | Denies `rm -rf`, `git push --force`, `git reset --hard`, `git clean -f`, `git add -A`, `git add .`, `chmod 777`, `curl\|bash`, `wget\|bash`, `eval` |
| Build exclusion | `_config.yml` `exclude:` | Keeps CLAUDE.md, docs/decisions|runbooks|reference, architecture/onboarding docs, scripts, tests, tools out of `_site/` |
| Pattern tests | `tests/hooks/test-secret-patterns.sh` | True/false-positive regression tests for each scan pattern |
| Env template | `.env.example` | Placeholder-only template; real values live in `.env` (gitignored) |

### 3. Key Decisions
- Secret scan runs as PreToolUse on every Bash call (not just commits) so a leak is blocked before any shell command can push it.
- The scan hook is registered without `|| true`: a hook that cannot fail cannot block. This deliberately corrects a known project-init template defect.
- `git add -A` / `git add .` are denied at the permission level: on a public blog, blanket staging is the most likely leak vector for stray local files.
- Internal docs share the public `docs/` tree but rely on the `_config.yml` exclude list; the release/deploy flows verify `_site/` contains none of them.

### 4. Exposure Rules (public-content scope)
What may and may not appear in published reports and workshop docs:

- **AWS account IDs**: always mask (e.g. `1234-XXXX-XXXX` or `<ACCOUNT_ID>`).
- **Access keys / tokens / passwords**: never publish, not even expired ones. Use `<YOUR_KEY>` placeholders.
- **Internal endpoints/hostnames/IPs**: replace with example values (`example.internal`, `10.0.0.0/16` sample ranges are fine as illustrations).
- **Cost/billing figures**: publishable only as the author's own aggregated numbers, never per-account raw exports with identifiers.
- **Screenshots**: crop or blur account IDs, ARNs, and email addresses in console captures.
- Public profile data (whchoi98, GitHub profile) is intentionally public and exempt.

### 5. Code Pointers
- `.claude/hooks/secret-scan.sh` - pattern list and skip rules
- `.claude/settings.json` - hook registration and deny list
- `_config.yml` - `exclude:` block (internal docs)
- `tests/hooks/test-secret-patterns.sh` - pattern regression tests
- `tests/structure/test-site-structure.sh` - exclude-list presence checks

### 6. Cross-references
- Related modules: `docs/CLAUDE.md` (publishing conventions)
- Related ADRs: none yet (record with `docs/decisions/.template.md`)
- Related runbooks: none yet (deploy failure runbook recommended)

<a id="korean"></a>
## 한국어

### 1. 개요
이 사이트는 공개 GitHub Pages 블로그입니다. main에 push되는 모든 것이 인터넷에 게시됩니다.
따라서 보안 레이어는 게시 콘텐츠로의 시크릿/식별자 유출 방지, Claude Code 하네스에서의
위험 작업 차단, 내부 문서의 빌드 산출물 배제에 집중합니다.

### 2. 구성요소
| 구성요소 | 경로 | 목적 |
|---|---|---|
| 시크릿 스캔 훅 | `.claude/hooks/secret-scan.sh` | PreToolUse(Bash) 훅. 스테이징된 파일에서 AWS/GitHub/Anthropic/Slack/Stripe/Google 키, 비밀번호, API 키 할당을 스캔. exit 1로 차단 - 차단이 실제로 동작하도록 `\|\| true` 없이 등록 |
| deny 목록 | `.claude/settings.json` | `rm -rf`, `git push --force`, `git reset --hard`, `git clean -f`, `git add -A`, `git add .`, `chmod 777`, `curl\|bash`, `wget\|bash`, `eval` 차단 |
| 빌드 제외 | `_config.yml` `exclude:` | CLAUDE.md, docs/decisions|runbooks|reference, architecture/onboarding 문서, scripts, tests, tools를 `_site/`에서 배제 |
| 패턴 테스트 | `tests/hooks/test-secret-patterns.sh` | 스캔 패턴별 true/false positive 회귀 테스트 |
| 환경 템플릿 | `.env.example` | 플레이스홀더 전용 템플릿. 실제 값은 `.env`(gitignore 대상)에만 |

### 3. 주요 결정
- 시크릿 스캔은 커밋 시점이 아니라 모든 Bash 호출의 PreToolUse에서 실행됩니다. 셸 명령이 유출을 push하기 전에 차단하기 위함입니다.
- 스캔 훅은 `|| true` 없이 등록합니다. 실패할 수 없는 훅은 차단할 수 없습니다. project-init 템플릿의 알려진 결함을 의도적으로 교정한 것입니다.
- `git add -A` / `git add .`는 권한 수준에서 차단합니다. 공개 블로그에서 일괄 스테이징은 로컬 잔여 파일 유출의 최대 경로입니다.
- 내부 문서는 공개 `docs/` 트리를 공유하되 `_config.yml` exclude에 의존합니다. release/deploy 흐름에서 `_site/`에 내부 문서가 없는지 검증합니다.

### 4. 공개 범위 규칙 (게시 콘텐츠 기준)
게시되는 리포트와 워크샵 문서에 허용/금지되는 것:

- **AWS 계정 ID**: 항상 마스킹 (예: `1234-XXXX-XXXX` 또는 `<ACCOUNT_ID>`)
- **액세스 키 / 토큰 / 비밀번호**: 만료된 것이라도 절대 게시 금지. `<YOUR_KEY>` 플레이스홀더 사용
- **내부 엔드포인트/호스트명/IP**: 예시 값으로 치환 (`example.internal`, 예시용 `10.0.0.0/16` 대역은 허용)
- **비용/청구 수치**: 저자 본인의 집계 수치만 게시 가능. 식별자가 포함된 계정별 원본 내보내기는 금지
- **스크린샷**: 콘솔 캡처의 계정 ID, ARN, 이메일 주소는 크롭 또는 블러 처리
- 공개 프로필 정보(whchoi98, GitHub 프로필)는 의도적 공개 대상으로 예외

### 5. 코드 포인터
- `.claude/hooks/secret-scan.sh` - 패턴 목록과 skip 규칙
- `.claude/settings.json` - 훅 등록과 deny 목록
- `_config.yml` - `exclude:` 블록 (내부 문서)
- `tests/hooks/test-secret-patterns.sh` - 패턴 회귀 테스트
- `tests/structure/test-site-structure.sh` - exclude 목록 존재 검증

### 6. 상호 참조
- 관련 모듈: `docs/CLAUDE.md` (게시 규약)
- 관련 ADR: 아직 없음 (`docs/decisions/.template.md`로 기록)
- 관련 런북: 아직 없음 (배포 실패 런북 권장)
