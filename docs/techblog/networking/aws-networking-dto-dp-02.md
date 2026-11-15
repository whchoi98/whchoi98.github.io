---
title: "AWS 네트워크 데이터 전송 및 처리 요금, 아키텍처로 이해하기 [2부: 리전 안의 트래픽]"
title_en: "Understanding AWS network data transfer and processing charges through architecture [Part 2: Traffic within a Region]"
layout: report
report_src: /docs/techblog/networking/aws-networking-dto-dp-02-report.html
date: 2026-09-21
category: Networking
tags: ["Elastic Load Balancing", "Network Load Balancer", "Amazon ElastiCache", "Valkey GLIDE", "Amazon EKS", "Amazon RDS", "Data Transfer", "Availability Zone"]
icon: vpc
minutes: 17
excerpt: "같은 리전 안에서 AZ 경계를 넘는 트래픽에 요금이 과금되는 규칙과 예외를 정리합니다. ALB와 NLB, 데이터베이스와 캐시, Amazon EKS에서 트래픽을 같은 AZ에 묶어 비용을 줄이는 설정을 서울 리전 요금 기준으로 살펴봅니다."
excerpt_en: "This post explains the rules and exceptions for charges on traffic that crosses AZs in a Region. It covers settings that keep traffic in one AZ and cut cost for ALB, NLB, databases, caches, and Amazon EKS, at Seoul Region prices."
---
