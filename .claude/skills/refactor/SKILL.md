# Refactor Skill

Refactor existing code to improve quality without changing behavior.
For this Jekyll blog, "behavior" means the rendered site: same HTML output,
same theme/language toggle behavior, same URLs.

## Principles
- Improve structure without changing behavior
- Single Responsibility Principle (SRP) - 레이아웃 하나는 하나의 페이지 유형만 담당
- Remove duplicate code (DRY) - 반복되는 Liquid 조각은 `_includes/`로 추출
- Small, incremental steps with verification

## Process

### 1. Analysis
- Identify the target (layout, include, CSS block, JS function) and its consumers
- Map which pages use the layout (`_config.yml` defaults, front matter `layout:`)
- Confirm a verification baseline: build the site before refactoring

```bash
PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH" bundle exec jekyll build -d _site
```

### 2. Plan
Present the refactoring plan to the user:
- What will change
- What will NOT change (rendered output, URLs, toggle behavior)
- Risk assessment (low/medium/high)

### 3. Execute
- Make changes in small, verifiable steps
- Rebuild after each step and compare rendered output where practical
- Keep commits atomic; stage files explicitly (never `git add -A`)

### 4. Verify
- `bundle exec jekyll build` succeeds with no new warnings
- Spot-check affected pages in `_site/` (or `jekyll serve`)
- Theme (dark/light) and language (KO/EN) toggles still work
- `bash tests/run-all.sh` passes
- Report HTML untouched by chrome refactors (iframe isolation preserved)
