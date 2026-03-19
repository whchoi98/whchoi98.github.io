---
title: "LAB 0. VSCode 서버 구성"
parent: Kiro CLI Workshop
grand_parent: AIML
nav_order: 1
last_modified_date: "2026-03-19"
---

# LAB 0. VSCode 서버 구성하기
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

*Update: 2025.12.07*
{: .fs-3 .text-grey-dk-000 }

## 1. VSCode Server 기반 실습 환경 구축 가이드

이 문서는 Kiro CLI를 도구로 랩(Lab) 환경에서 실습을 위해 필요한 도구 설치, VPC 및 클러스터(Cluster) 배포 과정을 안내합니다.

{: .note }
> macOS 또는 다른 환경에서 이미 Kiro CLI를 설치하였다면, 해당 챕터는 생략해도 됩니다.

---

### 1.1. 기본 환경 준비

CloudShell에서 아래 Git을 Clone하고, IAM User를 생성합니다.

- IAM User Name: (실습 시 지정)
- IAM User Password: (실습 시 지정)
- Account Alias: (실습 시 지정)

```bash
git clone https://github.com/whchoi98/useful-shell.git
cd ~/useful-shell/
./create_iam_user.sh
```

{: .warning }
> 실습 환경을 위해 IAM User는 Admin 권한이므로 주의를 필요로 합니다!

---

### 1.2. 관리용 VPC 및 ALB + VSCode Server 배포

신규 생성된 계정과 ID로 접속해서, 다시 CloudShell을 실행합니다.

관리용 VPC 및 ALB + VSCode 서버를 배포합니다.

- **VPC Name**: mgmtvpc

```bash
git clone https://github.com/whchoi98/useful-shell.git
cd ~/useful-shell/
./mgmt_vpc_deploy.sh
```

{: .important }
> CloudFormation 스택(Stack) 배포가 완료될 때까지 약 5-10분 소요됩니다.

---

## 참고 자료(References)

- [원본 소스(Source): whchoi98/awsmcp](https://github.com/whchoi98/awsmcp/blob/main/kiro-cli/vscode.md)
- [Kiro CLI 공식 사이트](https://kiro.dev/)
