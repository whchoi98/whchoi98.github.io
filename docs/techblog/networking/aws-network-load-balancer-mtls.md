---
title: "AWS Network Load Balancer mTLS"
title_en: "AWS Network Load Balancer mTLS"
layout: report
report_src: /docs/techblog/networking/aws-network-load-balancer-mtls-report.html
date: 2026-11-23
category: Networking
tags: ["Network Load Balancer", "mTLS", "Elastic Load Balancing", "Trust store", "X.509", "SPIFFE"]
icon: vpc
minutes: 11
excerpt: "Network Load Balancer의 mTLS를 서울 리전에서 인증서 48종으로 테스트했습니다. mTLS로 늘어난 시간은 ECDSA P-256 인증서에서 0.5ms였고 설정 변경은 호출 후 31초에서 62초 사이에 적용됐으며 거부 사유는 액세스 로그에만 남았습니다."
excerpt_en: "I tested mTLS on Network Load Balancer in the Seoul Region with 48 kinds of client certificates. mTLS added 0.5 ms with an ECDSA P-256 certificate, a configuration change took effect 31 to 62 seconds after the call, and the reason for a rejection appeared only in the access logs."
---
