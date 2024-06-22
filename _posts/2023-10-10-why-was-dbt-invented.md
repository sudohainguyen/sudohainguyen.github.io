---
layout: post
title: "Why DBT Was Invented and How It Helps Data Practitioners"
subtitle: "Compared to Conventional Ways to Build Data Models"
cover-img: https://images.unsplash.com/photo-1631106254201-ffbee2305c5b?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
thumbnail-img: https://images.unsplash.com/photo-1631106254201-ffbee2305c5b?q=80&w=2370&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
tags: [data engineering, data analytics]
---

If you've been hanging around the data engineering world, you've probably heard the buzz about DBT. But what's all the fuss about, and why was DBT even invented in the first place? Let's dive into the story behind DBT and how it's revolutionizing the way we build data models compared to the old-school methods.

## The Origins of DBT

Before DBT, data practitioners had to wrestle with some pretty gnarly problems. Think about it: data pipelines were complex beasts, cobbled together with various tools that didn't always play nice with each other. The traditional Extract, Transform, Load (ETL) processes were a major headache, often requiring custom scripts and a lot of manual work.

This is where DBT (short for Data Build Tool) comes into play. Fishtown Analytics (now dbt Labs) created DBT to address these very issues. Their mission was clear: simplify data transformations and make the process more efficient and accessible. They envisioned a tool that would empower data analysts to handle data transformations using just SQL, the language they were already comfortable with.

## Key Features of DBT: Why It Stands Out

So, what makes DBT so special? Here are some of its standout features:

- **SQL-Based Transformations**: DBT lets you write transformations in SQL, which means data analysts can jump right in without needing to learn a new language such as Python or Spark. It's like giving a carpenter a shiny new hammer—they already know how to use it, and now they can build even better things.

- **Modular and Reusable Code**: With DBT, you can structure your project into reusable models. This modularity means you can build complex transformations piece by piece, making your code cleaner and easier to maintain.

    **Example**: Let's say you are looking for a complex SQL function that calculates the average order value for a given customer. Instead of writing the same function multiple times, you can create a reusable model in DBT. This model can be referenced in other models, and other folks on your team can use it without having to rewrite the same logic.

    In the future, when the business requirements change, and you need to update the formula, you only need to do it in one place. This modular approach saves time and reduces human-prone errors.

- **Collaboration**: DBT integrates seamlessly with Git, so collaborative work is built right in. No more worrying about who made what changes and when—everything is tracked, and multiple team members can work together smoothly.

- **Testing and Documentation**: DBT includes a built-in testing framework to ensure your data quality remains top-notch. Plus, it can automatically generate documentation, making it easier to understand and share your data models.

- **Simplified Data Persistence**: One of the significant advantages for data analysts using DBT is the reduced need to worry about the specifics of persisting data models effectively. Analysts only need to understand the concept of materializations—such as views, tables, and incremental models. The rest is handled by DBT plugins that run on top of SQL engines. This allows analysts to focus on transforming data rather than on the intricacies of data storage.

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
    order_amount = excluded.order_amount;
    ```

    Here's an example using DBT to create an incremental model:

    ```sql
    -- models/incremental_sales.sql
    {{
      config(
        materialized='incremental',
        incremental_strategy='upsert',
        unique_key='order_id'
      )
    }}

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
    ```

    With this setup, DBT ensures that the `incremental_sales` table is updated incrementally, only processing new orders based on the `order_date` field. This reduces the need for extensive SQL knowledge about managing incremental updates, letting you focus on analyzing and transforming the data.

## Comparing DBT to Conventional Data Modeling Approaches

Let's take a look at how DBT stacks up against traditional methods:

- **Traditional ETL Tools**: In the old days, ETL processes were a nightmare. They were complex, rigid, and often required a lot of custom scripting. Maintenance was a pain, and scalability was a constant challenge.

    In my previous company, we implemented tons of SQL scripts to transform data and it was hard to maintain all of them. When the performance issues arose to the data warehouse, we faced a lot of challenges to trace and capture queries patterns, many SQL logic was duplicated and could have been reused, but we didn't have a good way to manage them.

![Deal with custom SQL](https://images.unsplash.com/photo-1517669375942-946a1f02d705?q=80&w=4888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D){: .mx-auto.d-block :}
<p align = "center">
Deal with custom SQL. (Image by <a href="https://unsplash.com/@elevantarts">christopher lemercier</a> on Unsplash)
</p>

- **DBT's Approach**: DBT flips the script by focusing on SQL-based transformations. Instead of writing endless custom scripts, you can create incremental models and materializations that are easier to manage and optimize. Debugging is straightforward, and testing is built right into the workflow.

- **Modular Development**: Unlike conventional ETL tools, DBT promotes a modular development approach. You can break down your data transformation processes into smaller, manageable pieces. This not only makes the development process more organized but also enhances reusability and maintainability of the code.

## Common Misconceptions About DBT

As with any popular tool, there are a few misconceptions about DBT that are worth clearing up. Let's tackle some of the most common ones:

- **DBT is Not a Database**: Some people mistakenly believe that DBT is a database itself. In reality, DBT is a transformation tool that works on top of your existing data warehouse. It uses SQL to transform raw data into a more structured format, but it doesn't store data on its own.

- **DBT is Not a Data Transformation Engine**: Another common misconception is that DBT performs the actual data transformations. DBT orchestrates the transformations, but the heavy lifting is done by your data warehouse's SQL engine. For example, if you're using Snowflake, Redshift, or BigQuery, those platforms execute the SQL transformations defined by DBT.

- **DBT is Not a Data Visualization Tool**: DBT helps you prepare and clean your data, but it's not designed for data visualization. Tools like Tableau, Looker, or Power BI are used for visualizing the data models that DBT helps create.

- **DBT is Not a One-Size-Fits-All Solution**: While DBT is powerful, it might not be the best fit for every scenario. For example, if your data transformations require complex procedural logic that's difficult to express in SQL, you might need to complement DBT with other tools or custom scripts.

## Conclusion

In a nutshell, DBT was invented to tackle the common pain points in data transformation processes. By leveraging SQL, promoting modular code, integrating collaboration tools, and ensuring high data quality, DBT offers a fresh and efficient approach to building data models. Additionally, its ability to simplify data persistence allows data analysts to focus more on transforming data and less on storage details.

If you're still using conventional methods, it might be time to give DBT a try. Dive into the documentation, explore the community forums, and see how DBT can transform your data workflows. Trust me, once you go DBT, you'll never want to go back.

## Further Resources

- [DBT Documentation](https://docs.getdbt.com/)
- [DBT Tutorials](https://docs.getdbt.com/tutorial/setting-up)
- [DBT Community](https://community.getdbt.com/)

Happy data modeling!
