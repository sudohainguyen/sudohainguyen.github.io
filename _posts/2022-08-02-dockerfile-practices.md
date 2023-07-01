---
layout: post
title: "Dockerfile practices"
subtitle: "Power your application with well built Docker images"
cover-img: /assets/img/containers.jpg
thumbnail-img: https://images.unsplash.com/photo-1509966756634-9c23dd6e6815?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1676&q=80
share-img: /assets/img/containers.jpeg
tags: [mlops,engineering]
---

Docker has revolutionized the way we build, package, and deploy applications. It provides a lightweight and portable platform that enables developers to create isolated containers, encapsulating applications and their dependencies. One of the key components of Docker is the Dockerfile, a simple yet powerful tool for defining and automating the creation of Docker images.

In this post, we'll explore some best practices for writing Dockerfiles that will help you build better images and also share my own experience in building Docker images for my **Python** projects.

# 1. Background

## 1.1. What is a Dockerfile?

A Dockerfile is a text file used to define the steps and instructions for building a Docker image. It serves as a blueprint that automates the creation of a container image by specifying the base image, adding dependencies, copying files, and executing commands. With a Dockerfile, developers can easily reproduce and share consistent environments, enabling efficient application deployment across different platforms and environments.

## 1.2. Why is it important to build a good image?

A Docker image is a lightweight, standalone, and executable package that includes everything needed to run a piece of software, including the code, dependencies, and configurations. It is the foundation of a container, which is a virtualized environment that runs on top of the host operating system. A good image will ensure that your application runs smoothly and efficiently in a containerized environment.

The common issues that arise from poorly built images are:
- **Large image size**: Inefficiently built Docker images can result in unnecessarily large file sizes, leading to slower image downloads, increased storage requirements, and longer deployment times. This can impact overall performance and scalability.
- **Lack of reproducibility**: When images lack proper version control and documentation, it becomes challenging to reproduce the exact environment needed for consistent deployments. This can lead to inconsistencies, compatibility issues, and difficulties in debugging and troubleshooting.
- **Security vulnerabilities**: Images that are not properly secured can expose sensitive data and lead to security breaches. This can result in data loss, downtime, and reputational damage.
- **Poor performance**: Images that are not optimized for performance can lead to slow application response times, increased resource usage, and higher costs. This can impact user experience and increase operational costs.

# 2. Dockerfile Practices
In this section, we'll explore some best practices for writing Dockerfiles that will help you build better images.

## 2.1. Use a base image
Begin with a minimal foundational image that includes only the essential dependencies required by your application. By utilizing a smaller image, you can decrease the overall image size and enhance the startup time of your application.

Instead of:
``` Dockerfile
FROM python:3.9
...
```

Explicitly specify the base image with suffix:
``` Dockerfile
FROM python:3.9-slim
...
```

Some common base image types include:
- **Slim**: The "slim" base image is a lightweight Debian-based image stripped of unnecessary packages, resulting in smaller image sizes.
  - Pros: Smaller size, familiar Debian environment.
  - Cons: Limited package availability compared to full Debian images.

- **Alpine**: Alpine is a minimalistic Linux distribution with a small footprint.
  - Pros: Extremely small size, good for lightweight and efficient containers.
  - Cons: May require additional steps for compatibility with certain software and libraries.

- **Buster**: "Buster" is the codename for Debian 10, a stable Linux distribution.
  - Pros: Stable and widely supported, extensive package availability. 
  - Cons: Larger size compared to Alpine, potentially slower startup times.

- **Bullseye**: "Bullseye" is the codename for Debian 11, another Linux distribution.
  - Pros: Focuses on up-to-date software packages with improved hardware support and newer kernel.
  - Cons: Some packages may still be undergoing stability testing. There will be potentially compatibility issues with older software or libraries that are not updated for Debian 11.

My favourite base image type for building complex applycation is `buster` due to its stability and extensive package availability. Compared to `bullseye`, `buster` is more stable and has more packages available. However, if you are building a lightweight application, `alpine` is a good choice.

## 2.2. Leverage layer caching

In Docker, each instruction in a Dockerfile creates a new layer in the image. When building an image, Docker will cache the results of each instruction and reuse them for subsequent builds. This can significantly improve build times, especially when building images with many layers.

Docker's documentation highlighted the importance of layer caching:

> Once a layer changes, all downstream layers have to be recreated as well.

Let's say we have a Dockerfile to build an image for FastAPI application:

``` Dockerfile
FROM python:3.9-slim
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "app.main:app"]
```

