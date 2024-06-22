---
layout: post
title: "My Journey as an MLOps Engineer"
subtitle: "Challenging but rewarding"
cover-img: /assets/img/mlops-cover.jpeg
thumbnail-img: /assets/img/mlops.jpeg
tags: [engineering, career, experience]
---

In today's data-driven world, the demand for machine learning models has skyrocketed, leading organizations to invest heavily in their AI capabilities. However, building and deploying machine learning models efficiently is not a straightforward task. This is where MLOps (Machine Learning Operations) engineers come into play. In this blog post, I will uncover my journey as an MLOps engineer so far and share some of the lessons I have learned along the way.

**Quick access:**

- [The Role of an MLOps Engineer](#the-role-of-an-mlops-engineer)
- [Day-to-Day Tasks as an MLOps Engineer](#day-to-day-tasks-as-an-mlops-engineer)
  - [Building Internal Platforms](#building-internal-platforms)
  - [Collaborating with Data Scientists](#collaborating-with-data-scientists)
  - [Infrastructure Management](#infrastructure-management)
  - [Continuous Integration and Deployment](#continuous-integration-and-deployment)
- [The challenges](#the-challenges)
- [Personal Observations](#personal-observations)
- [Which is the Better Way to Go: Dedicated vs Platform Oriented?](#which-is-the-better-way-to-go-dedicated-vs-platform-oriented)
  - [Dedicated Approach](#dedicated-approach)
  - [Platform Oriented Approach](#platform-oriented-approach)
- [Core Skills Set of an MLOps Engineer](#core-skills-set-of-an-mlops-engineer)
- [Conclusion](#conclusion)

## The Role of an MLOps Engineer

Let's revisit the definition of MLOps engineer. According to [Google](https://cloud.google.com/solutions/machine-learning/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning), MLOps engineers are responsible for the efficient development, deployment, and management of machine learning models. They play a vital role in ensuring the smooth integration of machine learning into the overall business operations. MLOps engineers combine their knowledge of data science, software engineering, and operations to create robust and scalable machine learning systems.

![ML Project stakeholders](/assets/img/ml-stakeholders.png){: .mx-auto.d-block :}

Ideally, to smoothly deliver a sustainable ML project, an MLOps engineer play a role who connects the dots across cell teams, such as orchestrating, deploying and monitoring data and ML models. However, due to maturity of each organization, some teams may not have the luxury of having a dedicated MLOps team, they prefer to have a Data Scientist or Data Engineer to take care of the whole ML project, including integrating MLOps tools to boost their productivity. In this case, we need a centralized platform that can serve stakeholders for specific purposes (build, serve, monitor,...), which is built by a standalone MLOps team, this is also my MLOps story.

## Day-to-Day Tasks as an MLOps Engineer

### Building Internal Platforms

One of the primary responsibilities is to design and build internal platforms to support the development and deployment of machine learning models. These platforms include:

- Feature Platform: An MLOps engineer develops a feature platform that allows data scientists to efficiently extract, transform, and manage features used in machine learning models. This platform enables feature engineering at scale and ensures data consistency across different models.

- MLOps Platform: MLOps engineers create an MLOps platform that facilitates the deployment, monitoring, and management of machine learning models in production. This platform automates tasks such as model versioning, model serving, and monitoring model performance, enabling seamless collaboration between data scientists and operations teams.

### Collaborating with Data Scientists

MLOps engineers work closely with data scientists to understand their requirements and translate them into scalable and reproducible machine learning pipelines. They help data scientists optimize their code, implement best practices, and ensure the models are production-ready. Collaboration between MLOps engineers and data scientists is essential for creating efficient machine learning workflows.

### Infrastructure Management

Managing the underlying infrastructure for machine learning projects is another crucial responsibility of an MLOps engineer. They configure and maintain scalable computing resources, containerization technologies, and orchestration systems. MLOps engineers optimize infrastructure to ensure efficient model training and deployment, considering factors like cost, performance, and scalability.

### Continuous Integration and Deployment

Beside of primary products, I also work on establishing robust CI/CD (Continuous Integration and Continuous Deployment) pipelines for internal platforms as well as machine learning projects. The pipelines automate the testing, integration, and deployment of internal SDK and models, ensuring rapid iteration and reducing time to productionization.

By establishing CI/CD pipelines, I enabled the team to deliver new features and updates more frequently, with higher quality and reliability. The pipelines also help identify and fix issues early in the development process, reducing the risk of errors in production.

## The challenges

Having your own product seems to be a dream for every engineer, but it's not always going in a happy way. I have to face a lot of challenges along the way, from technical to non-technical aspects.

## Personal Observations

Throughout my journey, I have observed that while technical skills are crucial, soft skills such as communication, collaboration, and adaptability play an equally important role. Being able to explain complex technical concepts to non-technical stakeholders and working collaboratively with cross-functional teams are essential for success in the MLOps field.

## Which is the Better Way to Go: Dedicated vs Platform Oriented?

This is a common question that many organizations face when implementing MLOps. Here are some points to consider:

### Dedicated Approach

- **Pros**:
  - Tailored solutions to specific problems.
  - Closer collaboration with data scientists and operations teams.
  - Faster iteration and experimentation.

- **Cons**:
  - Higher resource requirements.
  - Potential for siloed knowledge and expertise.

### Platform Oriented Approach

- **Pros**:
  - Centralized infrastructure and tools.
  - Easier to maintain and scale.
  - Promotes standardization and best practices.

- **Cons**:
  - May not be as flexible for specific use cases.
  - Requires significant upfront investment and planning.

Ultimately, the choice between a dedicated and platform-oriented approach depends on the specific needs and maturity of the organization. In my experience, a hybrid approach often works best, leveraging the strengths of both methods to create a flexible and scalable MLOps environment.

## Core Skills Set of an MLOps Engineer

![MLOps development lifecycle](https://ml-ops.org/img/mlops-loop-en.jpg){: .mx-auto.d-block :}
<p align = "center">
MLOps development lifecycle (Source: ml-ops.org)
</p>

Whoever you are working as, a dedicated engineer or a platform engineer, to excel in the role of an MLOps engineer, individuals should possess a diverse skill set to fulfill the above tasks cycle, including:

- Software Engineering Understanding: Proficiency in programming languages like Python, knowledge of software development methodologies, and experience with version control systems (e.g., Git) are essential.

- Strong Data Engineering: Understanding data pipelines, data storage, and data processing frameworks is crucial for building scalable and efficient feature engineering pipelines to serve offline and online ML models.

- DevOps: Familiarity with DevOps practices, including infrastructure provisioning, configuration management, and containerization technologies (e.g., Docker, Kubernetes), is necessary for managing the machine learning infrastructure.

- Machine Learning: be able to capture the foundation of machine learning concepts, model development, and evaluation techniques is essential to collaborate effectively with data scientists.

- Cloud Technologies: Experience with cloud platforms like AWS, Azure, or Google Cloud is advantageous. Knowledge of deploying and managing machine learning models in cloud environments is valuable.

## Conclusion

Being an MLOps engineer is a dynamic and challenging role that requires a blend of technical and soft skills. Whether you are building internal platforms, collaborating with data scientists, managing infrastructure, or establishing CI/CD pipelines, the goal is to enable efficient and scalable machine learning operations.

As organizations continue to adopt machine learning, the role of MLOps engineers will become increasingly critical. Embracing the challenges and continuously learning and adapting will pave the way for success in this exciting field.
