---
layout: post
title: "Git commit convention: How to"
subtitle: "Use your daily basis to power up your team"
cover-img: /assets/img/git_screen.jpg
thumbnail-img: /assets/img/github.jpg
tags: [engineering, craftmanship]
---

If you've been actively using git in your daily work, you might be familiar with the concept of Git commit convention. However, have you considered the potential benefits these messages hold for your future and the success of your team? In this article, I will explain how incorporating Git commit convention into your everyday routine can greatly enhance your team's productivity.


## What does convention mean?

A "convention" refers to a set of agreed-upon guidelines or rules that govern the structure, format, and content of commit messages in a Git repository. These conventions aim to standardize the way developers communicate their changes and intentions when committing code.

## How about git commit convention?

When I introduce the concept of Git commit convention to my colleagues, they often ask me why it is necessary to follow a convention. They argue that it is not necessary to follow a convention because they can write whatever they want in their commit messages. However, I believe that following a convention is beneficial for both the individual and the team.

In terms of collaboration, by following a convention, engineers ensure consistency and clarity in their commit messages, making it easier for team members to understand and navigate the commit history. This consistency is particularly valuable when working in a collaborative environment or when reviewing and debugging code. It helps create a shared understanding among team members and improves the overall maintainability and readability of the codebase. Assuming that you are a developer who has just joined a new team, you will find it much easier to understand the codebase and get up to speed if the team has a convention in place. You will be able to quickly grasp the purpose of each commit and the changes it introduces, as well as the context in which it was made.

<p align = "center">
<img src = "https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3269&q=80">
</p>
<p align = "center">
Photo by <a href="https://unsplash.com/@cytonn_photography?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Cytonn Photography</a> on <a href="https://unsplash.com/photos/n95VMLxqM2I?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
  
</p>

On the other hand, when your team build a library, product, or service, it is important to have a release note each time a new version upcoming. By following a convention, you can easily generate a release note from the commit history. This is a great way to keep your users informed about the latest changes and improvements to your product or service.

## My favorite convention

```
<COMMIT_TYPE>: <COMMIT_MESSAGE> (<ISSUE_ID>)

- details 1
- details 2

Signed-off-by: <YOUR_NAME> <YOUR_EMAIL>
```

1. Generalize type of a specific commit by using prefix. For example: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, etc...
2. Use imperative mood: Start your commit message with an imperative verb such as "Add", "Update", "Fix", "Refactor", etc. This helps to clarify the purpose of the commit.
3. Use the body for details: If you need to provide more information about the commit, use the body section to provide details. Use bullet points if necessary.
4. Use the present tense: Use the present tense when describing what the commit does, as if you were telling someone what the code currently does.
5. Reference related issues: If your commit relates to an issue or bug, reference it in the commit message using the issue number or link. (could be either Jira ticket or repo issue)
6. Sign off your commit: If you are contributing to an open-source project, it's important to sign off your commit using your full name and email address. This helps to track who contributed to the project.

Let's see what I can do with the above rules, imagine I have these commit messages after running command `git log --pretty=format:"%s" HEAD~10..HEAD`

```
chore: minor refactor
test: add test case for gcs dest path builder
chore: refactor mmfp modules
test: add local engine test cases
feat: prepare for 0.3.2 version
fix: hotfix on feature service logic
chore: minor refactor
feat: implement feature service
test: add test case for gcs dest path builder
chore: refactor mmfp modules
feat: add local engine string utils
fix: check fast lane by tag type
test: add engine factory test cases
chore: remove unused modules
fix: no global before_script in ci
fix: coverage report
```

And now I have this script, which is a simple python script to generate release note from the commit history.

```python
def generate_release_note(commit_messages):
    commit_types = {
        "feat": "Feature",
        "fix": "Bug Fixes"
    }

    commit_data = {
        "Feature": [],
        "Bug Fixes": [],
        "Stuff": []
    }

    for message in commit_messages:
        commit_type, commit_description = message.split(": ", 1)
        commit_category = commit_types.get(commit_type, "Stuff")
        commit_data[commit_category].append(commit_description)

    release_note = ""

    for category, commits in commit_data.items():
        if commits:
            release_note += f"### {category}\n\n"
            for commit in commits:
                release_note += f"- {commit}\n"
            release_note += "\n"

    return release_note
```

And this is the result:

``` markdown
### Feature

- prepare for 0.3.2 version
- implement feature service
- add local engine string utils

### Bug Fixes

- hotfix on feature service logic
- check fast lane by tag type
- no global before_script in ci
- minor fixes

### Stuff

- prepare for 0.3.2 version
- remove unused modules
- minor refactor
- add test case for gcs dest path builder
- refactor mmfp modules
- add local engine test cases
- add engine factory test cases
```


## Conclusion
This maybe look simple but it is a good start to build up your team's culture, furthermore it might boost your team productivity as well. I hope you can find this article useful and apply it to your daily basis. Thanks for reading!
