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
    <slug>-report.html      - techblogs 리포트 (한국어와 영어를 한 파일에)
    <slug>-assets/          - 리포트가 가리키는 그림
    <slug>-archmap.html/png - 구 형식 게시물의 archify 아키텍처 맵 (2026-11-15 이전)
docs/workshop/              - 워크샵 문서 50여 개 (layout: doc, 사이드바 네비)
```

## 게시 규약 (report 패턴)

1. **작성**: `my-plugins:techblogs` 스킬로 작업 폴더(`meta.json`, `ko.body.html`, `en.body.html`, `images/`)를 만들고 `build_post.py`로 `<slug>-report.html`, `<slug>.md`, `<slug>-assets/`를 빌드한다. 리포트 HTML을 직접 고치지 않는다
2. **front matter**: `<slug>.md` 생성 - `layout: report`, `report_src`, `title`/`title_en`, `date`, `category`(_config.yml blog_categories의 name과 일치), `tags`, `icon`, `minutes`, `excerpt`/`excerpt_en`
3. **그림**: 작업 폴더의 `images/`에 두면 빌드가 `<slug>-assets/`로 옮긴다. 리포트는 상대 경로로 가리킨다
4. **검사**: 스킬의 `check_post.py <slug>-report.html --blog .` - ERROR 0이어야 게시 가능. 배치는 `place_post.py`가 한다
5. **canonical**: 리포트 HTML의 `<link rel="canonical">`은 게시물 pretty URL(`/docs/techblog/<카테고리>/<slug>/`)을 가리킨다. 다른 곳에 먼저 게시한 글을 옮겨 실으면 원문 URL을 가리키고 머리와 끝에 원문 링크를 둔다
6. **빌드 검증** 후 명시적 `git add`(개별 파일) → 커밋 → main push

## Rules

- 게시물 본문을 md로 쓰지 않는다 - md는 front matter 컨테이너, 본문은 리포트 HTML이 담당
- 카테고리 신설 시: 디렉토리 + index.md 생성, `_config.yml` blog_categories 등록, 아이콘 확인
- 워크샵 문서는 `layout: doc` 기본값이 적용된다 (front matter에서 생략 가능)
- 내부 문서(decisions/runbooks/reference)를 공개 경로(docs/techblog, docs/workshop)에 두지 않는다
- 계정 ID, 내부 URL, 시크릿은 게시 전 마스킹한다 (docs/reference/security.md 참조)
