---
title: "LAB 0. VSCode 서버 구성"
parent: AIML
grand_parent: Workshop
nav_order: 4
last_modified_date: "2026-03-19"
---

# LAB 0. VSCode 서버 구성하기
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## 1. VSCode Server 기반 실습 환경 구축 가이드

이 문서는 Kiro CLI를 도구로 랩 환경에서 실습을 위해 필요한 도구 설치, VPC 및 클러스터 배포 과정을 안내합니다.

MAC OS , 또는 다른 환경에서 이미 Kiro CLI를 설치하였다면, 해당 챕터는 생략해도 됩니다.

***

### 1.1. 기본 환경 준비

Cloudshell에서 아래 git을 Clone하고, iam user를 생성합니다.

* iam user name :
* iam user pwd :
* account alias :

```
git clone https://github.com/whchoi98/useful-shell.git
cd ~/useful-shell/
./create_iam_user.sh
```

실습 환경을 위해 iam user는 admin 권한이므로 주의를 필요로 합니다 !!!

***

### 1.2 . 관리용 VPC 및 ALB + VSCode Server 배포

신규 생성된 계정과 ID로 접속해서, 다시 Cloudshell을 실행합니다.

관리용 VPC 및 ALB+VSCode 서버를 배포합니다.

* VPC Name : mgmtvpc

```
# Cloudshell에서 GitHub 저장소 복제
git clone https://github.com/whchoi98/ec2_vscode.git
aws cloudformation deploy \
  --template-file "~/ec2_vscode/vscode_secure.yml" \
  --stack-name=mgmtvpc \
  --capabilities CAPABILITY_NAMED_IAM
  
```

* ALB DNS 확인 : 아래 Shell을 실행해서, VSCode에 접속 가능한 URL을 확인합니다.

```
~/ec2_vscode/mgmtvpc_alb1.sh
```

* VSCode에 접속 후 터미널에서 아래 Git을 다시 복제하고, VSCode Server의 패스워드를 신규 입력합니다.

```
git clone https://github.com/whchoi98/ec2_vscode.git
~/ec2_vscode/vscode_pwd.sh
```

* ALB DNS로 재접속하면, 신규 설정된 패스워드를 입력하고 VSCode에 연결합니다.
