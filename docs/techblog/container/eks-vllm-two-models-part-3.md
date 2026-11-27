---
title: "OpenWeight on AWS GPU 3부: 10개 단계로 따라 하는 구축 과정"
title_en: "OpenWeight on AWS GPU, Part 3: Building the environment in ten steps"
layout: report
report_src: /docs/techblog/container/eks-vllm-two-models-part-3-report.html
date: 2026-11-21
category: Container
tags: ["Amazon EKS", "vLLM", "Karpenter", "Terraform", "Gateway API Inference Extension", "LLM inference"]
icon: eks
minutes: 22
excerpt: "오픈 웨이트 모델 두 개를 Amazon EKS와 vLLM으로 서빙하는 환경을 VPC부터 로그인 페이지까지 10개 단계로 만듭니다. 단계마다 명령, 확인 방법, 측정한 값, 막히기 쉬운 곳을 같은 순서로 적었습니다."
excerpt_en: "Build an environment that serves two open-weight models with vLLM on Amazon EKS in ten steps, from the VPC to a signed-in page. Each step lists its commands, how to check it, the measured values and where it tends to go wrong."
---
