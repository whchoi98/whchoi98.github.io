---
title: "AWS 네트워크 데이터 전송 및 처리 요금, 아키텍처로 이해하기 [1부: 요금 구조와 인터넷 경계]"
title_en: "Understanding AWS network data transfer and processing charges through architecture [Part 1: Pricing structure and the internet boundary]"
layout: report
report_src: /docs/techblog/networking/aws-networking-dto-dp-01-report.html
date: 2026-09-21
category: Networking
tags: ["Amazon VPC", "NAT Gateway", "VPC Endpoints", "AWS PrivateLink", "Amazon CloudFront", "Data Transfer", "Public IPv4", "AWS Cost and Usage Reports"]
icon: vpc
minutes: 14
excerpt: "AWS 네트워크 비용은 데이터 전송 요금과 데이터 처리 요금 두 가지로 정해집니다. 서울 리전 요금을 기준으로 인터넷 게이트웨이, 퍼블릭 IPv4 주소, NAT Gateway, VPC 엔드포인트, Amazon CloudFront에서 비용이 발생하는 경로와 줄이는 방법을 정리합니다."
excerpt_en: "AWS networking costs are determined by two charges, data transfer and data processing. Based on Seoul Region prices, this post covers the paths where costs arise at internet gateways, public IPv4 addresses, NAT gateways, VPC endpoints, and Amazon CloudFront, and how to reduce them."
---
