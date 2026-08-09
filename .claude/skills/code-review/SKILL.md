# Code Review Skill

Review changed code with confidence-based scoring to filter false positives.
Adapted for this Jekyll blog: review targets are Liquid layouts, vanilla CSS/JS,
front matter, and self-contained report HTML.

## Review Scope

By default, review unstaged changes from `git diff`. The user may specify different files or scope.

## Review Criteria

### Project Guidelines Compliance (CLAUDE.md)
- report 패턴 준수: 게시물 md는 `layout: report` + `report_src`, 본문은 자립형 HTML
- KO/EN 이중 언어 동등성: `title`/`title_en`, `excerpt`/`excerpt_en`, `.l-ko`/`.l-en` 쌍
- 코드블록은 mac 터미널 스타일(리포트 HTML 내부)
- 색상은 CSS 변수 사용 (하드코딩 색상은 라이트/다크 한쪽을 깨뜨림)
- `git add -A` 사용 흔적이 있으면 지적
- 내부 문서가 공개 경로로 새지 않는지 (_config.yml exclude 확인)

### Bug Detection
- Liquid 문법 오류, 존재하지 않는 변수/필터 참조
- front matter 오류 (category가 blog_categories에 없음, report_src 경로 오탈자, 날짜 미인용)
- JS 로직 오류, null/undefined 처리, localStorage 예외 처리 누락
- 깨진 내부 링크, iframe src 오류
- XSS (리포트 HTML의 unescaped 출력)

### Code Quality
- CSS/JS 중복, 불필요한 복잡도
- 접근성 (skip link, aria, noscript 폴백)
- techblogs QA 통과 여부 (`python3 ~/.claude/skills/techblogs/scripts/qa.py <report.html>`)

## Confidence Scoring

Rate each issue 0-100:
- **0-24**: Likely false positive or pre-existing issue. Do not report.
- **25-49**: Might be real but possibly a nitpick. Do not report.
- **50-74**: Real issue but minor. Report only if critical.
- **75-89**: Verified real issue, important. Report with fix suggestion.
- **90-100**: Confirmed critical issue. Must report.

**Only report issues with confidence >= 75.**

## Output Format

For each issue:
### [CRITICAL|IMPORTANT] <issue title> (confidence: XX)
**File:** `path/to/file.ext:line`
**Issue:** Clear description of the problem
**Guideline:** Reference to CLAUDE.md rule or security standard
**Fix:** Concrete code suggestion

If no high-confidence issues found, confirm code meets standards with brief summary.
