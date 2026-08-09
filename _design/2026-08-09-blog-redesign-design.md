# whchoi98.github.io 전면 교체 설계 (2026-08-09)

승인된 결정: Jekyll 커스텀 테마 / Workshop 새 디자인 통합 / About 초안 후 수정 / Pretendard만 사용 (Amazon Ember 제외).
디자인 원본: `Tech blog design options.zip`의 Home/Post/Tags/About `.dc.html` 목업.

## 아키텍처

- `remote_theme: just-the-docs` 제거, 자체 레이아웃 6종: `default`(셸), `home`, `post`, `tags`, `about`, `doc`(Workshop), `listing`(카테고리 인덱스).
- 스타일: `assets/css/main.css` 단일 파일. 목업의 `--t-*` CSS 변수 체계 유지 (라이트 `#fafafa` / 다크 `#0F1B2D`, 액센트 `#FF9900`).
- 다크 모드: `<html>`에 `dark` 클래스, `localStorage('whchoi98-blog-theme')`, first-paint 전 부트 스크립트.
- JS: `assets/js/main.js` - 테마 토글, 홈 검색(빌드 시 인라인된 JSON), 태그 필터(`?tag=`), 글 목차 스크롤 스파이.

## URL 보존

- 기존 경로(`/docs/techblog/...`, `/docs/workshop/...`, `/assets/reports/...`, `/ccw-hands-on-lab/...`) 전부 유지.
- `_config.yml` defaults: `docs/techblog` → `post`, `docs/workshop` → `doc`. 인덱스 페이지는 frontmatter로 `listing` 명시.

## 콘텐츠 모델

- 블로그 글 frontmatter: `title, date, category, tags, excerpt, icon, minutes`. 식별 기준 `layout == post`.
- Workshop은 기존 `parent`/`nav_order` frontmatter로 사이드바 트리 구성 (파일 수정 없음).
- JTD 문법 잔존물(`{: .btn}`, `{: .warning}` 등)은 CSS로 수용, 본문 일괄 수정하지 않음.
- 카테고리 아이콘 매핑: AIML→bedrock, AWS Core→lambda, Cloud Security→vpc, Container→eks, Observability→cloudwatch, Workshop→step-functions.

## 검증

- 로컬 `bundle exec jekyll build` + 헤드리스 Chromium 스크린샷 (홈/글/태그/Workshop, 라이트/다크) 확인 후 push.
- 롤백: `git revert` 단일 커밋.
