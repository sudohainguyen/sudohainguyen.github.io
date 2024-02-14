---
layout: post
title: "Change Data Capture (CDC) pattern: another real-time data ingestion approach."
subtitle: "To listen all the changes."
cover-img: https://images.unsplash.com/photo-1641510653579-84da19c3208b?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMja3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fa%3D%3D
thumbnail-img: /assets/img/cdc-thumbnail.jpg
tags: [data engineering]
---

There are various ways to conduct data ingestion, depending on the strategy we want to use the ingested data. Change Data Capture (CDC) is one approach to implement data ingestion at low latency, which is suitable for near real-time data consumption.

**Quick access:**

- [Motivation](#motivation)
  - [Data Ingestion challenges](#data-ingestion-challenges)
  - [Event sourcing approach](#event-sourcing-approach)
- [Implementing CDC in the real world](#implementing-cdc-in-the-real-world)
- [Considering implementing CDC?](#considering-implementing-cdc)
  - [Benefits](#benefits)
    - [Reduced Latency](#reduced-latency)
    - [Simplified Change Tracking](#simplified-change-tracking)
    - [Enhance data security](#enhance-data-security)
  - [Drawbacks](#drawbacks)
    - [CDC per data source](#cdc-per-data-source)
    - [Data meaning](#data-meaning)
    - [Schema changes](#schema-changes)
- [CDC vs Event sourcing](#cdc-vs-event-sourcing)
  - [Shared Goals for Event Sourcing and Change Data Capture](#shared-goals-for-event-sourcing-and-change-data-capture)
  - [The differences](#the-differences)
- [Conclusion](#conclusion)
- [Reference](#reference)

## Motivation

### Data Ingestion challenges

![Changes from various sources](/assets/img/cdc-motivation.png){: .mx-auto.d-block :}

In our production environment, multiple applications and services contribute to the same database using a microservices architecture. This decentralized setup triggers the need for effective handling of database changes, especially when records are updated.

We want to capture and store all the changes in the production environment as soon as possible for downstream usage, such as real-time reporting, historical data analysis, data quality monitoring, etc. So how many ways can we do that?

Summarized from this [post](https://medium.com/the-modern-scientist/the-art-of-data-ingestion-powering-analytics-from-operational-sources-467552d6c9a2), the goal of data ingestion is to move data **from one or more sources to a destination** where it can be stored and further analyzed, specifically Data Platform. We have various ways to conduct data ingestion, the way we implement it depends on the use case and how performant we want it to be.

In the world of big data, two common approaches are:

- **Batch processing (ETL):** The data is collected, processed, and loaded into the destination in batches with scheduled intervals, usually at night when the system is not in use.

- **Stream processing (ELT):** All records produced in the production environment will be ingested into the destination as soon as possible before being transformed in further steps. This approach is suitable for use cases that require data to be instantly consumed.

![ETL vs ELT](/assets/img/cdc-etl-elt.png){: .mx-auto.d-block :}
<p align = "center">
ETL vs ELT (Source: <a href="https://medium.com/the-modern-scientist/the-art-of-data-ingestion-powering-analytics-from-operational-sources-467552d6c9a2"> Blog post</a>)
</p>

### Event sourcing approach

One of the most mature approaches to implementing real-time data ingestion is to use an event-driven architecture. The idea is to observe what is happening in the data layer of the applications, i.e., which data is changing as a result of business operations, and to capture that set of changes in a message.

![Event sourcing approach](/assets/img/cdc-event-driven.png){: .mx-auto.d-block :}

However, this requires extra efforts from the engineers to:

- Implement the publisher and integrate with a message broker.
- Maintain the consistency between two destinations.

To address these challenges and streamline our approach, Change Data Capture (CDC) pattern serves as a solution for efficiently monitoring alterations in data and triggering designated actions based on those changes. Whether it involves reading, updating, or deleting operations, CDC enables a unified and centralized mechanism for tracking and responding to modifications in the shared database.

By adopting CDC, we aim to enhance the manageability, consistency, and scalability of our system, providing a more cohesive and streamlined solution for handling data changes across our diverse range of applications and services.

## Implementing CDC in the real world

The idea of CDC is to observe what is happening in the data layer of the applications, i.e., which data is changing as a result of business operations, and to capture that set of changes in a message.

To implement the CDC, we will need to add two items in our pipeline:

- Service that listens for changes over rows in the database
- Service that streams the data

![Concept to implement CDC](/assets/img/cdc-concept.png)
<p align = "center">
Concept to implement CDC
</p>

The example below is a simple implementation of CDC using Debezium and Kafka. The service listens to the changes in the database and publishes the changes to Kafka.

![Apply CDC pattern with Debezium and Kafka.](/assets/img/cdc-general.png){: .mx-auto.d-block :}
<p align = "center">
Apply CDC pattern with Debezium and Kafka.
</p>

## Considering implementing CDC?

### Benefits

As well-listed in [this article](https://hevodata.com/learn/benefits-of-change-data-capture/#:~:text=CDC%20Definition,-Image%20Source&text=As%20a%20result%2C%20businesses%20use,replicate%20transactional%20changes%20to%20data.), the below are some key benefits I would like to bring on the table:

#### Reduced Latency

By capturing changes as they occur, CDC minimizes data latency compared to traditional batch processing. Since collection and transformation happens in real-time with CDC, organizations can store the data in data warehouses for better business intelligence. This is particularly advantageous for applications and analytics that require up-to-date information.

#### Simplified Change Tracking

CDC simplifies the tracking of changes in the source data. This includes capturing inserts, updates, and deletes, providing a comprehensive view of how the data evolves over time.

The database, which we listen to, remains intact as we do not add any triggers or log tables. So that we don't need to touch the legacy system since it's usually risky, sometime it leads to the performance degradation of the database.

#### Enhance data security

One of the great benefits of change data capture is that it empowers you to manage data accessibility as well. This enhances data security as you can control the flow of data based on the sensitivity of the collected information. Such practices ensure that you comply with the different data protection laws of different countries.

### Drawbacks

Along with the benefits, there are some drawbacks that we need to consider before implementing CDC.

#### CDC per data source

Each type of database requires a different approach to CDC. There are different mechanisms for each source and the cannot be unified for multiple sources with different characteristics.

As if we want to implement an in-house CDC solution, we need to implement a different solution for each data source, because each database has its own way of producing the change events.

For example, Debezium captures changes from MySQL by watching its [binlog](https://dev.mysql.com/doc/refman/5.7/en/replication-howto-masterbaseconfig.html), but for PostgreSQL the service listens to DB's [WaL (Write ahead Log)](https://www.postgresql.org/docs/9.6/runtime-config-wal.html) for replication, and many more connectors for other databases. (See [Debezium connectors](https://debezium.io/documentation/reference/connectors/index.html))

#### Data meaning

Relational database sources are often denormalized and modified to allow fast read or write operations based on concrete usage scenarios.

Capturing this kind of data may result in a hard-to-understand set of data, which is far away from the concept of a DTO.

On the other hand, many changes in database tables may not be related to the actual business logic triggering them, but to the maintenance operations or reporting activities. This creates noises.

#### Schema changes

Sometimes data source schema changes occur, CDC just keeps picking out the data change including new columns' values. Without being noticed or monitored, we cannot have full control over the data quality for the downstream tasks.

![Collaboration](https://images.unsplash.com/photo-1516321318423-f06f85e504b3?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMja3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fa%3D%3D)

## CDC vs Event sourcing

### Shared Goals for Event Sourcing and Change Data Capture

The two core services provided in this article are Event Sourcing and also Change Data Capture. Before introducing these 2 solutions, it can be recognized that they serve similar objectives, which are:

- Designate one datastore as the global source of truth for a specific set of data
- Provide a representation of past and current application state as a series of events, also called a journal or transaction log
- Offer a journal that can replay events, as needed, for rebuilding or refreshing state.

### The differences

| ATTRIBUTE | EVENT SOURCING | CDC |
| --- | --- | --- |
| Purpose | Capture state in a journal containing domain events. | Export Change Events from transaction log. |
| Event Type | Domain Event | Change Event |
| Source of Truth | Journal | Transaction Log |
| Boundary | Application | System |
| Consistency Model | N/A (only writing to the Journal) | Strongly Consistent (tables), Eventually Consistent (Change Event capture) |
| Replayability | Yes | Yes |

- Event Sourcing uses its **own journal** as the resource of reality, while Change Data Capture depends on the underlying **database transaction log** as the source of truth.
- Regarding boundary, Event Sourcing is an application-level pattern, while Change Data Capture is a system-level pattern.

## Conclusion

So we know that Change Data Capture pattern can tackle some of the problems as a framework to build a real-time data synchronization solution, which is a common requirement in many organizations, we also see plenty of drawbacks as well.

Building distributed event-driven systems is always challenging since Event Sourcing is a mature pattern and it is worth considering as the first move. Choose the right approach for your use case.

## Reference

- [Distributed Data for Microservices — Event Sourcing vs. Change Data Capture](https://debezium.io/blog/2020/02/10/event-sourcing-vs-cdc/)
- [Change Data Capture (CDC) - Pattern Or antipattern? – avenga](https://www.avenga.com/magazine/change-data-capture/)
- [Listen to Database changes with apache Kafka](https://medium.com/geekculture/listen-to-database-changes-with-apache-kafka-35440a3344f0)
- [Data Ingestion Patterns - Medium](https://medium.com/the-modern-scientist/the-art-of-data-ingestion-powering-analytics-from-operational-sources-467552d6c9a2)
- [Benefit of CDC](https://hevodata.com/learn/benefits-of-change-data-capture/#:~:text=CDC%20Definition,-Image%20Source&text=As%20a%20result%2C%20businesses%20use,replicate%20transactional%20changes%20to%20data.)
