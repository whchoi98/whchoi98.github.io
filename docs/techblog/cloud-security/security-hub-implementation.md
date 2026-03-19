---
title: AWS Security Hub Implementation
parent: Cloud Security
grand_parent: Tech Blog
nav_order: 1
last_modified_date: "2026-03-19"
---

# Implementing AWS Security Hub for Cloud Security Posture
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

AWS Security Hub provides a comprehensive view of your security posture across AWS accounts.

{: .note }
> Tags: `Cloud-Security` `AWS-Core`

## Enabling Security Hub

```bash
aws securityhub enable-security-hub \
  --enable-default-standards \
  --region ap-northeast-2
```

## Security Standards

| Standard | Description |
|:---------|:------------|
| AWS Foundational Security Best Practices | AWS-recommended security controls |
| CIS AWS Foundations Benchmark | Center for Internet Security benchmark |
| PCI DSS | Payment Card Industry standard |
| NIST SP 800-53 | Federal security controls |

## Automated Remediation Pattern

```python
import boto3

def lambda_handler(event, context):
    """Auto-remediate Security Hub findings."""

    finding = event['detail']['findings'][0]
    resource_type = finding['Resources'][0]['Type']

    if finding['Title'] == 'S3 bucket should have server-side encryption':
        s3 = boto3.client('s3')
        bucket_name = finding['Resources'][0]['Id'].split(':')[-1]

        s3.put_bucket_encryption(
            Bucket=bucket_name,
            ServerSideEncryptionConfiguration={
                'Rules': [{
                    'ApplyServerSideEncryptionByDefault': {
                        'SSEAlgorithm': 'aws:kms'
                    }
                }]
            }
        )

    return {'statusCode': 200}
```

{: .warning }
> Always test automated remediation in a non-production environment first.

## Multi-Account Aggregation

```bash
aws securityhub create-members \
  --account-details '[{"AccountId": "123456789012"}]'

aws securityhub invite-members \
  --account-ids "123456789012"
```

## Summary

Security Hub is essential for maintaining cloud security posture at scale. Combined with automated remediation, it enables proactive security management.
