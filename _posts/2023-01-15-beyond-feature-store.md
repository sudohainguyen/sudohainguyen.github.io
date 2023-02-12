---
layout: post
title: "Beyond Feature Store: What we all desire. - Part 1"
subtitle: Yes, we need Feature Store, how to use?
tags: [mlops,data engineering]
---

## Quick rewind

Ok first let's go through what we already know about feature store.

<p align = "center">
<img src = "https://en.meming.world/images/en/7/7a/It%27s_Rewind_time.jpg">
</p>
<p align = "center">
It's rewind time.
</p>


### What are the features in Machine Learning?

As we know, features are characteristic of a specific entity (user, merchant, promotion, etc..) in the real world at a specific time. Features can be derived from raw data and transformed in various ways, such as scaling, normalization, or aggregation, to improve the quality and consistency of the data.

Features play a crucial role in machine learning, they expose complex patterns from entities, such as user transaction behaviour, for ML models to learn and make predictions. The quality of features mostly has a major impact on the performance of a model. We obviously met this term `Garbage in garbage out` since the day we involved in the ML world.

As a result, Data Scientists usually spend significant time and effort, back and forth selecting and engineering features.
  
### So, What is the feature store?
Simple, a feature store is where all features are defined, stored, and can be served from as a centralized place. In general, it brings more ability and benefits to the team as well as leadership in terms of:

1. Data storage: A centralized place to store features, produced from other upstream data sources. The data source can be either relational databases or distributed data storage systems, such as Hadoop or Spark. Feature store streamlines the operations to get raw data ready for being processed and transformed into features.
2. Feature management: Tools for organizing, versioning, and managing features, including the ability to track changes and compare versions of features. `feature discovery` and `feature registry` help team members can explore, comprehend, and reuse features were built by each other, which save dedicated work from the members and reduce duplicated data produced by individuals. Meanwhile, intergrating consistent materialization flow from feature store is also supported in a good practice accross team.
3. Collaborative feature engineering: The ability to conduct customization on features transformation and computations to extend existing features to build more advanced features for the team.
4. Feature access and retrieval: Interfaces are provided to easily retrieve features for batch processing or in low-latency for (near) real-time prediction based on a particular situation. 
5. Monitoring and performance: Tools for monitoring the performance of features, including metrics such as feature usage, processing times, and model accuracy.


Consequently, the team can have more capable of focusing on other critical parts. For example:

1. Data governance: more well-organized data from feature store helps the organization to keep track of data access and permissions, including the ability to enforce security and privacy policies.
2. Business analysis: 


It is gaining attraction from organizations to implement it into their ML systems, but most of the time there is still a struggle that stakeholders find hard to start implementing. I believe these are also 

