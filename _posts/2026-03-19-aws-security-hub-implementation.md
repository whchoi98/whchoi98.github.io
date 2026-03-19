---
title: "Implementing AWS Security Hub for Cloud Security Posture"
tags: [Cloud-Security, AWS-Core]
categories: [Tech Blog]
key: security-hub
aside:
  toc: true
---

AWS Security Hub provides a comprehensive view of your security posture across AWS accounts. This post covers practical implementation patterns.

<!--more-->

## Enabling Security Hub

```bash
aws securityhub enable-security-hub \
  --enable-default-standards \
  --region ap-northeast-2
```

## Security Standards

Security Hub supports multiple compliance frameworks:

| Standard | Description |
|----------|-------------|
| AWS Foundational Security Best Practices | AWS-recommended security controls |
| CIS AWS Foundations Benchmark | Center for Internet Security benchmark |
| PCI DSS | Payment Card Industry standard |
| NIST SP 800-53 | Federal security controls |

## Automated Remediation Pattern

```python
import boto3
import json

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

## Multi-Account Aggregation

For organizations, configure a delegated administrator:

```bash
aws securityhub create-members \
  --account-details '[{"AccountId": "123456789012"}]'

aws securityhub invite-members \
  --account-ids "123456789012"
```

## Summary

Security Hub is essential for maintaining cloud security posture at scale. Combined with automated remediation, it enables proactive security management.

See the Cloud Security Workshop series for hands-on labs.
{:.info}
