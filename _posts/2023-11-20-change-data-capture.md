---
layout: post
title: "Change Data Capture (CDC) pattern: a real-time data synchronization solution"
subtitle: "To listen all the changes."
cover-img: https://images.unsplash.com/photo-1641510653579-84da19c3208b?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMja3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fa%3D%3D
thumbnail-img: https://images.unsplash.com/photo-1628116709703-c1c9ad550d36?q=80&w=3542&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMja3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fa%3D%3D
tags: [data-engineering]
---

The system is using micro-services where the processing of data is broken up into smaller tasks. Each application enters its data into the database. You want to react to certain changes in the database


**Quick access:**
- [Motivation](#motivation)
- [Why to implement CDC?](#why-to-implement-cdc)
  - [Pros](#pros)
  - [Cons](#cons)
    - [CDC per data source](#cdc-per-data-source)
    - [Data meaning](#data-meaning)
    - [Schema changes](#schema-changes)
- [CDC vs Event sourcing](#cdc-vs-event-sourcing)
  - [Shared Goals for Event Sourcing and Change Data Capture](#shared-goals-for-event-sourcing-and-change-data-capture)
  - [The differences](#the-differences)
- [Conclusion](#conclusion)
- [Reference](#reference)


# Motivation

![Changes from various sources](/assets/img/cdc-motivation.png){: .mx-auto.d-block :}

We have some difference applications/services using the same database.

The system is using micro-services where the processing of data is broken up into smaller tasks. Each application enters its data into the database. You want to react to certain changes in the database — for example, when one of the records updates.

> You want to avoid the situation that each application has its piece of code that sends a notification that something has been updated in the database.

CDC (Change Data Capture) is a software design pattern that is used to monitor changes in data an perform certain actions based on data change. Mostly includes read, updated or delete operations.

# Why to implement CDC?

## Pros

The idea is to observe what is happening in the data layer of the applications, i.e., which data is changing as a result of business operations, and to capture that set of changes in a message.

The database, which we listen to, remains intact as we do not add any triggers or log tables. So that we don't need to touch the legacy system since it's usually risky, sometime it leads to the performance degradation of the database.

To implement the CDC, we will need to add two items in our pipeline:

- Service that listens for changes over rows in the database (Debezium)
- Service that stream the data (Kafka)

<p align = "center">
<img src = "https://debezium.io/documentation/reference/stable/_images/debezium-architecture.png">
</p>
<p align = "center">
Apply CDC pattern with Debezium and Kafka. (Source: Debezium Documentation)
</p>

## Cons

In the real world, many develops and architects have been encountering some drawbacks.

### CDC per data source

Each type of database requires a different approach to CDC. There are different mechanisms for each source and the cannot be unified for multiple sources with different characteristics.

For example, Debezium captures changes from MySQL by watching its [binlog](https://dev.mysql.com/doc/refman/5.7/en/replication-howto-masterbaseconfig.html), but for PostgreSQL the service listens to DB's [WaL (Write ahead Log)](https://www.postgresql.org/docs/9.6/runtime-config-wal.html) for replication.

### Data meaning

Relational database sources are often denormalized and modified to allow a fast read or write operations based on concrete usage scenarios.

Capturing this kind of data may result in a hard to understand set of data, which is far away from the concept of a DTO.

On the other hand, many changes in database tables may not be related to the actual business logic triggering them, but the maintenance operations or reporting activities. This create noises.

### Schema changes

Sometimes datasource schema changes occurred, CDC just keeps picking out the data change including new columns' values. Without being noticed or monitored, we cannot have a full control over the data quality for the downstream tasks.

![Collaboration](https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMja3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fa%3D%3D)


# CDC vs Event sourcing

## Shared Goals for Event Sourcing and Change Data Capture
The two core services provided in this article are Event Sourcing and also Change Data Capture. Before introducing these 2 solutions, it can be recognized that they serve similar objectives, which are:

- Designate one datastore as the global source of truth for a specific set of data
- Provide a representation of past and current application state as a series of events, also called a journal or transaction log
- Offer a journal that can replay events, as needed, for rebuilding or refreshing state.

Event Sourcing uses its own journal as the resource of reality, while Change Data Capture depends on the underlying database transaction log as the source of truth. This distinction has major implications on the style as well as application of software application which will certainly exist later in this post.

## The differences

| ATTRIBUTE | EVENT SOURCING | CDC |
| --- | --- | --- |
| Purpose | Capture state in a journal containing domain events. | Export Change Events from transaction log. |
| Event Type | Domain Event | Change Event |
| Source of Truth | Journal | Transaction Log |
| Boundary | Application | System |
| Consistency Model | N/A (only writing to the Journal) | Strongly Consistent (tables), Eventually Consistent (Change Event capture) |
| Replayability | Yes | Yes |

# Conclusion
So we know that Change Data Capture pattern can tackle some of the problems as a framework to build a real-time data synchronization solution, which is a common requirement in many organizations, we also see a plenty of drawbacks as well.

Building distributed event-driven systems is always challenging, since Event Sourcing is a mature pattern and it is worth to consider as the first move. Choose the right approach for your use case.

# Reference

- [Distributed Data for Microservices — Event Sourcing vs. Change Data Capture](https://debezium.io/blog/2020/02/10/event-sourcing-vs-cdc/)
- [Change Data Capture (CDC) - Pattern Or antipattern? – avenga](https://www.avenga.com/magazine/change-data-capture/)
- [Listen to Database changes with apache Kafka](https://medium.com/geekculture/listen-to-database-changes-with-apache-kafka-35440a3344f0)
