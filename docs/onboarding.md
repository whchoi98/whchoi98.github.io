# Developer Onboarding

## Quick Start

### 1. Prerequisites
- [ ] Ruby 3.2+ 설치 (로컬 gem 경로: `~/.local/share/gem/ruby/3.2.0/bin`)
- [ ] bundler 설치 (`gem install bundler --user-install`)
- [ ] git, python3 (techblogs QA용)
- [ ] 저장소 접근 권한 (github.com/whchoi98/whchoi98.github.io)

### 2. Setup

```bash
# 저장소 클론
git clone https://github.com/whchoi98/whchoi98.github.io.git
cd whchoi98.github.io

# 원커맨드 셋업 (의존성 설치 + .env 생성 + git hooks 설치)
bash scripts/setup.sh
```

### 3. Verify

```bash
# 로컬 빌드가 성공해야 한다
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll build -d _site

# 하네스 테스트 전체 통과
bash tests/run-all.sh

# 로컬 미리보기 (http://127.0.0.1:4000)
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll serve
```

## Project Overview
- `CLAUDE.md` - 프로젝트 컨텍스트, 규약, 핵심 명령
- `docs/architecture.md` - 시스템 설계 (레이어, 다이어그램, 설계 결정)
- `docs/decisions/` - ADR (아키텍처 결정 기록)
- `docs/CLAUDE.md` - 콘텐츠 구조와 게시 규약

## Development Workflow

### 게시물 작성 → 검증 → 게시 흐름

1. **작성**: techblogs 형식으로 `docs/techblog/<카테고리>/<slug>-report.html` 작성 (자립형 HTML, KO/EN 이중 페이지)
2. **다이어그램**: archify로 `<slug>-archmap.html` 생성, PNG를 리포트에 인라인 삽입
3. **front matter**: `<slug>.md` 생성 (`layout: report`, `report_src`, `title`/`title_en`, `date`, `category`, `tags`, `excerpt`/`excerpt_en`)
4. **QA**: `python3 ~/.claude/skills/techblogs/scripts/qa.py docs/techblog/<카테고리>/<slug>-report.html` - ERROR 0 필수
5. **빌드 검증**: `bundle exec jekyll build` 성공 확인, `_site/`에 내부 문서가 없는지 확인
6. **게시**: 파일을 명시적으로 `git add` (절대 `git add -A` 금지) → Conventional Commits 메시지로 커밋 → `git push origin main` → GitHub Actions가 Pages에 배포

### 규칙 요약
- 커밋 규약: Conventional Commits (feat:, fix:, docs:)
- `git add -A` 금지 - 항상 개별 파일 지정
- main push = 배포. push 전 로컬 빌드 검증 필수

## Key Concepts
- **report 패턴**: 게시물 본문은 md가 아니라 자립형 HTML. md는 front matter 컨테이너
- **iframe 격리**: report 레이아웃이 리포트 HTML을 iframe으로 렌더링 (CSS 충돌 방지)
- **이중 언어**: 사이트 크롬은 `.l-ko`/`.l-en` 스팬 토글, 리포트는 문서 내 KO/EN 페이지 내장
- **exclude 목록**: 내부 문서(CLAUDE.md, docs/decisions 등)는 `_config.yml` exclude로 공개 사이트에서 배제

## Troubleshooting
- **빌드 실패 "Liquid Exception"**: 콘텐츠 내 `{{ }}`/`{% %}` 원문 사용 확인 - `{% raw %}` 필요
- **front matter 날짜 오류**: 날짜는 문자열로 인용 (`date: 2026-08-09` 형식 유지, last_modified_date는 인용)
- **bundle 명령을 못 찾음**: PATH에 `~/.local/share/gem/ruby/3.2.0/bin` 추가 여부 확인
- **새 글이 홈에 안 보임**: front matter `date`와 `category`(blog_categories의 name과 일치) 확인

## Resources
- Jekyll 문서: https://jekyllrb.com/docs/
- Keep a Changelog: https://keepachangelog.com/
- techblogs 스킬: `~/.claude/skills/techblogs/`
