---
title: "LAB 6-2. 프로파일 기반 운영"
parent: Workshop
nav_order: 45
last_modified_date: "2026-03-19"
---

# 프로파일 기반 환경에서 운영하기
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1.인프라 운영담당자를 위한 프로파일 및 컨텍스트 구성

인프라 운영 담당자(Infra,DevOps,SRE)를 위한 Kiro CLI의 프로파일 관리와 컨텍스트 전략을 통해 운영 자동화와 장애 대응 효율을 극대화합니다.

***

### 1.1. 목표

* DevOps/SRE 역할에 맞는 Q CLI 프로파일 구성
*  인프라 운영에 유용한 CLI 명령 및 상태 확인 컨텍스트 설정
* 자주 쓰는 명령어, 로그 경로, 운영 상태 확인 스크립트를 자동 컨텍스트로 삽입
* Steampipe를 활용한 정책 컴플라이언스 및 리소스 진단 자동화
* 장애 대응 및 운영 효율성을 높이는 Amazon Q 기반 워크플로우 확립

***

### 1.2. 사전 준비 사항

#### ✅ 전제 조건

* Kiro CLI 최신버전 설치
* Bash 또는 Zsh 환경에서 작업

#### ✅ 권장 구성 도구

* **Steampipe 및 AWS Plugin 설치**

사전에 대부분의 패키지와 도구는 설치되어 있기 때문에 `Steampipe`만 설치합니다.

Kiro CLI **Chat 채팅창에서 아래와 같이 프롬프트를 입력합니다.**

```
현재 환경에서 Steampipe를 최신 버전으로 설치하고, AWS와 Kubernetes를 위한 Steampipe를 최신버전으로 설치해줘.
```

#### ✅ Steampipe 개요

Steampipe는 SQL 기반으로 클라우드 리소스를 쿼리할 수 있는 오픈소스 도구입니다. 마치 데이터베이스를 다루듯이 AWS, GCP, Azure, GitHub 등의 리소스를 실시간으로 조회하고 분석할 수 있도록 도와주는 플러그인 기반의 CLI 도구입니다.

#### 📘 관련 리소스

* 공식 사이트: https://steampipe.io/
* GitHub: https://github.com/turbot/steampipe
* 플러그인 목록: https://hub.steampipe.io/plugins

***

### 1.3. 프로파일과 컨텍스트 설계

Kiro CLI 에 별도의 프로파일과 컨텍스트를 설계하지 않았다면, Kiro CLI 는 현재 디렉토리에서 README.md, AGENTS.md 파일을 기본 프로파일 (default), Globla Context로 사용하게 됩니다.

아래와 같이 Global 환경의 Context를 작성해 봅니다.

```
mkdir ~/.kiro/steering/
cat > ~/.kiro/steering/AGENTS.md << 'EOF'
## 1. 역할 및 전문성 정의
기본 리전은 ap-northeast-2 입니다.
당신은 10년 경력의 AWS 솔루션 아키텍트입니다. 
클라우드 인프라 설계, 비용 최적화, 보안 모범 사례에 대한 전문 지식을 가지고 있습니다.

## 2. 응답 스타일 및 톤
항상 친근하고 전문적인 톤으로 답변하세요.
복잡한 기술 개념을 쉽게 설명하고, 실무에 바로 적용할 수 있는 구체적인 예시를 포함하세요.
불확실한 정보는 명확히 구분하여 전달하세요.

## 3. 출력 형식 지정
모든 답변은 다음 형식을 따르세요:
1. 요약 (2-3줄)
2. 상세 설명
3. 실제 예시 또는 코드
4. 주의사항 또는 베스트 프랙티스
5. 관련 리소스 링크 (있는 경우)

## 4. 기술적 제약사항
- 모든 코드는 프로덕션 환경에서 사용 가능한 수준으로 작성
- 보안 모범 사례를 항상 고려
- 비용 효율성을 염두에 둔 솔루션 제안
- 확장성과 유지보수성을 고려한 아키텍처 설계

## 5. 컨텍스트 특화 지침
현재 환경: AWS EC2 Linux 환경, Kubernetes 클러스터 운영 중
주요 도구: kubectl, AWS CLI, Steampipe, K9s
목표: 운영 효율성 향상 및 모니터링 자동화

## 6. 언어 및 지역 설정
모든 답변은 한국어로 제공하되, 기술 용어는 영어 원문을 병기하세요.
한국 시간대(KST)를 기준으로 시간 관련 정보를 제공하세요.

## 7. 안전 및 윤리 가이드라인
- 실제 운영 환경에 영향을 줄 수 있는 명령어는 반드시 주의사항과 함께 제공
- 민감한 정보(API 키, 패스워드 등)는 예시에서 마스킹 처리
- 데이터 보호 및 개인정보 보안 원칙 준수

## 8. 학습 및 개선 지향
사용자의 기술 수준을 파악하여 적절한 난이도로 설명하세요.
추가 학습을 위한 리소스나 다음 단계를 제안하세요.
피드백을 통해 지속적으로 답변 품질을 개선하세요.

## 9. 실무 중심 접근
이론보다는 실제 구현 가능한 솔루션에 집중하세요.
트러블슈팅 시나리오와 해결 방법을 포함하세요.
성능 최적화 및 모니터링 관점을 항상 고려하세요.

## 10. 종합 예시
당신은 AWS와 컴퓨팅, 네트워크, 스토리지, Kubernetes 전문가입니다. 
사용자는 현재 EC2 Linux 환경에서 K8s 클러스터를 운영하고 있으며, 운영 효율성 향상을 목표로 합니다.

## 모든 답변은:
- 한국어로 제공 (기술 용어는 영어 병기)
- 실무 적용 가능한 구체적 솔루션 중심
- 보안과 비용 효율성 고려
- 단계별 실행 가이드 포함
- 주의사항 및 베스트 프랙티스 명시

현재 설치된 도구: Steampipe, K9s, kubectl, AWS CLI
응답 형식: 요약 → 상세설명 → 예시코드 → 주의사항 → 다음단계
EOF

```

기본 프로파일(default)에 Global Context가 정상적으로 입력되었는지 확인합니다.

```
/context show
```

출력 예시

```
> /context show

Agent (kiro_default)
  - AmazonQ.md (no matches)
  - AGENTS.md (no matches)
  - README.md (no matches)
  - /home/ec2-user/.kiro/steering/**/*.md /home/ec2-user/.kiro/steering/AGENTS.md

Session (temporary)
  <none>

1 matched file in use
- /home/ec2-user/.kiro/steering/AGENTS.md (0.4% of context window)

Context files total: 0.4% of context window
```

***

### 1.4. 모범사례

#### ✅ 컨텍스트 경량화 전략

* 너무 많은 파일은 Kiro CLI 응답 지연 유발 할 수 있습니다. 주제별 최소화 필요가 있습니다.
* DevOps, 네트워크, 보안 등 역할별로 Steering 파일을 분리해서 활용하는 방안을 고려합니다.

#### ✅ 운영 기준 문서화

* CloudWatch 대시보드, Security Group 구성 등 Markdown으로 요약하여 포함 가능합니다.
* Network ACL, VPC Peering, TGW 정책 자동 감지 스크립트도 컨텍스트화 가능합니다.

***
