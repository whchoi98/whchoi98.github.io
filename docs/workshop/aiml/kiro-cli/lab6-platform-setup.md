---
title: "LAB 6-1. 플랫폼 운영 환경 설정"
parent: AIML
grand_parent: Workshop
nav_order: 44
last_modified_date: "2026-03-19"
---

# Kiro CLI 기반 플랫폼 운영 환경 설정
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

{% hint style="warning" %}
Kiro CLI 기반 플랫폼 운영하기 목차를 수행하기 위해서는, AWS 자원이 배포 됩니다. 따라서 비용이 발생할 수 있기 때문에 주의가 필요합니다.
{% endhint %}

## 1. Kiro CLI 실습 환경 구성

Amazon Q CLI의 고급 기능을 실습할 수 있는 클라우드 기반 환경을 자동으로 구성합니다. 네트워크 인프라부터 개발 도구, AI 통합 도구(MCP)까지 포함된 종합적 학습 환경입니다.

***

### 1.1 아키텍처 구성

#### ✅ 실습 인프라 환경

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

Kiro CLI 기반 플랫폼 운영 LAB은 위의 그림과 같은 아키텍쳐로 구성되어 있습니다.

#### ✅ 서비스 구성 요약

* MgmtVPC : IGW, Public Subnet, Private Subnet, 
* **DMZ VPC**: IGW , Public Subnet, Private Subnet , EC2 , NAT Gateway, Amazon Network Firewall(ANFW), Amazon EKS Cluster, Redis, OpenSearch
* **VPC01**: Private Subnet, EC2, Aurora MySQL
* **VPC02**: Private Subnet, EC2
* **선택사항**: Amazon EKS , Redis, OpenSearch, Aurora MySQL

***

### 1.2.  빠른 시작

#### ✅ 저장소 클론 및 이동

```bash
git clone https://github.com/whchoi98/amazonqcli_lab.git
cd amazonqcli_lab/LabSetup
```

#### ✅ 인프라 자동 배포

3개의 VPC를 아래와 같은 Shell Script로 배포합니다. 

해당 Shell Script는 3개의 VPC를 구성하는 Claudformation Stack을 동시에 배포합니다. 

(DMZVPC, VPC01, VPC02)

```bash
./0.depoly-all-vpcs.sh     # 병렬 VPC 배포

```

VPC간의 연결 구성을 TGW를 통해서 구성합니다.

해당 Shell Script는 배포된 3개의 VPC를 Transit Gateway로 연결하는 Cloudformation Stack을 배포합니다.

```
./0.deploy-tgw.sh          # Transit Gateway 배포

```

✅ 개발 환경 구성

아래 구성은 실습환경에 필요한 환경변수와 도구들 및 KMS를 설치하는 과정입니다.

```bash
./1.vscode-tools-installer.sh
./2.set-aws-env.sh
./3.kms-setup.sh

```

#### ✅ Kiro CLI 및 MCP 설정

아래 구성은 이 과정에서 필요한 주요 MCP 설치와 환경 구성을 포함하는 Shell Script 입니다.

```bash
./4.install_core_mcp.sh
./5.setup-mcp-config.sh

```

***

### 1.3.  배포 가이드 요약

#### Phase 1: 네트워킹 인프라

**✅ VPC 구성 (0.depoly-all-vpcs.sh)**

* DMZ VPC: Public/NAT 서브넷, IGW, NATGW, ANFW
* VPC01/VPC02: Private 서브넷, 라우팅 테이블
* 병렬 배포, S3 업로드 포함 및 배포 후 S3 삭제

**✅ Transit Gateway 설정 (0.deploy-tgw.sh)**

* TGW 생성 및 VPC 연결
* TGW 라우팅 테이블 설정 - DMZVPC, VPC01, VPC02

#### Phase 2: 개발 환경

**✅ 개발 도구 설치 (1.vscode-tools-installer.sh)**

* AWS CLI, kubectl, eksctl, helm, k9s
* jq, fzf, bash-completion 등

**✅ AWS 환경 구성 (2.set-aws-env.sh)**

* 프로파일 및 리전 변수 설정

**✅ KMS 키 구성 (3.kms-setup.sh)**

* 암호화용 KMS 키 및 별칭 구성으로 EKS 배포시 EBS 암호화를 위해 설정

#### Phase 3: Kiro CLI 및 MCP

**✅ 런타임 설치 (4.install\_core\_mcp.sh)**

* AWS MCP 설정을 위한 환경 구성으로 Python 3.12, uv, Node.js 설치를 포함합니다. 

**✅ MCP 서버 구성 (5.setup-mcp-config.sh)**

* MCP 구성 파일 생성 (\~/.aws/amazonq/mcp.json) 
* Kiro CLI 와 연동

***

### 1.4. 선택적 서비스 배포

**✅ Redis 구성  (**&#x30;.deploy-redis.s&#x68;**)**

해당 Shell Script는 DMZ VPC, Private Subnet에 Redis를 구성하는  Claudformation Stack을 배포합니다. 

```
./0.deploy-redis.sh
```

**✅ Aurora MySql 구성  (**&#x64;eploy-aurora.s&#x68;**)**

해당 Shell Script는 VPC01, Private Subnet에 **Aurora MySql**를 구성하는  Claudformation Stack을 배포합니다. 

```
./0.deploy-aurora.sh
```

**✅ O**pensearch **구성  (**&#x64;eploy-opensearch.s&#x68;**)**

해당 Shell Script는 DMZ VPC, Private Subnet에 **O**pensearch 를 구성하는  Claudformation Stack을 배포합니다. 

```
./deploy-opensearch.sh
```

**✅  EKS Cluster 구성**

해당 Shell Script는 DMZ VPC에 **O**pensearch 를 구성하는  Claudformation Stack을 배포합니다.

```
# EKS 클러스터 생성을 위한 환경변수 설정
./dmz_eks_shell.sh

# eksctl 구성 및 배포를 위한 yml 생성
./dmz_eksctl_shell.sh

eksctl create cluster --config-file=/home/ec2-user/amazonqcli_lab/LabSetup/eksworkshop.yaml --dry-run
eksctl create cluster --config-file=/home/ec2-user/amazonqcli_lab/LabSetup/eksworkshop.yaml

# 정리 (필요시)
./dmz_eks_cleanup.sh
```

***

### 1.5.  디렉터리 구조

```
LabSetup/
├── 배포 스크립트
│   ├── 0.depoly-all-vpcs.sh
│   ├── 0.deploy-tgw.sh
│   ├── 0.deploy-redis.sh
│   └── 0.deploy-aurora.sh
├── 환경 설정
│   ├── 1.vscode-tools-installer.sh
│   ├── 2.set-aws-env.sh
│   └── 3.kms-setup.sh
├── MCP 및 Q CLI 설정
│   ├── 4.install_core_mcp.sh
│   └── 5.setup-mcp-config.sh
├── EKS 관련
│   ├── dmz_eks_shell.sh
│   ├── dmz_eksctl_shell.sh
│   └── dmz_eks_cleanup.sh
├── 추가 서비스
│   └── deploy-opensearch.sh
└── CloudFormation 템플릿
    ├── 1.DMZVPC.yml
    ├── 2.VPC01.yml
    ├── 3.VPC02.yml
    ├── 4.TGW.yml
    ├── aurora-mysql-stack.yml
    ├── redis-cluster-stack.yml
    └── opensearch-stack.yml
```

***

> ✅ 이제 이 실습 환경을 기반으로 Kiro CLI, MCP, VSCode 및 다양한 AI 개발 도구를 통합한 실전 실습을 진행해보세요!
