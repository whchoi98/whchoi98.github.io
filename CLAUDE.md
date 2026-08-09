# Project Context

## Overview

whchoi98.github.io - AWS Solutions Architect의 기술 블로그 겸 워크샵 포털.
Jekyll 4.3 커스텀 테마 정적 사이트로, GitHub Actions를 통해 GitHub Pages에 배포된다.
기술 분석 게시물(techblogs 형식 자립형 HTML)과 핸즈온 워크샵 문서(50여 개)를 제공한다.

## Tech Stack

- **Jekyll 4.3** (Ruby 3.2+, bundler) - 정적 사이트 생성기, kramdown(GFM) + rouge
- **Liquid** - 레이아웃/인클루드 템플릿 (`_layouts/`, `_includes/`)
- **Vanilla JS / CSS** - 빌드 도구 없음. `assets/js/main.js`(테마/언어 토글, 검색, 태그 필터), `assets/css/main.css`(CSS 변수 기반 다크/라이트 테마)
- **Plugins** - jekyll-seo-tag, jekyll-sitemap, jekyll-feed
- **CI/CD** - GitHub Actions `.github/workflows/pages-deploy.yml` → GitHub Pages

## Project Structure

```
_config.yml       - 사이트 설정, blog_categories 메타, exclude 목록(내부 문서 제외)
_layouts/         - 레이아웃 8종: default, home, post, report, tags, listing, about, doc
_includes/        - topbar.html (상단 네비게이션 + 테마/언어 토글)
assets/
  css/main.css    - 전체 스타일 (CSS 변수 테마)
  js/main.js      - 테마/언어 토글, 홈 검색, 태그 필터, 목차
  icons/          - 카테고리 SVG 아이콘 (bedrock, eks, lambda 등)
docs/
  techblog/<카테고리>/  - 게시물 md + 자립형 리포트 HTML + archmap HTML/PNG
  workshop/       - 워크샵 문서 (50여 개, doc 레이아웃)
docs/decisions/   - ADR (빌드 제외)
docs/runbooks/    - 운영 런북 (빌드 제외)
docs/reference/   - 구현 레퍼런스 문서 (빌드 제외)
index.md          - 홈 (home 레이아웃)
tags.md, about.md - 태그 필터 / 소개 페이지
.claude/          - settings.json, hooks/, skills/, commands/, agents/
scripts/          - setup.sh, install-hooks.sh (빌드 제외)
tests/            - 구조/훅 테스트 (빌드 제외)
tools/prompts/    - 프롬프트 자산 (빌드 제외)
ccw-hands-on-lab/ - Claude Code Workshop 핸즈온 랩 (자립형 HTML 아카이브)
```

## Conventions

### 게시물 (report 패턴)
- 새 게시물 = `docs/techblog/<카테고리>/<slug>.md` (front matter만) + `<slug>-report.html` (자립형 techblogs HTML)
- md front matter: `layout: report`, `report_src: /docs/techblog/.../<slug>-report.html`, `title`/`title_en`, `date`, `category`, `tags`, `icon`, `minutes`, `excerpt`/`excerpt_en`
- report 레이아웃은 자립형 HTML을 iframe으로 격리 렌더링한다 (사이트 CSS와 문서 CSS 충돌 방지)
- 리포트 HTML은 KO/EN 이중 페이지를 내장하고 `<link rel="canonical">`로 게시물 URL을 가리킨다
- 아키텍처 다이어그램은 archify로 생성한 `<slug>-archmap.html` + `<slug>-archmap.png`을 같은 디렉토리에 둔다

### 이중 언어 (KO/EN)
- 사이트 크롬은 `.l-ko`/`.l-en` 스팬 + `html.lang-en` 클래스 토글로 전환 (`assets/js/main.js`)
- 리포트 HTML은 문서 내부에 KO/EN 페이지를 모두 내장한다
- 한/영 정보 동등성 유지: 제목, 발췌, 본문 모두 양 언어 제공

### 가독성 헌장 (요지)
- 한 문단 하나의 주장. 짧은 문장. 사실 보존 우선, 수사 최소화
- 수치는 표/비교 블록으로. 근거 없는 단정 금지 (n=1 주장은 헤지)
- 본문은 경어체(~합니다), 코드/명령/고유명사는 원문 유지

### 코드블록
- 리포트 HTML 내 코드블록은 mac 터미널 스타일(신호등 버튼 + 복사 버튼)을 사용한다

### Git
- **`git add -A` 금지** - 항상 파일을 명시적으로 지정해 스테이징한다
- 커밋 메시지는 Conventional Commits (feat:, fix:, docs:)
- main 브랜치 push가 곧 배포다 (GitHub Actions → Pages). push 전 로컬 빌드 검증 필수

## Key Commands

```bash
# 로컬 빌드 (검증)
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll build -d _site

# 로컬 서버 (미리보기)
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll serve

# techblogs QA (리포트 HTML 구조/스타일 검증, ERROR 시 exit 1)
python3 ~/.claude/skills/techblogs/scripts/qa.py docs/techblog/<카테고리>/<slug>-report.html

# 하네스 테스트
bash tests/run-all.sh

# 배포 = main push (GitHub Actions가 빌드/배포)
git push origin main
```

---

## Auto-Sync Rules

Rules below are applied automatically after Plan mode exit and on major code changes.

### Post-Plan Mode Actions
After exiting Plan mode (`/plan`), before starting implementation:

1. **Architecture decision made** -> Update `docs/architecture.md`
2. **Technical choice/trade-off made** -> Create `docs/decisions/ADR-NNN-title.md`
3. **New module added** -> Create `CLAUDE.md` in that module directory
4. **Operational procedure defined** -> Create runbook in `docs/runbooks/`
5. **Changes needed in this file** -> Update relevant sections above

### Code Change Sync Rules
- New category under `docs/techblog/` -> Update `_config.yml` blog_categories and `docs/CLAUDE.md`
- Layout added/changed in `_layouts/` -> Update `_layouts/CLAUDE.md`
- CSS/JS/icon convention changed -> Update `assets/CLAUDE.md`
- Publishing convention changed -> Update `docs/CLAUDE.md` and this file's Conventions
- Build/deploy pipeline changed -> Update `docs/architecture.md` Build & Deploy section

### ADR Numbering
Find the highest number in `docs/decisions/ADR-*.md` and increment by 1.
Format: `ADR-NNN-concise-title.md`

## Implementation References

<!-- AUTO-MANAGED:references -->
- [Security / 보안 구현 상세](docs/reference/security.md) - 시크릿 스캔, 공개 범위 규칙, deny 목록
<!-- /AUTO-MANAGED:references -->
