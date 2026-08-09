# Implementation References Index

구현 레퍼런스 문서 목록. 각 문서는 레이어 하나의 구현 상세(구성요소, 결정, 코드 포인터)를 담는다.
새 레이어 문서는 `/project-init:add-reference-doc`으로 추가하고, 루트 `CLAUDE.md`의
`<!-- AUTO-MANAGED:references -->` 블록에 링크를 등록한다.

| Layer | Document | Scope |
|-------|----------|-------|
| Security | [security.md](security.md) | 시크릿 스캔 훅, 공개 범위 규칙(계정 마스킹), deny 목록, 빌드 제외 |

Candidate layers not yet documented / 아직 문서화되지 않은 후보 레이어:

- `ui` - 사이트 크롬 (레이아웃/CSS/JS 토글 메커니즘) - 현재는 `_layouts/CLAUDE.md`, `assets/CLAUDE.md`가 대신한다
- `infrastructure` - GitHub Actions/Pages 파이프라인 - 현재는 `docs/architecture.md` Build & Deploy 절이 대신한다
