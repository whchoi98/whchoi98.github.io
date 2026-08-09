# Docs (Content) Module

## Role

사이트의 모든 콘텐츠. `docs/techblog/`(게시물)과 `docs/workshop/`(워크샵 문서)은 공개 콘텐츠,
`docs/decisions|runbooks|reference/`와 `architecture.md`, `onboarding.md`는 내부 문서로 **Jekyll 빌드에서 제외**된다 (_config.yml exclude).

## Content Structure

```
docs/techblog/
  index.md                  - 테크블로그 전체 인덱스 (listing)
  <카테고리>/                - aiml, aws-core, cloud-security, container,
    index.md                  observability, networking, database, data-analytics
    <slug>.md               - 게시물 front matter (layout: report)
    <slug>-report.html      - 자립형 techblogs HTML (KO/EN 이중 페이지 내장)
    <slug>-archmap.html     - archify 인터랙티브 아키텍처 맵
    <slug>-archmap.png      - 리포트에 인라인 삽입되는 아키텍처 이미지
docs/workshop/              - 워크샵 문서 50여 개 (layout: doc, 사이드바 네비)
```

## 게시 규약 (report 패턴)

1. **작성**: techblogs 스킬 형식으로 `<slug>-report.html` 작성 (자립형, KO/EN 이중 페이지, mac 터미널 코드블록, 다크/라이트 토글 내장)
2. **front matter**: `<slug>.md` 생성 - `layout: report`, `report_src`, `title`/`title_en`, `date`, `category`(_config.yml blog_categories의 name과 일치), `tags`, `icon`, `minutes`, `excerpt`/`excerpt_en`
3. **다이어그램**: archify로 `<slug>-archmap.html` 생성, PNG 내보내기 후 리포트에 인라인 figure로 삽입
4. **QA**: `python3 ~/.claude/skills/techblogs/scripts/qa.py <slug>-report.html` - ERROR 0이어야 게시 가능
5. **canonical**: 리포트 HTML의 `<link rel="canonical">`은 게시물 pretty URL(`/docs/techblog/<카테고리>/<slug>/`)을 가리킨다
6. **빌드 검증** 후 명시적 `git add`(개별 파일) → 커밋 → main push

## Rules

- 게시물 본문을 md로 쓰지 않는다 - md는 front matter 컨테이너, 본문은 리포트 HTML이 담당
- 카테고리 신설 시: 디렉토리 + index.md 생성, `_config.yml` blog_categories 등록, 아이콘 확인
- 워크샵 문서는 `layout: doc` 기본값이 적용된다 (front matter에서 생략 가능)
- 내부 문서(decisions/runbooks/reference)를 공개 경로(docs/techblog, docs/workshop)에 두지 않는다
- 계정 ID, 내부 URL, 시크릿은 게시 전 마스킹한다 (docs/reference/security.md 참조)
