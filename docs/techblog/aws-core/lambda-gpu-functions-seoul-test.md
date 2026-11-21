---
title: "서울 리전에서 테스트한 AWS Lambda GPU 함수의 시작 시간과 동시성"
title_en: "Start-up time and concurrency of AWS Lambda GPU functions, tested in Seoul"
layout: report
report_src: /docs/techblog/aws-core/lambda-gpu-functions-seoul-test-report.html
date: 2026-11-21
category: AWS Core
tags: ["AWS Lambda", "Lambda Managed Instances", "GPU", "vLLM", "LLM inference"]
icon: lambda
minutes: 12
excerpt: "AWS Lambda GPU 함수를 서울 리전에 배포해 시작 시간과 동시 처리량을 테스트했습니다. 버전 발행부터 Active까지 5분 28초에서 7분 33초가 걸렸고 L4 GPU 한 장이 동시 48건에서 초당 2,885토큰을 처리했습니다."
excerpt_en: "I deployed AWS Lambda GPU functions in the Seoul Region and tested start-up time and concurrent throughput. Publish to Active took 5 min 28 s to 7 min 33 s, and one L4 GPU served 2,885 tokens per second at 48 concurrent requests."
---
