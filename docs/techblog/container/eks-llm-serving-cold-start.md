---
title: "EKS LLM 서빙 콜드스타트 428초에서 226초로 - 단계별 실측이 고른 레버 4개"
title_en: "EKS LLM Serving Cold Start from 428s to 226s - Four Levers Chosen by Stage-by-Stage Measurement"
layout: report
report_src: /docs/techblog/container/eks-llm-serving-cold-start-report.html
date: 2026-09-02
category: Container
tags: [EKS, vLLM, Karpenter, LLM Serving, Cold Start, S3]
icon: eks
minutes: 15
excerpt: "31B급 LLM을 vLLM으로 서빙할 때 콜드스타트를 노드, 이미지, 가중치, 컴파일 4구간으로 분해하고 레버를 하나씩 쌓아 같은 g7e 환경에서 재실측했습니다. runai_streamer S3 직결, torch.compile 캐시의 hostPath 영속화와 S3 프리로드, sleep/wake로 콜드 428초에서 226초, 웜 재기동 314초에서 133초, 유휴 복귀 0.97초에 이른 근거와 성립 조건을 정리합니다."
excerpt_en: "Serving a 31B LLM with vLLM on EKS, we split the cold start into node, image, weights, and compile segments and re-measured each lever in the same g7e environment. Direct-to-S3 loading with runai_streamer, torch.compile cache persistence on hostPath plus S3 preload, and sleep/wake take the cold start from 428s to 226s, warm restarts from 314s to 133s, and idle recovery to 0.97s - with the evidence and the conditions under which each lever holds."
---
