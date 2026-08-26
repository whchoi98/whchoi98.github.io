# Layouts Module

## Role

Jekyll Liquid 레이아웃. 모든 페이지의 HTML 골격과 사이트 크롬(테마/언어 토글, 네비게이션)을 담당한다.
`_config.yml`의 defaults가 경로별 기본 레이아웃을 지정한다 (docs/techblog → post, docs/workshop → doc).

## Key Files

| 파일 | 역할 |
|------|------|
| `default.html` | 최상위 골격. head(SEO, 폰트, 첫 페인트 전 테마/언어 확정 스크립트), footer, main.js 로드. 다른 모든 레이아웃의 부모 |
| `home.html` | 홈. 히어로, 카테고리 카드 그리드, 검색 입력, 최신 글 목록 |
| `post.html` | 마크다운 본문 게시물. 목차, 이전/다음 글 네비게이션 |
| `report.html` | **게시물 표준 레이아웃.** front matter의 `report_src` 자립형 HTML을 iframe으로 격리 렌더링. 브레드크럼, 인쇄 버튼, 문서만 보기 링크, 이전/다음 글 |
| `tags.html` | 태그 필터 페이지 (`?tag=` 쿼리 지원) |
| `listing.html` | 카테고리 인덱스 (docs/techblog/<카테고리>/index.md가 사용) |
| `about.html` | 소개 페이지 |
| `doc.html` | 워크샵 문서. 사이드바 네비게이션 |

## Rules

- 레이아웃 텍스트는 `.l-ko`/`.l-en` 스팬 쌍으로 이중 언어를 제공한다 (html.lang-en 클래스로 전환)
- report.html의 iframe 격리를 깨지 말 것 - 리포트 HTML을 인라인 삽입하면 사이트 CSS와 충돌한다
- 스타일은 `assets/css/main.css`에만 추가. 레이아웃 내 인라인 `<style>` 금지 (default.html의 첫 페인트 스크립트는 예외적 허용)
- 게시물 순서는 `date` 내림차순 정렬 (`site.pages` 기반 - 이 사이트는 `_posts/` 컬렉션을 쓰지 않는다)
- 레이아웃 추가/변경 시 이 문서와 `docs/architecture.md`를 갱신한다

## 조회수 (GoatCounter)

- `default.html`이 `site.goatcounter` 설정 시 추적 스크립트(gc.zgo.at/count.js)를 로드한다 (localhost 자동 제외)
- `report.html`(브레드크럼)과 `post.html`(메타 라인)에 `[data-views]` 요소가 있고, `assets/js/main.js`가 public counter JSON을 조회해 채운다. 계정 미생성/비공개/실패 시 hidden 유지
