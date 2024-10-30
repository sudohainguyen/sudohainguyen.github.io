---
layout: post
title: "Why DBT and How Does It Help?"
subtitle: "Compared to Conventional Ways to Build Data Models"
cover-img: https://images.unsplash.com/photo-1631106254201-ffbee2305c5b?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
thumbnail-img: /assets/img/dbt-thumbnail.png
tags: [data engineering, data analytics]
---

You have probably heard the buzz about DBT in data engineering lately, but why was DBT even invented in the first place? I was struggling with pure SQL scripts but now I have been using it as my day-to-day work, let me share you how it’s revolutionizing the way we should build data models compared to the old-school methods.You have probably heard the buzz about DBT in data engineering lately, but why was DBT even invented in the first place? I was struggling with pure SQL scripts but now I have been using it as my day-to-day work, let me share you how it’s revolutionizing the way we should build data models compared to the old-school methods.

- [The Origins of DBT](#the-origins-of-dbt)
- [Key Features of DBT: Why It Stands Out](#key-features-of-dbt-why-it-stands-out)
  - [SQL-Based Transformations](#sql-based-transformations)
  - [Modular and Reusable Code](#modular-and-reusable-code)
  - [Simplified Data Persistence](#simplified-data-persistence)
  - [Snapshotting](#snapshotting)
- [Comparing DBT to Conventional Data Modeling Approaches](#comparing-dbt-to-conventional-data-modeling-approaches)
- [Common Misconceptions About DBT](#common-misconceptions-about-dbt)
- [Conclusion](#conclusion)

## The Origins of DBT

Before DBT, data practitioners had to wrestle with some pretty gnarly problems. Think about it: data pipelines were complex beasts, cobbled together with various tools that didn't always play nice with each other. The traditional Extract, Transform, Load (ETL) processes were a major headache, often requiring custom scripts and a lot of manual work.

This is where DBT (short for Data Build Tool) comes into play. Fishtown Analytics (now dbt Labs) created DBT to address these very issues. Their mission was clear: simplify data transformations and make the process more efficient and accessible. They envisioned a tool that would empower data analysts to handle data transformations using just SQL, the language they were already comfortable with.

## Key Features of DBT: Why It Stands Out

So, what makes DBT so special? Here are some of its standout features that I am impressed the most with:

### SQL-Based Transformations

DBT lets you write transformations in SQL, which means data analysts can jump right in without needing to learn a new language such as Python or Spark. It's like giving a carpenter a shiny new hammer—they already know how to use it, and now they can build even better things.

### Modular and Reusable Code

With DBT, you can structure your project into reusable models. This modularity means you can build complex transformations piece by piece, making your code cleaner and easier to maintain.

**Example**: Let's say you are looking for a complex SQL function that calculates the average order value for a given customer. Instead of writing the same function multiple times, you can create a reusable model in DBT. This model can be referenced in other models, and other folks on your team can use it without having to rewrite the same logic.

In the future, when the business requirements change, and you need to update the formula, you only need to do it in one place. This modular approach saves time and reduces human-prone errors.

### Simplified Data Persistence

One of the significant advantages for data analysts using DBT is the reduced need to worry about the specifics of persisting data models effectively. Analysts only need to understand the concept of materializations such as views, tables, and incremental models. The rest is handled by DBT plugins that run on top of SQL engines. This allows analysts to focus on transforming data rather than on the intricacies of data storage.

**Example**: Let's say you're an analyst who needs to create an incremental table for daily sales data. Without DBT, you'd have to write complex SQL scripts to manage incremental updates, ensuring only new data is processed and stored correctly. With DBT, you can define your models and specify them as incremental, and DBT takes care of the rest.

Before DBT, assume you'd need new updates to be upserted into a table called `incremental_sales`. Here's how you might write the SQL script manually:

```sql
create temp table as (
    with new_orders as (
    select * from orders
    where order_date > (select max(order_date) from incremental_sales)
    )
    select
    order_id,
    order_date,
    order_amount
    from new_orders
);
-- Upsert new data into the incremental_sales table
insert into incremental_sales
select * from temp_table
on conflict (order_id)
do update set
order_date = excluded.order_date,
order_amount = excluded.order_amount
```

Here's an example using DBT to create an incremental model:

```sql
-- models/incremental_sales.sql

with new_orders as (
    select * from {{ ref('orders') }}
    where order_date > (select max(order_date) from {{ this }})
)

select
    order_id,
    order_date,
    order_amount
from new_orders
```

In your `dbt_project.yml` file, you configure this model:

```yaml
models:
    my_dbt_project:
    incremental_sales:
        materialized: incremental
        incremental_strategy: upsert
        unique_key: order_id
```

With this setup, DBT ensures that the `incremental_sales` table is updated incrementally, only processing new orders based on the `order_date` field. This reduces the need for extensive SQL knowledge about managing incremental updates, letting you focus on analyzing and transforming the data.

### Snapshotting

Similarly to incremental strategy, DBT snapshot feature allows you to create a snapshot of your data at a specific point in time. This is useful when you need to track changes in your data over time, such as capturing historical data or auditing purposes.

SCD (Slowly Changing Dimension) is a common practice to build a snapshot table, you can still achieve this by pure SQL and Airflow, but it's more complex and error-prone. With DBT, you can easily create a snapshot model and let DBT handle the rest, DBT provides an abstraction that will perform SCD Type 2 for your tables.

And many more you can explore, such as **embracing collaboration**, **testable sql**, **version control**, **dependency management**, and **data lineage tracking** as described in the [DBT documentation](https://docs.getdbt.com/docs/introduction).

## Comparing DBT to Conventional Data Modeling Approaches

In the old days, **traditional ETL processes** were a nightmare. They were complex, rigid, and often required a lot of custom scripting. Maintenance was a pain, and scalability was a constant challenge.

In my previous company, we implemented tons of SQL scripts to transform data and it was hard to maintain all of them. When the performance issues arose in the data warehouse, we faced a lot of challenges to trace and capture query patterns, many SQL logic was duplicated and could have been reused, but we didn't have a good way to manage them.

![Deal with custom SQL](https://images.unsplash.com/photo-1517669375942-946a1f02d705?q=80&w=4888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D){: .mx-auto.d-block :}
<p align = "center">
Deal with ETL scripts. (Image by <a href="https://unsplash.com/@elevantarts">christopher lemercier</a>)
</p>

On the other hand, besides SQL scripts, we also used various tools like [Pandas](https://pandas.pydata.org/), [Spark](https://spark.apache.org/), or even custom scripts to transform data. Although these tools are powerful, they require a steep learning curve and are not always the best fit for data analysts/scientists who are more comfortable with SQL.

As **DBT's Approach**, it flips the script by focusing on SQL-based transformations. Instead of writing endless custom scripts, you can create incremental models and materializations that are easier to manage and optimize. Debugging is straightforward, and testing is built right into the workflow.

Unlike conventional SQL workflows, DBT promotes a **modular development** approach. You can break down your SQL into smaller, manageable modules. This not only makes the development process more organized but also enhances reusability and maintainability of the code across different projects or teams.

## Common Misconceptions About DBT

As with any popular tool, there are a few misconceptions about DBT that are worth clearing up. Let's tackle some of the most common ones:

- **DBT is Not a Database**: Some folks mistakenly believe that DBT is a database itself, where it would store and serve data as a server. In reality, DBT is a tool that works on top of your existing data warehouse and uses SQL to transform raw data into a more structured format, but it doesn't store data on its own.

- **DBT is Not a Data Transformation Engine**: Another common misconception is that DBT performs the actual data transformations. DBT orchestrates the transformations, but the heavy lifting is done by your data warehouse's SQL engine. For example, if you're using Snowflake, Redshift, or BigQuery, those platforms execute the SQL transformations defined by DBT.

- **DBT is Not a One-Size-Fits-All Solution**: While DBT is powerful, it might not be the best fit for every scenario. For example, if your data transformations require complex procedural logic that's difficult to express in SQL, you might need to complement DBT with other tools or custom scripts.

## Conclusion

In a nutshell, DBT was invented to tackle the common pain points in data transformation processes. By leveraging SQL, promoting modular code, integrating collaboration tools, and ensuring high data quality, DBT offers a fresh and efficient approach to building data models. Additionally, its ability to simplify data persistence allows data analysts to focus more on transforming data and less on storage details.

If you're still using conventional methods, it might be time to give DBT a try. Dive into the documentation, explore the community forums, and see how DBT can transform your data workflows.

Happy data modeling!
