---
title: Building RAG with Amazon Bedrock
parent: AIML
grand_parent: Tech Blog
nav_order: 1
---

# Building RAG Architecture with Amazon Bedrock
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Introduction

Retrieval-Augmented Generation (RAG) combines the power of large language models with your organization's knowledge base.

{: .note }
> Tags: `AIML` `AWS-Core`

## Architecture Overview

```
User Query
    |
    v
+---------------+    +----------------------+
|  Application  |--->| Amazon Bedrock       |
|  (Lambda)     |    | Knowledge Base       |
+---------------+    +----------+-----------+
                                |
                     +----------v-----------+
                     | OpenSearch           |
                     | Serverless           |
                     | (Vector Store)       |
                     +----------+-----------+
                                |
                     +----------v-----------+
                     | Amazon S3            |
                     | (Document Store)     |
                     +----------------------+
```

## Key Components

### 1. Amazon Bedrock Knowledge Base

Bedrock Knowledge Base handles document ingestion, chunking, embedding, and retrieval automatically.

```python
import boto3

bedrock_agent = boto3.client('bedrock-agent-runtime', region_name='us-east-1')

response = bedrock_agent.retrieve_and_generate(
    input={'text': 'What is the backup policy?'},
    retrieveAndGenerateConfiguration={
        'type': 'KNOWLEDGE_BASE',
        'knowledgeBaseConfiguration': {
            'knowledgeBaseId': 'YOUR_KB_ID',
            'modelArn': 'arn:aws:bedrock:us-east-1::foundation-model/anthropic.claude-sonnet-4-20250514'
        }
    }
)
```

### 2. Vector Store - OpenSearch Serverless

OpenSearch Serverless provides a managed vector database for storing document embeddings.

{: .important }
> OpenSearch Serverless requires minimum 2 OCUs ($345.60/month minimum).

### 3. Document Store - Amazon S3

S3 stores the source documents that feed into the knowledge base.

## Best Practices

| Practice | Description |
|:---------|:------------|
| **Chunking Strategy** | Use semantic chunking for better retrieval accuracy |
| **Embedding Model** | Use Amazon Titan Embeddings v2 for multilingual support |
| **Monitoring** | Enable CloudWatch metrics for retrieval latency tracking |

## Conclusion

Amazon Bedrock Knowledge Base simplifies RAG implementation by managing the entire pipeline. Combined with OpenSearch Serverless and S3, you can build a scalable, production-ready RAG system.

{: .tip }
> For hands-on practice, check out the upcoming Bedrock RAG Workshop.
