---
title: "Amazon ECS 실행 구조와 선택 기준 1부: 컴퓨트와 실행 형태"
title_en: "Amazon ECS execution model and selection criteria, Part 1: Compute and execution types"
layout: report
report_src: /docs/techblog/container/ecs-design-01-report.html
date: 2026-09-04
category: Container
tags: ["Amazon ECS", "AWS Fargate", "Amazon ECS Managed Instances", "Capacity Provider", "Launch Type", "Amazon ECS Express Mode", "AWS Batch", "Amazon EventBridge Scheduler"]
icon: ecs
minutes: 10
excerpt: "Amazon ECS 개발자 가이드는 launch type을 호환되는 실행 환경을 선언하는 용도로만 사용하고 실제 실행은 capacity provider로 구성하라고 권고합니다. 2부작의 1부로, 이 원칙과 ECS Managed Instances를 포함한 컴퓨트 4종, 서비스와 Task 실행 형태 네 가지를 정리합니다."
excerpt_en: "The Amazon ECS Developer Guide recommends using the launch type only to declare compatible execution environments and configuring actual execution with capacity providers. Part 1 of a two-part series covers this principle, the four compute options including ECS Managed Instances, and the four execution types for services and tasks."
---