This does not reuse cached layers at all, every time we change the code, we have to rebuild the image from scratch. This is not ideal for deployment. Actually, the code changes more frequently than the dependencies, so we can first build up the dependencies layer, then copy the code and build the application layer.

``` Dockerfile
FROM python:3.9-slim
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["uvicorn", "app.main:app"]
```

## 2.3. Use multi-stage builds

The multi-stage Dockerfile allows you to separate the build environment from the production environment. The build stage is used to install dependencies and build the application, while the production stage only includes the necessary dependencies and the application code. This helps reduce the size of the final Docker image and improves security by excluding unnecessary build tools from the production environment.

Example:

``` Dockerfile
# Stage 1: Build stage
FROM python:3.9 AS builder

WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Stage 2: Production stage
FROM python:3.9-slim

WORKDIR /app

# Copy installed dependencies from the builder stage
COPY --from=builder /root/.local /root/.local

# Set environment variables
ENV PATH=/root/.local/bin:$PATH
ENV PYTHONUNBUFFERED=1

# Expose port
EXPOSE 5000

# Copy application code
COPY . .

# Set the startup command
CMD ["python", "app.py"]
```

The first stage (builder) installs the dependencies specified in the requirements.txt file using pip. It copies the application code into the image.

The second stage (production) uses a slim Python base image (python:3.9-slim). It copies the installed dependencies from the builder stage. It sets the necessary environment variables, exposes port 5000 (assuming your Flask app runs on that port), copies the application code, and sets the startup command to run the app.py file.

## 2.4. Don't include unnecessary files

You actually don't need all the files in your codebase to run your application. For example, you don't need the test files, the documentation, the development environment, etc. Always try adding neccessary files only by specifying your `COPY` statements.

Don't:

``` Dockerfile
FROM python:3.9-slim
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "app.main:app"]
```

Do:

``` Dockerfile
FROM python:3.9-slim
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY app.py app.py
COPY modules/ modules/
CMD ["uvicorn", "app.main:app"]
```

or else if you have a lot of files to copy, you can use `.dockerignore` file to ignore unnecessary files with patterns.

```
# .dockerignore
tests/
docs
.env.*
```


## 2.5. Some other minor tips

### Assign explicitly tags to images

Don't:

``` Dockerfile
FROM company/image_name:latest
```

Do:

``` Dockerfile
FROM company/image_name:version
```

### Grouping related operations

Sometimes you will need to install additional tools or packages to build your Python application (from apt-get or external resources). It is recommended to group these operations together to avoid unnecessary layers.

Don't:

``` Dockerfile
FROM python:3.9-buster
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y curl
RUN pip install -r requirements.txt
```

Do:

``` Dockerfile
FROM python:3.9-buster
RUN apt-get update && apt-get install -y \
    build-essential \
    curl
RUN pip install -r requirements.txt
```

### Try not to expose root user

By default, Docker runs containers as the root user. To improve security, create a dedicated user for running your application within the container and switch to that user using the USER instruction.

Don't:

``` Dockerfile
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Run the application
CMD ["python3", "app.py"]
```

Do:

``` Dockerfile
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Create a non-root user
RUN groupadd -r myuser && useradd -r -g myuser myuser

# Set ownership and permissions
RUN chown -R myuser:myuser /app

# Switch to the non-root user
USER myuser

# Run the application
CMD ["python3", "app.py"]
```

# 3. Working with Dockerfiles effectively

## 3.1. Use linting tools


## 3.2. Evaluate your changes
After applying good practices to improve your Dockerfiles, how can you know your changes are effective?
One of my favourite tool is [dive](https://github.com/jauderho/dive), which measure the efficiency of your Dockerfile by analyzing the image layer by layer, displaying the file tree and highlighting the files that are taking up the most space.

# 4. Conclusion

Hope this can give you some idea to improve your Dockerfiles, you can ensure that your images are optimized for performance, security, and scalability. This will help you create better applications and save your own time and effort in the long run.

# References
- [https://docs.docker.com/get-started/09_image_best/](https://docs.docker.com/get-started/09_image_best/)
- [https://medium.com/@rdsubhas/docker-for-development-common-problems-and-solutions-95b25cae41eb](https://medium.com/@rdsubhas/docker-for-development-common-problems-and-solutions-95b25cae41eb)
- [https://pythonspeed.com/articles/base-image-python-docker-images/](https://pythonspeed.com/articles/base-image-python-docker-images/)
- [https://github.com/wagoodman/dive](https://github.com/wagoodman/dive)
