# Changelog

<a href="#english"><img src="https://img.shields.io/badge/lang-English-blue.svg" alt="English"></a>
<a href="#korean"><img src="https://img.shields.io/badge/lang-한국어-red.svg" alt="Korean"></a>

---

<a id="english"></a>

# English

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
No version tags exist yet; all changes accumulate under Unreleased.

## [Unreleased]

### Added
- Add initial Jekyll blog with GitHub Actions workflow deploying to GitHub Pages
- Add tech blog category system, grown to 8 categories (AIML, AWS Core, Cloud Security, Container, Observability, Networking, Database, Data Analytics) with icon/description metadata in `_config.yml`
- Add Kiro CLI Workshop (48 pages) under the Workshop section
- Add Claude Code Deep Dive Workshop hands-on labs (`ccw-hands-on-lab`) with session intro (eDM), capstone labs including Trend Radar, and dark/light theme toggle on lab pages
- Add report pattern: posts rendered as self-contained techblogs-format HTML documents through an iframe-isolating `report` layout
- Add KO/EN language toggle chrome and bilingual posts (Korean/English pages embedded in each report)
- Add archify interactive architecture maps plus inline archmap figures for all posts
- Add Mac terminal style code blocks with copy buttons in report documents
- Add posts: MCP Tool Forge deep-dive, Claude Code advisor cost analysis, Gemma-4-31B vLLM serving benchmark, conntrack idle timeout Nitro v6 impact, project-init and harness-eval plugin deep-dives, model monitoring, seven project deep-dive posts, and the Claude Sonnet 5 Hangul output integrity investigation (1,200-run controlled experiment)

### Changed
- Replace the theme entirely with a custom Jekyll theme (navy/orange card UI, dark mode, tag filter, workshop sidebar) after iterating through Chirpy, TeXt, and Just the Docs
- Unify all existing posts into techblogs-format report documents
- Rewrite all 15 posts for readability with facts preserved
- Update hero copy (build/break/measure/write) and bilingual About bio
- Restructure Workshop navigation to a flat 3-level layout and rename the lab path to `ccw-hands-on-lab`

### Removed
- Remove three posts (security-hub, otel-eks, bedrock-rag)

### Fixed
- Fix advisor cost analysis overhead ratio narrative (59% to 28% cross-denominator error) and hedge n=1 claims
- Fix light theme regressions by converting hardcoded colors to theme variables, including the eDM hero banner palette
- Fix build failure caused by Gitbook Liquid tags in imported content
- Fix front matter `last_modified_date` values by quoting dates as strings

[Unreleased]: https://github.com/whchoi98/whchoi98.github.io/commits/main

---

<a id="korean"></a>

# 한국어

이 프로젝트의 모든 주요 변경 사항은 이 파일에 기록됩니다.
이 문서는 [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)를 기반으로 하며,
[Semantic Versioning](https://semver.org/spec/v2.0.0.html)을 따릅니다.
아직 버전 태그가 없으므로 모든 변경은 Unreleased 아래에 누적됩니다.

## [Unreleased]

### Added
- GitHub Actions로 GitHub Pages에 배포되는 초기 Jekyll 블로그 추가
- 테크블로그 카테고리 시스템 추가, 8개 카테고리로 확장 (AIML, AWS Core, Cloud Security, Container, Observability, Networking, Database, Data Analytics) - `_config.yml`에 아이콘/설명 메타데이터 포함
- Workshop 섹션에 Kiro CLI Workshop(48페이지) 추가
- Claude Code Deep Dive Workshop 핸즈온 랩(`ccw-hands-on-lab`) 추가 - 세션 인트로(eDM), Trend Radar 포함 캡스톤 랩, 랩 페이지 다크/라이트 테마 토글
- report 패턴 추가: 게시물을 iframe 격리 `report` 레이아웃을 통해 자립형 techblogs 형식 HTML 문서로 렌더링
- KO/EN 언어 토글 크롬 및 이중 언어 게시물 추가 (각 리포트에 한/영 페이지 내장)
- 전체 게시물에 archify 인터랙티브 아키텍처 맵과 인라인 archmap figure 추가
- 리포트 문서에 복사 버튼이 있는 Mac 터미널 스타일 코드블록 추가
- 게시물 추가: MCP Tool Forge 심층 분석, Claude Code advisor 비용 분석, Gemma-4-31B vLLM 서빙 벤치마크, conntrack 유휴 타임아웃 Nitro v6 영향 분석, project-init 및 harness-eval 플러그인 심층 분석, 모델 모니터링, 프로젝트 심층 분석 7편, Claude Sonnet 5 한글 출력 무결성 조사(1,200런 통제 실험)

### Changed
- Chirpy, TeXt, Just the Docs를 거쳐 커스텀 Jekyll 테마로 전면 교체 (네이비/오렌지 카드 UI, 다크 모드, 태그 필터, 워크샵 사이드바)
- 기존 게시물 전체를 techblogs 형식 리포트 문서로 통일
- 사실 보존을 전제로 게시물 15편 전체 가독성 재작성
- 히어로 카피(만들고/부수고/측정하고/기록합니다)와 이중 언어 About 소개 갱신
- Workshop 네비게이션을 평면 3레벨 구조로 재편, 랩 경로를 `ccw-hands-on-lab`으로 변경

### Removed
- 게시물 3편 제거 (security-hub, otel-eks, bedrock-rag)

### Fixed
- advisor 비용 분석의 오버헤드 비율 서사 수정 (59%→28%, 분모 교차 오류) 및 n=1 주장 헤지 처리
- 하드코딩 색상을 테마 변수로 전환해 라이트 테마 회귀 수정 (eDM 히어로 배너 팔레트 포함)
- 임포트 콘텐츠의 Gitbook Liquid 태그로 인한 빌드 실패 수정
- front matter `last_modified_date` 날짜를 문자열로 인용해 파싱 오류 수정

[Unreleased]: https://github.com/whchoi98/whchoi98.github.io/commits/main
