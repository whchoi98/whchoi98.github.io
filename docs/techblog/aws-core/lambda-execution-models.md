---
title: "AWS Lambda 실행 모델 4종의 구조와 선택 기준"
title_en: "The Four AWS Lambda Execution Models - Structure and Selection Criteria"
layout: report
report_src: /docs/techblog/aws-core/lambda-execution-models-report.html
date: 2026-08-26
category: AWS Core
tags: [Lambda, Serverless, Firecracker, Durable Functions, MicroVMs]
icon: lambda
minutes: 14
excerpt: "Lambda는 이제 단일 서비스가 아니라 실행 모델 4종(Functions, Managed Instances, Durable Functions, MicroVMs)의 묶음입니다. 실행 단위·지속 시간·격리·상태 유지가 어떻게 다른지, 기본 함수의 설정 축과 한도까지 공식 문서 기준으로 전부 정리합니다."
excerpt_en: "Lambda is no longer a single service but a bundle of four compute primitives - Functions, Managed Instances, Durable Functions, and MicroVMs. How they differ in execution unit, duration, isolation, and state, plus every configuration axis and quota of classic functions, all grounded in the official docs."
---
