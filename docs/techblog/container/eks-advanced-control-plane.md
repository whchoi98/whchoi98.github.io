---
title: "Amazon EKS 고급 컨트롤 플레인 구성하기"
title_en: "Configuring advanced control plane settings in Amazon EKS"
layout: report
report_src: /docs/techblog/container/eks-advanced-control-plane-report.html
date: 2026-09-14
category: Container
tags: ["Amazon EKS", "Kubernetes", "Provisioned Control Plane", "kube-scheduler", "kube-controller-manager", "kube-apiserver", "Horizontal Pod Autoscaler", "NodePort"]
icon: eks
minutes: 15
excerpt: "Amazon EKS가 kube-scheduler, kube-controller-manager, kube-apiserver의 파라미터 5가지를 고객이 직접 설정하도록 열었습니다. 파라미터별 동작 방식과 조정 효과, 운영 규칙을 공식 문서 기준으로 정리합니다."
excerpt_en: "Amazon EKS now lets customers directly set five parameters of kube-scheduler, kube-controller-manager, and kube-apiserver. This post summarizes how each parameter works, what tuning it achieves, and the operational rules, based on the official documentation."
---
