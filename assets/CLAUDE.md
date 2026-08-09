# Assets Module

## Role

사이트 크롬의 스타일, 동작, 아이콘. 빌드 도구 없이 vanilla CSS/JS 단일 파일로 유지한다.

## Key Files

| 경로 | 역할 |
|------|------|
| `css/main.css` | 전체 스타일 단일 파일. `:root` CSS 변수 + `html.dark` 오버라이드로 다크/라이트 테마 구현 |
| `js/main.js` | 테마 토글(`data-theme-pick`), 언어 토글(`data-lang-pick`, `html.lang-en`), 홈 검색, 태그 필터, 글 목차. localStorage 키: `whchoi98-blog-theme`, `whchoi98-blog-lang` |
| `icons/*.svg` | 카테고리 아이콘 (bedrock, lambda, vpc, eks, cloudwatch, database, analytics, step-functions, s3, ecs). `_config.yml` blog_categories의 `icon` 값과 파일명이 일치해야 한다 |
| `reports/` | 사이트 크롬과 무관한 리포트 정적 자산 |

## Rules

- 색상은 반드시 CSS 변수로 정의한다. 하드코딩 색상은 라이트/다크 테마 중 한쪽을 깨뜨린다 (커밋 178b028의 교훈)
- JS는 IIFE + `"use strict"`, 프레임워크/외부 라이브러리 도입 금지
- 언어 전환은 `langchange` CustomEvent를 발행한다 - 언어 의존 컴포넌트는 이 이벤트를 구독할 것
- 새 카테고리 추가 시: `icons/`에 SVG 추가 + `_config.yml` blog_categories에 등록 (파일명 = icon 값)
- 리포트 HTML 내부 스타일은 이 모듈 소관이 아니다 (자립형 문서는 자체 CSS를 내장, techblogs 스킬 규약을 따름)
