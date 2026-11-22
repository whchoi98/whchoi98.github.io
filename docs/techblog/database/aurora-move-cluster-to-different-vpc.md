---
title: "Amazon Aurora 클러스터의 VPC 이동과 중단 시간"
title_en: "The interruption when an Amazon Aurora cluster moves to another VPC"
layout: report
report_src: /docs/techblog/database/aurora-move-cluster-to-different-vpc-report.html
date: 2026-11-22
category: Database
tags: ["Amazon Aurora", "Aurora PostgreSQL", "Aurora MySQL", "Amazon VPC", "ModifyDBCluster"]
icon: database
minutes: 17
excerpt: "Amazon Aurora 클러스터를 다른 VPC로 옮기는 기능을 서울 리전에서 38회 테스트했습니다. 쓰기 중단은 중앙값 24.7초였고 타임아웃이 없는 클라이언트의 연결은 963초 멈췄으며 서버에는 끊긴 세션의 잠금이 약 6분 남았습니다."
excerpt_en: "I moved Amazon Aurora clusters between two VPCs 38 times in the Seoul Region. Writes were interrupted for a median of 24.7 s, a client without timeouts stalled for 963 s on its open connection, and the locks of cut sessions stayed on the server for about six minutes."
---
