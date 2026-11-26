---
title: "Elastic Load Balancing for Envoy"
title_en: "Elastic Load Balancing for Envoy"
layout: report
report_src: /docs/techblog/networking/elastic-load-balancing-for-envoy-report.html
date: 2026-11-26
category: Networking
tags: ["Elastic Load Balancing", "Envoy", "Envoy Gateway", "Gateway API", "Amazon EKS", "AWS WAF"]
icon: vpc
minutes: 23
excerpt: "Envoy 프록시를 AWS가 운영하는 ELB for Envoy를 도쿄 리전의 Amazon EKS 클러스터에서 테스트했습니다. 10분 부하에서 노드가 3개에서 23개로 늘며 4,568만 건을 오류 없이 처리했고 지연 시간은 평균 1.7ms 늘었습니다. Envoy Gateway가 멈춘 동안 백엔드가 교체되면 요청이 실패했습니다."
excerpt_en: "I tested ELB for Envoy, where AWS runs the Envoy proxies, with an Amazon EKS cluster in the Tokyo Region. Under a 10-minute load the proxy grew from 3 to 23 nodes and served 45.7 million requests without an error, and it added 1.7 ms on average. Requests failed when backends were replaced while Envoy Gateway was down."
---
