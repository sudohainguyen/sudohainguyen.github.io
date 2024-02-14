---
layout: post
title: "Lessons learned on contributing to Open Source projects"
subtitle: Why don't you try?
cover-img: /assets/img/passion.jpg
thumbnail-img: /assets/img/oss-thumbnail.jpeg
tags: [engineering, career, experience]
---

To rapidly progress in your engineering career, it is advisable to learn from other engineers in your professional circle, such as colleagues, seniors, and friends especially when you are working on some immature area like MLOps. However, many individuals, myself included, often wonder how engineers from diverse companies, organizations, and countries approach their work without frequently changing their jobs. Engaging with open-source projects is an effective solution to this challenge. By contributing to such projects, you can gain valuable exposure to a variety of engineering perspectives and practices, which can broaden your understanding and improve your skills.

**Quick access:**

- [What does the term Open Source projects mean?](#what-does-the-term-open-source-projects-mean)
- [Pros and Cons](#pros-and-cons)
  - [The opportunities](#the-opportunities)
  - [The challenges](#the-challenges)
- [How to get started?](#how-to-get-started)
- [Conclusion](#conclusion)

## What does the term Open Source projects mean?

![Unsplash](https://images.unsplash.com/photo-1569017388730-020b5f80a004?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80){: .mx-auto.d-block :}
<p align = "center">
Photo by <a href="https://unsplash.com/@lukesouthern?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Luke Southern</a> on <a href="https://unsplash.com/photos/4kCGEB7Kt4k?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>

</p>

Open source refers to software that is made freely available to the public, along with the underlying source code that is used to build the software. This means that anyone can access, modify, and distribute the software, provided they adhere to the conditions set out in the software's license agreement. The open source philosophy emphasizes collaboration, transparency, and community-driven development, with the goal of creating high-quality, accessible software that can be used and improved by anyone. Many popular MLOps tools and platforms, including [Airflow](https://github.com/apache/airflow), feature store [Feast](https://github.com/feast-dev/feast), and [MLFlow](https://github.com/mlflow/mlflow), are built on open source principles. Moreover, sometimes they power SaaS companies or cloud vendors to provide solution at scale, for example Tecton is built on top of Feast or AWS Redshift was originally Facebook's Presto.

## Pros and Cons

Working on open-source projects can be both rewarding and challenging. On the one hand, contributing to open-source projects provides an opportunity to gain real-world experience, exposure to industry-standard tools and technologies, and networking opportunities. On the other hand, it can be difficult to balance open source contributions with other commitments, the learning curve can be steep, and there may be conflicts and competing priorities to navigate.

### The opportunities

One of the biggest benefits of working on open-source projects is the opportunity to gain real-world experience. By actively contributing, you can work on real-world problems and gain practical experience that you might not be able to get through academic or personal projects alone. Additionally, open-source projects often use popular industry-standard tools and technologies, which can help you approach new knowledge with tools and technologies that are in demand in the job market.

In my own experience, I had a chance to learn about [Git Commit Principles](https://sudohainguyen.github.io/2022-10-22-git-commit-practice/) which helped me encourage my team to follow the convention so that our team repositories looked much cleaner and easier to onboard new members. Another experience is knowing how to set up a Python SDK with unit testing, CI/CD, code linting, installation guides and documentation, thanks to that I built a SDK for my projects and colleagues that effectively improve team productivity. Leveraging community resources can put your work in a higher quality and make you stand out from the crowd in the ogarnization.

### The challenges

Navigating open-source projects poses several challenges. These include juggling contributions alongside other commitments like work or personal projects. While involvement in community initiatives offers valuable experiences, it's crucial to prioritize primary employment, given its greater impact on career advancement and financial stability. Moreover, engaging in open-source endeavors can entail a steep learning curve, particularly for newcomers to the project or its technologies. Trying to absorb too much information at once can prove overwhelming and compromise workload management across different projects.

Furthermore, open-source environments often harbor multiple contributors, each with their own agendas and priorities. This can result in conflicts and divergent interests. Reflecting on past experiences, I devoted several days to refactoring modules within a project, only to find my pull request deemed unnecessary by project owners, ultimately languishing and becoming stale.

## How to get started?

Don’t pressure yourself into taking on overly ambitious tasks to build a new feature or fix critical bugs on the issue list, that would make you go nowhere in terms of either your learning or impact on the project. Instead, pick a project that is related to your daily basis tasks or maybe you are the actual user of the tools, this will help you have a good starting and a chance to deep dive into the underlying mechanism of the tool.

One of my very first open-source projects was Feast and at that time I was using it to build a feature engineering platform for my primary job. As a user, I discovered there are some functionalities that should be added and this is when I joined the project. As a result, I made a significant contribution by escalating Feast BigQuery offline store scalability by 10 times.

These are my suggestion to get your hands dirty in a new project:

1. Fork the repository to your own account and get yourself through Contribution guidelines. The document usually tells us about setting up development environment, and principles (e.g. naming convention, commit format,...).
2. Prepare your development environment, including the programming language version, lint check tools, and testing tools.
3. At all costs, try to run successfully every unit test without any significant errors.
4. (Optional) Go through examples to understand current functionalities if they are provided.

Now you are ready to start working on the project.

## Conclusion

Contributing to Open Source projects is not the silver bullet to build up yourself, this is just one of many ways to grow your skills. But if you want to get started, do it selectively and I believe it is still worth it to spend some effort, isn’t it?
