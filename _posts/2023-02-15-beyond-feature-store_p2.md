---
layout: post
title: "Beyond Feature Store - Part 2: Feature Platform"
subtitle: Which has maturity
thumbnail-img: /assets/img/fp-thumbnail.jpeg
tags: [mlops,data engineering]
---

We've been talking about feature store in [Part 1](https://sudohainguyen.github.io/2023-01-15-beyond-feature-store_p1/), there are some limitations to address to bring more better use for the team. There is a new concept has been gained attraction recently, Feature Platform.

## Introduction
In [Part 1](https://sudohainguyen.github.io/2023-01-15-beyond-feature-store_p1/), we have been through some of my observations about definitions benefits of feature store, as well as its limitations in terms of implementation. Recently, Feature Engineering Platform or Feature Platform has been risen as an alternative,

First why it gets evolved to a platform, what should a platform provide? According to [this article](https://platformengineering.org/blog/what-is-platform-engineering) about Platform Engineering. A Platform should enable a self-service way as a golden path for users by designing and building toolchains that fits specific use cases. For organization's internal platform, toolchain could be from gluing external teams tools or combining self-built ones as long as they resolve the problems.

To address problems we discussed, a standalone feature store is not powerful enough, so that it has to involve capabilities of other tools.

## What we should expect from a Feature Platform

### More robust monitoring
To increase usability of features, they are expected to be monitored by users via a visible mechanism, as the result they can be evaluated as good to be trusted using their ML models/pipelines. These below are some of critera to focus

1. Data quality: data landing time, SLA, error rates
2. Usage: throughput, latency, number of consumers.
3. Lineage: track all the way from raw upstream data to anchor features and derived features.


### Backfill control capability

![Backfill control](/assets/img/backfill.png){: .mx-auto.d-block :}

As we observed, data goes from data warehouse to feature platform only one way as readers. But what if users desire historical features much longer in the past? Should users have to talk to Platform maintainer to conduct backfill or they have to do by themself on another platform? FP is expected to let users can decide which timerange to process backfill if needed with less human effort as possible.


### Self-serving and Streaming aggregation
As [well stated](https://huyenchip.com/2023/01/08/self-serve-feature-platforms.html) by Huyen Chip, we can see these are two points that high-end Feathr Feature Platform is tackling. One is from human process and one is from implementation limitation.

## Feature Store as a component
Beside feature store, which is the core component of Feature Platform, there are several tools can be integrated under the hood:

- Airflow: FP should be capable of controling airflow, to conduct backfill on requested, generate new DAG to compute new features, etc...
- Great Expectation/Deequ: all data flows through FP is expected to be checked/validated before furthre processes. For example, we validate feature tables to ensure that it follows business rules, or validate entity table users' input. With data validation functionalities, we can early detect issue happening to our system.
- OpenLineage: is an open platform for collection and analysis of data lineage. It tracks metadata about datasets, jobs, and runs, giving users the information required to identify the root cause of complex issues and understand the impact of changes.

## Conclusion
To summarize, there are a lot of problem to tackle for Feature Platform to get mature enough for self-serving capability. Consequently, may be self-serving is not the true north of FP? Should it be operated as a team as product instead, like we already have with Data Platform.
