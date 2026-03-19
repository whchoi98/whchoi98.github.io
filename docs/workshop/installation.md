---
title: "설치(Installation)"
parent: Kiro CLI Workshop
nav_order: 6
last_modified_date: "2026-03-19"
---

# 설치
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

***

## 1. Installation / 설치

이 페이지에서는 macOS, Linux(AppImage, zip, Ubuntu .deb), Proxy 환경 지원, 제거(Uninstall), 문제 해결(Debug) 등 Kiro CLI의 모든 설치 방식과 설정 옵션을 안내합니다.

***

### 1.1. macOS 설치 (macOS Installation)

macOS에서는 터미널에서 아래 명령어를 실행하여 Kiro CLI를 네이티브로 설치할 수 있습니다.

```
curl -fsSL https://cli.kiro.dev/install | bash
```

설치 후 Kiro CLI는 브라우저 인증(Authentication) 페이지로 이동하도록 안내합니다.

***

### 1.2. Linux AppImage 설치 (Linux AppImage Installation)

AppImage는 대부분의 Linux 배포판에서 별도 설치 없이 실행 가능한 휴대형 포맷입니다.

#### 설치 절차

**1) AppImage 다운로드**

```
https://desktop-release.q.us-east-1.amazonaws.com/latest/kiro-cli.appimage
```

**2) 실행 권한 부여**

```
chmod +x kiro-cli.appimage
```

**3) 실행**

```
./kiro-cli.appimage
```

실행 후 브라우저를 열어 Authentication 절차를 진행하라는 안내가 표시됩니다.

***

## 2. Linux ZIP 설치 (Linux ZIP Installation)

Linux 환경에서는 ZIP 패키지를 통해 설치할 수도 있습니다.

설치 단계는 다음 세 부분으로 구성됩니다.

1. ZIP 파일 다운로드
2. glibc 버전 확인
3. 설치 스크립트 실행

***

### 2.1 사전 요구사항 (Install & Update Requirements)

* ZIP 패키지를 압축 해제(unzip) 할 수 있어야 합니다.
* Kiro CLI는 glibc 2.34 이상이 필요합니다. (2021년 이후 배포판 대부분 포함)
* glibc 2.34 미만인 배포판은 musl 기반 패키지(-musl.zip) 를 사용해야 합니다.
* 지원 아키텍처:
  * x86\_64 (64-bit)
  * ARM aarch64
* Fedora, Ubuntu, Amazon Linux 2023의 최신 버전에서 지원됩니다.

***

### 2.2 glibc 버전 확인

```
ldd --version
```

* 2.34 이상 → standard 버전 사용
* 2.34 미만 → musl 버전 사용

💡 Amazon Linux 2023 + 최신 AWS CLI 설치 환경은 기본적으로 glibc 2.34 이상입니다.

***

### 2.3 ZIP 파일 다운로드

아키텍처 및 glibc 버전에 따라 올바른 ZIP 파일을 다운로드합니다.

#### Standard Version (glibc 2.34+)

**Linux x86-64**

```
curl --proto '=https' --tlsv1.2 -sSf \
'https://desktop-release.q.us-east-1.amazonaws.com/latest/kirocli-x86_64-linux.zip' \
-o 'kirocli.zip'
```

**Linux ARM (aarch64)**

```
curl --proto '=https' --tlsv1.2 -sSf \
'https://desktop-release.q.us-east-1.amazonaws.com/latest/kirocli-aarch64-linux.zip' \
-o 'kirocli.zip'
```

***

#### Musl Version (glibc < 2.34)

**Linux x86-64 (musl)**

```
curl --proto '=https' --tlsv1.2 -sSf \
'https://desktop-release.q.us-east-1.amazonaws.com/latest/kirocli-x86_64-linux-musl.zip' \
-o 'kirocli.zip'
```

**Linux ARM (aarch64, musl)**

```
curl --proto '=https' --tlsv1.2 -sSf \
'https://desktop-release.q.us-east-1.amazonaws.com/latest/kirocli-aarch64-linux-musl.zip' \
-o 'kirocli.zip'
```

***

### 2.3 설치 실행

#### 압축 해제

```
unzip kirocli.zip
```

#### 설치 스크립트 실행

```
./kirocli/install.sh
```

기본적으로 Kiro CLI는 다음 경로에 설치됩니다.

```
~/.local/bin
```

***

## 3. Ubuntu 설치 (Ubuntu Installation)

Ubuntu에서는 .deb 패키지를 사용하여 설치할 수 있습니다.

#### 설치 파일 다운로드

```
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/kiro-cli.deb
```

#### 패키지 설치

```
sudo dpkg -i kiro-cli.deb
sudo apt-get install -f
```

#### 실행

```
kiro-cli
```

실행 시 브라우저 인증(Authentication) 절차로 안내됩니다.

***

## 4. Proxy 환경 구성 (Proxy Configuration)

Kiro CLI v1.8.0 이상은 기업 환경에서 사용되는 프록시 서버(proxy servers) 를 지원합니다.

CLI는 일반적인 proxy 환경 변수(proxy environment variables) 를 자동으로 인식합니다.

### 4.1 프록시 환경 변수 설정

```
# HTTP 트래픽용 프록시
export HTTP_PROXY=http://proxy.company.com:8080

# HTTPS 트래픽용 프록시
export HTTPS_PROXY=http://proxy.company.com:8080

# 특정 도메인 프록시 우회
export NO_PROXY=localhost,127.0.0.1,.company.com
```

### 4.2 인증이 필요한 프록시

```
export HTTP_PROXY=http://username:password@proxy.company.com:8080
export HTTPS_PROXY=http://username:password@proxy.company.com:8080
```

### 4.3 프록시 문제 해결

* 프록시 서버 접근성 및 인증 정보 확인
* 사내 방화벽이 AWS 엔드포인트를 차단하는지 확인
* SSL 인증서 오류 발생 시 IT 관리자에게 문의
* 프록시 서버가 필요한 프로토콜을 지원하는지 점검

***

## 5. Uninstall / 제거

### macOS 제거

```
kiro-cli uninstall
```

### Ubuntu 제거

#### 패키지 제거

```
sudo apt-get remove kiro-cli
```

#### 잔여 설정 파일 제거

```
sudo apt-get purge kiro-cli
```

***

## 6. Debugging / 디버깅

문제가 발생하면 다음 명령을 실행하여 환경을 점검할 수 있습니다.

```
kiro-cli doctor
```

#### 예상 출력

```
✔ Everything looks good!

Kiro CLI still not working? Run kiro-cli issue to let us know!
```

출력이 예상과 다르면 안내되는 메시지에 따라 문제를 해결합니다.

해결되지 않는 경우 다음 명령으로 버그 리포트를 생성할 수 있습니다:

```
kiro-cli issue
```

***

## 7. Common Issues / 일반적인 문제

#### • 인증 실패(Authentication failures)

kiro-cli login 명령으로 다시 인증을 시도합니다.

#### • 자동 완성(Autocomplete) 미작동

kiro-cli doctor로 셸 통합(shell integration)이 정상 적용되었는지 확인합니다.

#### • SSH 통합(SSH Integration) 문제

SSH 서버가 필요한 환경 변수를 허용하도록 올바르게 구성되어 있는지 확인합니다.

***

## 8. Troubleshooting Steps / 문제 해결 절차

1. kiro-cli doctor 실행
2. 네트워크 연결 확인
3. Kiro CLI가 지원하는 환경인지 검증
4. 재설치 시도
5. 문제 지속 시 kiro-cli issue로 리포트 제출
