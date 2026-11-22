---
title: "AWS Transit Gateway 1:1 NAT"
title_en: "AWS Transit Gateway 1:1 NAT"
layout: report
report_src: /docs/techblog/networking/aws-transit-gateway-1-1-nat-seoul-test-report.html
date: 2026-11-21
category: Networking
tags: ["AWS Transit Gateway", "1:1 NAT", "Overlapping CIDR", "Private NAT Gateway", "Amazon VPC", "Site-to-Site VPN"]
icon: vpc
minutes: 23
excerpt: "AWS Transit Gateway 1:1 NAT를 서울 리전의 기존 Transit Gateway에서 테스트했습니다. CIDR이 같은 두 VPC가 통신했고 활성화에는 연결당 1분 안팎이 걸렸으며 한쪽만 활성화하면 원래 주소로 가던 요청이 다른 VPC의 서버에 도착했습니다."
excerpt_en: "I tested AWS Transit Gateway 1:1 NAT on an existing transit gateway in the Seoul Region. Two VPCs with the same CIDR could talk, enabling took about a minute per attachment, and with NAT on one side only, requests to the original address reached a server in the other VPC."
---
