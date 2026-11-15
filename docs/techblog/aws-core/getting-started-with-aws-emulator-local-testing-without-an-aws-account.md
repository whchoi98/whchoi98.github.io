---
title: "AWS Emulator 시작하기: 계정 없이 AWS 애플리케이션을 로컬에서 테스트하는 방법과 활용 사례"
title_en: "Getting started with AWS Emulator: How to test AWS applications locally without an account, and use cases"
layout: report
report_src: /docs/techblog/aws-core/getting-started-with-aws-emulator-local-testing-without-an-aws-account-report.html
date: 2026-11-15
category: AWS Core
tags: ["AWS Emulator", "Integration Testing", "pytest", "CI", "Amazon S3", "Amazon DynamoDB", "AWS Lambda", "Coding Agent"]
icon: lambda
minutes: 11
excerpt: "AWS API를 로컬 프로세스 하나로 흉내 내는 AWS Emulator의 동작 방식과 설치, 연결 방법을 소개합니다. pytest 통합 테스트, 자격 증명 없는 CI 작업, 오류 경로 테스트, Lambda 호출 예제와 함께 적합한 용도와 맞지 않는 용도를 v1.0.322 측정 결과로 정리합니다."
excerpt_en: "This post introduces how AWS Emulator, which emulates AWS APIs in a single local process, works and how to install and connect to it. It covers pytest integration tests, CI jobs without credentials, error path tests, and a Lambda invocation example, and sorts suitable from unsuitable uses with results measured on v1.0.322."
---
